import 'package:injectable/injectable.dart';
import 'package:quiz_app/core/error/custom_error.dart';
import 'package:quiz_app/core/error/custom_exception.dart';
import 'package:quiz_app/core/ioc/ioc.dart';
import 'package:quiz_app/core/navigator/iflutter_navigator.dart';
import 'package:quiz_app/core/network_info/network_info.dart';
import 'package:quiz_app/core/utils/utilities.dart';
import 'package:quiz_app/features/data/data_sources/remote_gateway_base.dart';
import 'package:quiz_app/features/domain/repositories/api_repo.dart';

const String noInternetConnection = 'No Internet Connection';

@LazySingleton(as: ApiRepo)
class ApiRepoImpl extends RemoteGatewayBase implements ApiRepo {
  const ApiRepoImpl(this.networkInfo);

  final NetworkInfo networkInfo;

  @override
  Future<T?> post<T>(
      {required String endpoint, dynamic body, String? token}) async {
    dynamic data;

    if (await networkInfo.isConnected) {
      data = await postMethod<T, void>(
          endpoint: endpoint, data: body, token: token);
    } else {
      AppException(CustomError(message: noInternetConnection),
          getIt<IFlutterNavigator>());
    }
    return data;
  }

  @override
  Future<T?> postForList<T, K>(
      {required String endpoint, dynamic body, String? token}) async {
    dynamic data;

    if (await networkInfo.isConnected) {
      data =
          await postMethod<T, K>(endpoint: endpoint, data: body, token: token);
    } else {
      AppException(CustomError(message: noInternetConnection),
          getIt<IFlutterNavigator>());
    }
    return data;
  }

  @override
  Future<T?> get<T>({required String endpoint, body, String? token}) async {
    dynamic data;
    if (await networkInfo.isConnected) {
      data = await getMethod<T, void>(endpoint: endpoint);
    } else {
      AppException(CustomError(message: noInternetConnection),
          getIt<IFlutterNavigator>());
    }
    return data;
  }

  @override
  Future<T?> getForList<T, K>(
      {required String endpoint, dynamic body, String? token}) async {
    dynamic data;
    if (await networkInfo.isConnected) {
      data = await getMethod<T, K>(endpoint: endpoint);
    } else {
      AppException(CustomError(message: noInternetConnection),
          getIt<IFlutterNavigator>());
    }
    return data;
  }

  @override
  Future<T?> multipart<T, K>(
      {required String endpoint,
      Map<String, String>? body,
      List<ImageFile>? files,
      String? token}) async {
    dynamic data;

    if (await networkInfo.isConnected) {
      data = await multiPartMethod<T, K>(
          endpoint: endpoint, data: body, files: files, token: token);
    } else {
      AppException(CustomError(message: noInternetConnection),
          getIt<IFlutterNavigator>());
    }
    return data;
  }

  @override
  Future<T?> postUrlEncode<T>({required String endpoint, dynamic body}) async {
    dynamic data;

    if (await networkInfo.isConnected) {
      data = await postUrlEncodeMethod<T, void>(endpoint: endpoint, data: body);
    } else {
      AppException(CustomError(message: noInternetConnection),
          getIt<IFlutterNavigator>());
    }
    return data;
  }
}
