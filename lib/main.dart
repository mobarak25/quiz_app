import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quiz_app/app.dart';
import 'package:quiz_app/core/ioc/ioc.dart';

Future<void> main() async {
  if (kReleaseMode) {
    await dotenv.load(fileName: ".env.release");
  } else if (kProfileMode) {
    await dotenv.load(fileName: ".env.profile");
  } else {
    await dotenv.load(fileName: ".env");
  }
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  configureDependencies();
  initFirebase();
  await initGetStorage();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('bn', 'BD'), Locale('en', 'US')],
      path: 'lib/core/translations',
      fallbackLocale: const Locale('bn', 'BD'),
      saveLocale: true,
      startLocale: const Locale('bn', 'BD'),
      child: const MyApp()));
}

Future<void> initFirebase() async {
  await Firebase.initializeApp();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

Future<void> initGetStorage() async {
  await GetStorage.init();
}
