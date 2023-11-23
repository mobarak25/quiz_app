import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:quiz_app/core/error/custom_error.dart';
import 'package:quiz_app/core/error/custom_exception.dart';
import 'package:quiz_app/core/ioc/ioc.dart';
import 'package:quiz_app/core/navigator/iflutter_navigator.dart';
import 'package:quiz_app/core/utils/utilities.dart';
import 'package:quiz_app/features/data/data_sources/local_keys.dart';
import 'package:quiz_app/features/domain/entities/entity_map/entity_map.dart';
import 'package:quiz_app/features/domain/repositories/local_storage_repo.dart';

const fetchDataException = 'Failed To Fetch Data';

class RemoteGatewayBase {
  const RemoteGatewayBase();

  LocalStorageRepo get _localStorageRepo => getIt<LocalStorageRepo>();

  Future<T?> getMethod<T, K>({required String endpoint}) async {
    dynamic responseJson;
    final headers = _createHeaders();
    try {
      final response =
          await http.get(Uri.parse(endpoint) /*, headers: headers*/);
      responseJson = _handleHTTPResponse(response);
      if (responseJson != null) {
        return fromJson<T, K>(responseJson);
      }
    } on SocketException {
      FetchDataException(
          CustomError(message: fetchDataException), getIt<IFlutterNavigator>());
      //Implement pending response system by push notification. Or we can send a GUID withing the api,
      //and the GUID will store to local, while the connectivity available the api will call again
    }
    return null;
  }

  Future<T?> postMethod<T, K>(
      {required String endpoint, dynamic data, String? token}) async {
    dynamic responseJson;
    final headers = _createHeaders(token: token);
    try {
      final body = json.encode(data);

      final response =
          await http.post(Uri.parse(endpoint), headers: headers, body: body);

      responseJson = _handleHTTPResponse(response);

      if (responseJson != null) {
        return fromJson<T, K>(responseJson);
      }
    } on SocketException {
      FetchDataException(
          CustomError(message: fetchDataException), getIt<IFlutterNavigator>());
      //Implement pending response system by push notification. Or we can send a GUID withing the api,
      //and the GUID will store to local, while the connectivity available the api will call again
    }
    return null;
  }

  Future<T?> multiPartMethod<T, K>(
      {required String endpoint,
      Map<String, String>? data,
      List<ImageFile>? files,
      String? token}) async {
    dynamic responseJson;
    final headers = _createHeaders(token: token);

    try {
      final request = http.MultipartRequest('POST', Uri.parse(endpoint));
      request.headers.addAll(headers!);

      if (data != null) {
        request.fields.addAll(data);
      }

      for (int i = 0; i < files!.length; i++) {
        final file = await http.MultipartFile.fromPath(
            files[i].name, files[i].file.path);
        request.files.add(file);
      }

      final response = await request.send();
      responseJson = await _handleStreamResponse(response);

      if (responseJson != null) {
        return fromJson<T, K>(responseJson);
      }
    } on SocketException {
      FetchDataException(
          CustomError(message: fetchDataException), getIt<IFlutterNavigator>());
      //Implement pending response system by push notification. Or we can send a GUID withing the api,
      //and the GUID will store to local, while the connectivity available the api will call again
    }
    return null;
  }

  Future<T?> postUrlEncodeMethod<T, K>(
      {required String endpoint, dynamic data}) async {
    final fullEndpoint = endpoint;

    dynamic responseJson;
    final headers = _createHeadersUrlEncode();
    try {
      final response = await http.post(Uri.parse(fullEndpoint),
          headers: headers, body: data);

      responseJson = _handleHTTPResponse(response);

      if (responseJson != null) {
        return fromJson<T, K>(responseJson);
      }
    } on SocketException {
      FetchDataException(
          CustomError(message: fetchDataException), getIt<IFlutterNavigator>());
      //Implement pending response system by push notification. Or we can send a GUID withing the api,
      //and the GUID will store to local, while the connectivity available the api will call again
    }
    return null;
  }

  Map<String, String>? _createHeaders({String? token}) {
    return <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer ${token ?? _localStorageRepo.read(key: tokenDB) ?? ''}',
    };
  }

  Map<String, String>? _createHeadersUrlEncode() {
    return <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    };
  }

  dynamic _handleHTTPResponse(http.Response response) {
    return _handleResponse(response.statusCode, response.body);
  }

  _handleStreamResponse(http.StreamedResponse response) async {
    final responseData = await response.stream.toBytes();
    final responseString = String.fromCharCodes(responseData);

    return _handleResponse(response.statusCode, responseString);
  }

  _handleResponse(int statusCode, String body) {
    // print(statusCode);
    // log(body);
    final navigator = getIt<IFlutterNavigator>();

    switch (statusCode) {
      case 200:
        return json.decode(body);
      case 400:
      case 404:
        NotFoundException(error(body), navigator);
        break;
      case 401:
        UnauthorizedException(error(body), navigator, _localStorageRepo);
        break;
      case 403:
        UnauthorizedException(error(body), navigator, _localStorageRepo);
        break;
      case 422:
        InvalidInputException(error(body), navigator);
        break;
      case 500:
      default:
        FetchDataException(
            CustomError(
                message:
                    'An error occurred while communicating with the server with StatusCode $statusCode'),
            navigator);
        break;
    }
  }

  CustomError error(String body) {
    return CustomError.fromJson(jsonDecode(body));
  }

  static T fromJson<T, K>(dynamic json) {
    if (json is Iterable) {
      return _fromJsonList<K>(json) as T;
    }
    return EntityMap.fromJson<T, K>(json) as T;

    // final classMirror = reflector.reflectType(T) as ClassMirror;
    // final data = classMirror.newInstance("fromJson", [json]);
    // return data as T;
  }

  static List<K>? _fromJsonList<K>(Iterable<dynamic> jsonList) {
    return jsonList.map<K>((dynamic json) => fromJson<K, void>(json)).toList();
  }
}
