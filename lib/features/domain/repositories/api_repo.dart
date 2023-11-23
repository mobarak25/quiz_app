import 'package:quiz_app/core/utils/utilities.dart';

abstract class ApiRepo {
  Future<T?> post<T>({required String endpoint, dynamic body, String? token});

  Future<T?> postForList<T, K>(
      {required String endpoint, dynamic body, String? token});

  Future<T?> get<T>({required String endpoint, dynamic body, String? token});

  Future<T?> getForList<T, K>(
      {required String endpoint, dynamic body, String? token});

  Future<T?> multipart<T, K>(
      {required String endpoint,
      Map<String, String>? body,
      List<ImageFile> files,
      String? token});

  Future<T?> postUrlEncode<T>({required String endpoint, String body});
}
