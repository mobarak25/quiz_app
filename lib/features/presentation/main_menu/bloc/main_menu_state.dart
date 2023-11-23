part of 'main_menu_bloc.dart';

class MainMenuState extends Equatable {
  const MainMenuState({
    this.topScore = 0,
  });

  final int topScore;

  MainMenuState copyWith({int? topScore}) {
    return MainMenuState(topScore: topScore ?? this.topScore);
  }

  @override
  List<Object> get props => [topScore];
}

final class MainMenuInitial extends MainMenuState {}
