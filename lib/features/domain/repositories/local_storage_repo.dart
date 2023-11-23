abstract class LocalStorageRepo {
  Future<void> write({required String key, required String value});
  Future<void> writeModel({required String key, required dynamic value});
  String? read({required String key});
  Future<T?> readModel<T>({required String key});
  Future<T?> readModelForList<T, K>({required String key});
  Future<void> remove({required String key});
  void removeAll();
}
