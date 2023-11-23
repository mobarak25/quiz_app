import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/ioc/ioc.dart';
import 'package:quiz_app/core/navigator/iflutter_navigator.dart';
import 'package:quiz_app/core/utils/colors.dart';
import 'package:quiz_app/core/utils/text_styles.dart';
import 'package:quiz_app/core/widgets/body.dart';
import 'package:quiz_app/core/widgets/button.dart';
import 'package:quiz_app/core/widgets/text.dart';

import 'package:quiz_app/features/domain/repositories/local_storage_repo.dart';
import 'package:quiz_app/features/presentation/main_menu/bloc/main_menu_bloc.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  static Route<dynamic> route() =>
      MaterialPageRoute<dynamic>(builder: (_) => const MainMenuScreen());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MainMenuBloc(getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
      child: const MainMenuView(),
    );
  }
}

class MainMenuView extends StatelessWidget {
  const MainMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainMenuBloc, MainMenuState>(
      builder: (context, state) {
        final bloc = context.read<MainMenuBloc>();
        return Body(
          horizontalPadding: 0,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: bAppBg,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextB(
                    text: "Mobarak Quiz",
                    textStyle: bHead2B,
                    fontColor: bWhite,
                  ),
                  const SizedBox(height: 50),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ButtonB(
                      heigh: 60,
                      text: "Start New Game",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      press: () {
                        bloc.add(GoToQuestionScreen());
                      },
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextB(
                    text: "High score: ${state.topScore}",
                    textStyle: bHead2B,
                    fontColor: bWhite,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
