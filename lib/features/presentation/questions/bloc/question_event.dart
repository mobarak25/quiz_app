part of 'question_bloc.dart';

sealed class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}

class GetQuestions extends QuestionEvent {}

class GetSingleQuestion extends QuestionEvent {}

class GetCorrectAns extends QuestionEvent {
  const GetCorrectAns({required this.isCorrect});
  final String isCorrect;
}

class NextQuestion extends QuestionEvent {}

class IncreaseProgress extends QuestionEvent {}
