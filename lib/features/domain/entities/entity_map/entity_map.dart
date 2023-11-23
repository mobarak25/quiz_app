import 'package:quiz_app/features/domain/entities/default_response.dart';
import 'package:quiz_app/features/domain/entities/questions_response.dart';

class EntityMap {
  static T? fromJson<T, K>(dynamic json) {
    switch (T) {
      case QuestionList:
        return QuestionList.fromJson(json) as T;

      case DefaultResponse:
        return DefaultResponse.fromJson(json) as T;

      default:
        throw Exception('Unknown class');
    }
  }
}
