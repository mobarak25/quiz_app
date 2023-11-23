part of 'question_bloc.dart';

class QuestionState extends Equatable {
  const QuestionState({
    this.questionList = const QuestionList(),
    this.currentQustionNo = 0,
    this.ans = const [],
    this.isCorrect = -1,
    this.clickedValue = '',
    this.answerIs = '',
    this.totalScore = 0,
    this.topScore = 0,
    this.progressParsentage = 0.0,
    this.isEnableTimer = false,
  });

  final int currentQustionNo;
  final QuestionList questionList;
  final List<dynamic> ans;
  final int isCorrect;
  final String clickedValue;
  final String answerIs;
  final int totalScore;
  final int topScore;
  final double progressParsentage;
  final bool isEnableTimer;

  QuestionState copyWith({
    int? currentQustionNo,
    QuestionList? questionList,
    List<dynamic>? ans,
    int? isCorrect,
    String? clickedValue,
    String? answerIs,
    int? totalScore,
    int? topScore,
    double? progressParsentage,
    bool? isEnableTimer,
  }) {
    return QuestionState(
      currentQustionNo: currentQustionNo ?? this.currentQustionNo,
      questionList: questionList ?? this.questionList,
      ans: ans ?? this.ans,
      isCorrect: isCorrect ?? this.isCorrect,
      clickedValue: clickedValue ?? this.clickedValue,
      answerIs: answerIs ?? this.answerIs,
      totalScore: totalScore ?? this.totalScore,
      topScore: topScore ?? this.topScore,
      progressParsentage: progressParsentage ?? this.progressParsentage,
      isEnableTimer: isEnableTimer ?? this.isEnableTimer,
    );
  }

  @override
  List<Object> get props => [
        currentQustionNo,
        questionList,
        ans,
        isCorrect,
        clickedValue,
        answerIs,
        totalScore,
        topScore,
        progressParsentage,
        isEnableTimer
      ];
}

final class QuestionInitial extends QuestionState {}
