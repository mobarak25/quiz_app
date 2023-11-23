import 'package:quiz_app/core/ioc/global.dart';
import 'package:quiz_app/features/domain/repositories/local_storage_repo.dart';

class LocalData {
  static final localStorageRepo = getIt<LocalStorageRepo>();
}
