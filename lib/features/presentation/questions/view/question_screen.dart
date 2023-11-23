import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/ioc/ioc.dart';
import 'package:quiz_app/core/navigator/iflutter_navigator.dart';
import 'package:quiz_app/core/utils/colors.dart';
import 'package:quiz_app/core/utils/text_styles.dart';
import 'package:quiz_app/core/widgets/body.dart';
import 'package:quiz_app/core/widgets/network_image.dart';
import 'package:quiz_app/core/widgets/text.dart';
import 'package:quiz_app/features/domain/repositories/api_repo.dart';
import 'package:quiz_app/features/domain/repositories/local_storage_repo.dart';
import 'package:quiz_app/features/presentation/questions/bloc/question_bloc.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  static Route<dynamic> route() =>
      MaterialPageRoute<dynamic>(builder: (_) => const QuestionScreen());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionBloc(getIt<IFlutterNavigator>(),
          getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
      child: const QuestionView(),
    );
  }
}

class QuestionView extends StatelessWidget {
  const QuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionBloc, QuestionState>(
      builder: (context, state) {
        final size = MediaQuery.of(context).size;
        final bloc = context.read<QuestionBloc>();
        return Body(
          horizontalPadding: 0,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: bAppBg,
            ),
            child: SingleChildScrollView(
              child: state.questionList.questions != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          decoration: const BoxDecoration(
                            color: bAppColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextB(
                                text:
                                    "Questions: ${state.currentQustionNo + 1} of ${state.questionList.questions!.length}",
                                textStyle: bHead4,
                                fontColor: bWhite,
                              ),
                              TextB(
                                text: "Current Score: ${state.totalScore}",
                                textStyle: bHead5M,
                                fontColor: bGreen,
                              ),
                            ],
                          ),
                        ),
                        LinearProgressIndicator(
                          value: state.progressParsentage,
                          color: bGreen,
                          backgroundColor: bLightGray,
                        ),
                        const SizedBox(height: 30),
                        //App Question Card

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: TextB(
                                          text:
                                              "${state.currentQustionNo + 1}. ${state.questionList.questions![state.currentQustionNo].question}",
                                          fontColor: bWhite,
                                        ),
                                      ),
                                      if (state
                                              .questionList
                                              .questions![
                                                  state.currentQustionNo]
                                              .questionImageUrl !=
                                          null)
                                        Container(
                                          width: 80,
                                          height: 60,
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: NetworkImageB(
                                              imageUrl: state
                                                  .questionList
                                                  .questions![
                                                      state.currentQustionNo]
                                                  .questionImageUrl!),
                                        )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  TextB(
                                    text:
                                        "Score: ${state.questionList.questions![state.currentQustionNo].score}",
                                    fontColor: bGreen,
                                  )
                                ],
                              ),
                              const SizedBox(height: 50),
                              ...List.generate(
                                state.ans.length,
                                (index) => state.ans[index] != null
                                    ? GestureDetector(
                                        onTap: () {
                                          if (state.isCorrect == -1) {
                                            bloc.add(GetCorrectAns(
                                                isCorrect: state.ans[index]));
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              width: size.width,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 15,
                                              ),
                                              decoration: BoxDecoration(
                                                color: (state.isCorrect == 1 &&
                                                            state.ans[index] ==
                                                                state
                                                                    .clickedValue) ||
                                                        (state.ans[index] ==
                                                            state.answerIs)
                                                    ? bGreen
                                                    : state.isCorrect == 0 &&
                                                            state.ans[index] ==
                                                                state
                                                                    .clickedValue
                                                        ? bRed
                                                        : bLightGray,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: TextB(
                                                text: "${state.ans[index]}",
                                                textStyle: bHead5B,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                          ],
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 100),
                          child: const CircularProgressIndicator(
                            color: bBrand,
                          ),
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
