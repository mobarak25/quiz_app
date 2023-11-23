import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/navigator/iflutter_navigator.dart';
import 'package:quiz_app/features/data/data_sources/local_keys.dart';
import 'package:quiz_app/features/domain/repositories/local_storage_repo.dart';
import 'package:quiz_app/features/presentation/questions/view/question_screen.dart';

part 'main_menu_event.dart';
part 'main_menu_state.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {
  MainMenuBloc(this._flutterNavigator, this._localStorageRepo)
      : super(MainMenuInitial()) {
    on<GetHighScore>(_getHighScore);
    on<GoToQuestionScreen>(_goToQuestionScreen);

    add(GetHighScore());
  }

  final IFlutterNavigator _flutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getHighScore(
      GetHighScore event, Emitter<MainMenuState> emit) {
    final highScore = _localStorageRepo.read(key: highScoreDB);

    emit(state.copyWith(topScore: int.parse(highScore!)));
  }

  FutureOr<void> _goToQuestionScreen(
      GoToQuestionScreen event, Emitter<MainMenuState> emit) {
    _flutterNavigator.pushReplacement(QuestionScreen.route());
  }
}
