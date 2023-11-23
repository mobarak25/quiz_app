import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/ioc/ioc.dart';
import 'package:quiz_app/core/navigator/iflutter_navigator.dart';
import 'package:quiz_app/core/utils/colors.dart';
import 'package:quiz_app/core/utils/text_styles.dart';
import 'package:quiz_app/core/widgets/body.dart';
import 'package:quiz_app/core/widgets/text.dart';
import 'package:quiz_app/features/presentation/splash/bloc/splash_bloc.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => SplashBloc(getIt<IFlutterNavigator>()),
      child: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          return Body(
            isFullScreen: true,
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: bBrand),
              width: size.width,
              height: size.height,
              child: const TextB(
                text: "Quiz App",
                textStyle: bHead2B,
                fontColor: bWhite,
              ),
            ),
          );
        },
      ),
    );
  }
}
