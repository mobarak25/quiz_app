import 'package:quiz_app/core/error/custom_error.dart';
import 'package:quiz_app/core/navigator/iflutter_navigator.dart';
import 'package:quiz_app/core/snackbar/show_snackbar.dart';
import 'package:quiz_app/features/data/data_sources/local_keys.dart';
import 'package:quiz_app/features/domain/repositories/local_storage_repo.dart';

const String unknownError = 'Unknown Error';

class CustomException implements Exception {
  const CustomException({this.message, this.prefix});

  final String? message;
  final String? prefix;

  @override
  String toString() {
    return '$prefix $message';
  }
}

class FetchDataException extends CustomException {
  FetchDataException(this.customError, this.iFlutterNavigator) : super() {
    ShowSnackBar(
        message: customError.message ?? unknownError,
        navigator: iFlutterNavigator,
        error: true);
  }
  final CustomError customError;
  final IFlutterNavigator iFlutterNavigator;
}

class BadRequestException extends CustomException {
  BadRequestException(this.customError, this.iFlutterNavigator) : super() {
    ShowSnackBar(
        message: customError.message ?? unknownError,
        navigator: iFlutterNavigator,
        error: true);
  }
  final CustomError customError;
  final IFlutterNavigator iFlutterNavigator;
}

class UnauthorizedException extends CustomException {
  UnauthorizedException(
      this.customError, this.iFlutterNavigator, this.localStorageRepo)
      : super() {
    if (localStorageRepo.read(key: tokenDB) != null) {
      ShowSnackBar(
          message: customError.message ?? unknownError,
          navigator: iFlutterNavigator,
          error: true);
      iFlutterNavigator.popUntil((route) => route.isFirst);
      //iFlutterNavigator.pushReplacement(LogInScreen.route());
      localStorageRepo.removeAll();
    }
  }
  final CustomError customError;
  final IFlutterNavigator iFlutterNavigator;
  final LocalStorageRepo localStorageRepo;
}

class NotFoundException extends CustomException {
  NotFoundException(this.customError, this.iFlutterNavigator) : super() {
    ShowSnackBar(
        message: customError.message ?? unknownError,
        navigator: iFlutterNavigator,
        error: true);
  }
  final CustomError customError;
  final IFlutterNavigator iFlutterNavigator;
}

class InvalidInputException extends CustomException {
  InvalidInputException(this.customError, this.iFlutterNavigator) : super() {
    ShowSnackBar(
        message: customError.message ?? unknownError,
        navigator: iFlutterNavigator,
        error: true);
  }
  final CustomError customError;
  final IFlutterNavigator iFlutterNavigator;
}

class AppException extends CustomException {
  AppException(this.customError, this.iFlutterNavigator) : super() {
    ShowSnackBar(
        message: customError.message ?? unknownError,
        navigator: iFlutterNavigator,
        error: true);
  }
  final CustomError customError;
  final IFlutterNavigator iFlutterNavigator;
}
