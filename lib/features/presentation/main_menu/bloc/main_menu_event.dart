part of 'main_menu_bloc.dart';

sealed class MainMenuEvent extends Equatable {
  const MainMenuEvent();

  @override
  List<Object> get props => [];
}

class GetHighScore extends MainMenuEvent {}

class GoToQuestionScreen extends MainMenuEvent {}
