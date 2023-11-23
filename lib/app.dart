import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:quiz_app/core/ioc/ioc.dart';
import 'package:quiz_app/core/navigator/iflutter_navigator.dart';
import 'package:quiz_app/features/presentation/splash/view/splash.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> with WidgetsBindingObserver {
  int count = 0;
  bool updateView = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    checkVersionUpdate();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    count++;
    if (!updateView && state == AppLifecycleState.resumed && count != 3) {
      count = 0;
      checkVersionUpdate();
    } else if (count > 3) {
      count = 0;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'montserrat',
      ),
      title: 'Quiz App',
      navigatorKey: getIt<IFlutterNavigator>().navigatorKey,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const Splash(),
    );
  }

  Future<void> checkVersionUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        updateView = true;
        InAppUpdate.performImmediateUpdate()
            .then((value) => updateView = false);
      }
    }).catchError((e) {
      // ShowSnackBar(
      //     message: 'App Update Failed',
      //     navigator: getIt<IFlutterNavigator>(),
      //     error: true);
    });
  }
}
