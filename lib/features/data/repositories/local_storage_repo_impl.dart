import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/features/data/data_sources/remote_gateway_base.dart';
import 'package:quiz_app/features/domain/repositories/local_storage_repo.dart';

@LazySingleton(as: LocalStorageRepo)
class LocalStorageRepoImpl implements LocalStorageRepo {
  LocalStorageRepoImpl(this.storage);

  final GetStorage storage;

  @override
  Future<void> write({required String key, required String value}) async {
    await storage.write(key, value);
  }

  @override
  Future<void> writeModel({required String key, required dynamic value}) async {
    await storage.write(key, jsonEncode(value));
  }

  @override
  String? read({required String key}) {
    return storage.read(key);
  }

  @override
  Future<T?> readModel<T>({required String key}) async {
    dynamic data;
    final json = await storage.read(key);
    if (json != null) {
      data = RemoteGatewayBase.fromJson<T, void>(jsonDecode(json));
    }
    return data;
  }

  @override
  Future<T?> readModelForList<T, K>({required String key}) async {
    dynamic data;
    final json = await storage.read(key);
    if (json != null) {
      data = RemoteGatewayBase.fromJson<T, K>(jsonDecode(json));
    }
    return data;
  }

  @override
  Future<void> remove({required String key}) async {
    await storage.remove(key);
  }

  @override
  void removeAll() {
    storage.erase();
  }
}
