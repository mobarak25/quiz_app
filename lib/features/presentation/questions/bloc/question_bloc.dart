import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/navigator/iflutter_navigator.dart';
import 'package:quiz_app/features/data/data_sources/local_keys.dart';
import 'package:quiz_app/features/data/data_sources/remote_constants.dart';
import 'package:quiz_app/features/domain/entities/questions_response.dart';
import 'package:quiz_app/features/domain/repositories/api_repo.dart';
import 'package:quiz_app/features/domain/repositories/local_storage_repo.dart';
import 'package:quiz_app/features/presentation/main_menu/view/main_menu_screen.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  QuestionBloc(this._iFlutterNavigator, this._apiRepo, this._localStorageRepo)
      : super(QuestionInitial()) {
    on<GetQuestions>(_getQuestions);
    on<GetSingleQuestion>(_getSingleQuestion);
    on<GetCorrectAns>(_getCorrectAns);
    on<NextQuestion>(_nextQuestion);
    on<IncreaseProgress>(_increaseProgress);

    add(GetQuestions());
  }

  final IFlutterNavigator _iFlutterNavigator;
  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;

// Fetch API Questions
  FutureOr<void> _getQuestions(
      GetQuestions event, Emitter<QuestionState> emit) async {
    final questionResponse =
        await _apiRepo.get<QuestionList>(endpoint: quizEndPoint);

    if (questionResponse != null) {
      emit(state.copyWith(questionList: questionResponse));
      add(GetSingleQuestion());
    }

    final highScore = _localStorageRepo.read(key: highScoreDB);

    emit(state.copyWith(topScore: int.parse(highScore!)));
  }

// Formate for Single Question
  FutureOr<void> _getSingleQuestion(
      GetSingleQuestion event, Emitter<QuestionState> emit) {
    if (state.currentQustionNo < state.questionList.questions!.length) {
      final ansList = state
          .questionList.questions![state.currentQustionNo].answers!
          .toJson();
      emit(state.copyWith(ans: ansList.values.toList()));

      int secondCounter = 0;

      Timer.periodic(const Duration(seconds: 1), (timer) {
        secondCounter += 1;
        add(IncreaseProgress());

        if (secondCounter >= 10) {
          add(NextQuestion());
          timer.cancel();
        }
      });
    }
  }

// Code For Correct Answer
  FutureOr<void> _getCorrectAns(
      GetCorrectAns event, Emitter<QuestionState> emit) {
    emit(state.copyWith(clickedValue: event.isCorrect));
    final ansListForCorrect =
        state.questionList.questions![state.currentQustionNo].answers!.toJson();

    ansListForCorrect.forEach((key, value) {
      if (value == event.isCorrect) {
        if (state.questionList.questions![state.currentQustionNo]
                .correctAnswer ==
            key) {
          int score = state.totalScore +
              state.questionList.questions![state.currentQustionNo].score!;

          emit(state.copyWith(isCorrect: 1, totalScore: score));
        } else {
          final answer = ansListForCorrect[state
              .questionList.questions![state.currentQustionNo].correctAnswer];

          emit(state.copyWith(isCorrect: 0, answerIs: answer));
        }
      }
    });
  }

// Code For Next Questions
  FutureOr<void> _nextQuestion(
      NextQuestion event, Emitter<QuestionState> emit) async {
    if (state.currentQustionNo < state.questionList.questions!.length - 1) {
      emit(state.copyWith(
          currentQustionNo: state.currentQustionNo + 1,
          isCorrect: -1,
          answerIs: '',
          progressParsentage: 0.00,
          isEnableTimer: true));
      add(GetSingleQuestion());
    } else {
      if (state.totalScore > state.topScore) {
        await _localStorageRepo.write(
            key: highScoreDB, value: state.totalScore.toString());
      }

      _iFlutterNavigator.pushReplacement(MainMenuScreen.route());
    }
  }

// Code For Progress bar
  FutureOr<void> _increaseProgress(
      IncreaseProgress event, Emitter<QuestionState> emit) {
    emit(state.copyWith(progressParsentage: state.progressParsentage + 0.111));
  }
}
