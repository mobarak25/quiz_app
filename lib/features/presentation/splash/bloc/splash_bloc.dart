import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/navigator/iflutter_navigator.dart';
import 'package:quiz_app/features/presentation/main_menu/view/main_menu_screen.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(this._iFlutterNavigator) : super(SplashInitial()) {
    on<IsLoggedInCheck>(_isLoggedInCheck);

    add(IsLoggedInCheck());
  }

  final IFlutterNavigator _iFlutterNavigator;

  FutureOr<void> _isLoggedInCheck(
      IsLoggedInCheck event, Emitter<SplashState> emit) {
    Timer(const Duration(seconds: 2), () {
      _iFlutterNavigator.pushReplacement(MainMenuScreen.route());
    });
  }
}
