import 'dart:io';

import 'package:ai_d_planner/app/binding/central_dependecy_injection.dart';
import 'package:ai_d_planner/app/core/base/base_view.dart';
import 'package:ai_d_planner/app/core/constants/size_constants.dart';
import 'package:ai_d_planner/app/core/style/app_colors.dart';
import 'package:ai_d_planner/app/core/style/app_style.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:ai_d_planner/app/core/widgets/custom_app_bar.dart';
import 'package:ai_d_planner/app/data/models/page_route_arguments.dart';
import 'package:ai_d_planner/app/modules/get_started/bloc/get_started_bloc.dart';
import 'package:ai_d_planner/app/modules/get_started/bloc/get_started_state.dart';
import 'package:ai_d_planner/app/modules/question_flow/bloc/question_flow_bloc.dart';
import 'package:ai_d_planner/app/modules/question_flow/bloc/question_flow_event.dart';
import 'package:ai_d_planner/app/modules/question_flow/bloc/question_flow_state.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/string_constants.dart';
import '../../../core/utils/helper/print_log.dart';
import '../../../core/widgets/custom_buttons_widget.dart';
import '../../../data/models/question_page_dummy_model.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/app_routes.dart';

class QuestionFlowPage extends BaseView {
  final BuildContext? context;
  final PageRouteArg? pageRouteArg;

  QuestionFlowPage(this.context, {super.key, this.pageRouteArg});

  final quesFlowBloc = getIt<QuestionFlowBloc>();

  PageController? pageController;

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    // TODO: implement appBar
    // return CustomAppBar.customAppBar(context,
    //   "",
    //   backgroundColor: AppColors.backgroundColor,
    //   elevation: 0.0,
    //   navBarColor: AppColors.backgroundColor,
    //   statusBarColor: AppColors.backgroundColor,
    //   isDarkBrightness: false,
    //   onBackTap: () {
    //     _onBackMethod();
    //   },
    // );
    return CustomAppBar.noAppBar(
      navBarColor: Platform.isAndroid
          ? AppColors.backgroundColor
          : AppColors.backgroundColor,
      statusBarColor: AppColors.backgroundColor,
      isDarkBrightness: false,
    );
  }

  @override
  Widget body(BuildContext context) {
    // TODO: implement body
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppWidgets().gapW8(),
            Material(
              borderRadius: BorderRadius.circular(roundRadius),
              child: InkWell(
                borderRadius: BorderRadius.circular(roundRadius),
                onTap: () {
                  _onBackMethod();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back_outlined),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<QuestionFlowBloc, QuestionFlowState>(
                builder: (context, state) {
                  Widget widget = const SizedBox();

                  if (state.questionFlowStateStatus ==
                      QuestionFlowStateStatus.loaded) {
                    widget = Row(
                      children: state.getStartedQues!.map(
                        (questions) {
                          int index = state.getStartedQues!.indexOf(questions);
                          return Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: index < state.currentIndex!
                                          ? AppColors.primaryColor
                                          : index == state.currentIndex!
                                              ? AppColors.primaryColor
                                                  .withValues(alpha: 0.5)
                                              : AppColors.textFieldBorderColor,
                                      borderRadius:
                                          BorderRadius.circular(boxRadius),
                                    ),
                                  ),
                                ),
                                if (index != state.getStartedQues!.length - 1)
                                  AppWidgets().gapW8(),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    );
                  }

                  return widget;
                },
              ),
            ),
            AppWidgets().gapW(20),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppWidgets().gapH12(),
                Expanded(
                  child: BlocBuilder<QuestionFlowBloc, QuestionFlowState>(
                    builder: (context, state) {
                      Widget widget = const SizedBox();

                      if (state.questionFlowStateStatus ==
                          QuestionFlowStateStatus.loaded) {
                        widget = PageView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: pageController!,
                          onPageChanged: (value) {
                            quesFlowBloc
                                .add(ChangeToNext(pageCurrentIndex: value));
                          },
                          children: state.getStartedQues!.map(
                            (questions) {
                              int questionIndex =
                                  state.getStartedQues!.indexOf(questions);

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    questions.ques!,
                                    style: textRegularStyle(context,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  AppWidgets().gapH12(),
                                  Wrap(
                                    spacing: 15,
                                    runSpacing: 15,
                                    children: questions.options!.map((option) {
                                      int optionIndex =
                                          questions.options!.indexOf(option);

                                      // Determine selection status for single or multiple selection
                                      bool isSelected;

                                      if (questions.isMultipleSelect!) {
                                        // For multiple selection, check if the option is selected in any of the selected data
                                        isSelected = questions.selectedData!
                                            .any((selected) =>
                                                selected.optionID ==
                                                    optionIndex &&
                                                selected.option == option);
                                      } else {
                                        // For single selection, check if the first selected option matches the current option
                                        isSelected = questions
                                                    .selectedData?.isNotEmpty ==
                                                true &&
                                            questions.selectedData?.first
                                                    .optionID ==
                                                optionIndex &&
                                            questions.selectedData?.first
                                                    .option ==
                                                option;
                                      }

                                      return Material(
                                        color: isSelected
                                            ? AppColors.primaryColor
                                            : AppColors.whitePure,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              roundRadius),
                                          side: BorderSide(
                                            color: AppColors.primaryColor
                                                .withOpacity(0.15),
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            quesFlowBloc.add(SelectOption(
                                                questionIndex: questionIndex,
                                                selectedAnswer: SelectedOption(
                                                    option: option,
                                                    optionID: optionIndex)));
                                            //isSelected ? AppColors.primaryColor :
                                          },
                                          borderRadius: BorderRadius.circular(
                                              roundRadius),
                                          child: Padding(
                                            padding: const EdgeInsets.all(13.0),
                                            child: Text(
                                              option,
                                              style: textRegularStyle(
                                                context,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                isWhiteColor: isSelected,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              );
                            },
                          ).toList(),
                        );
                      }

                      return widget;
                    },
                  ),
                ),
                BlocBuilder<QuestionFlowBloc, QuestionFlowState>(
                  builder: (context, state) {
                    return MaterialButton(
                      height: 55,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(roundRadius),
                      ),
                      onPressed: () async {
                        await handleButtonPress();
                      },
                      color: AppColors.primaryColor,
                      minWidth: double.maxFinite,
                      child: Text(
                        _getButtonName(),
                        style: textRegularStyle(context,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            isWhiteColor: true),
                      ),
                    );
                  },
                ),
                AppWidgets().gapH24(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> handleButtonPress() async {
    int currentIndex = quesFlowBloc.state.currentIndex!;
    int nextPageIndex = currentIndex + 1;

    // Get the current question
    QuestionPageDummyModel currentQuestion =
        quesFlowBloc.state.getStartedQues![currentIndex];

    // Validate only the current question
    bool isValid =
        await quesFlowBloc.validateCurrentQuestion(question: currentQuestion);

    if (isValid) {
      if (nextPageIndex == quesFlowBloc.state.getStartedQues!.length) {
        _proceedToSubmit(); // Proceed if it's the last page
      } else {
        pageController?.animateToPage(
          nextPageIndex,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOutExpo,
        );
        quesFlowBloc.add(ChangeToNext(pageCurrentIndex: nextPageIndex));
      }
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void initState() {
    // TODO: implement initState
    printLog("Init state of question flow");
    pageController = PageController(initialPage: 0);
    quesFlowBloc.add(FetchDummyQues());
    quesFlowBloc.add(ChangeToNext(pageCurrentIndex: 0));
  }

  @override
  void onPopBack(BuildContext context) {
    // TODO: implement onPopBack
  }

  @override
  showBottomNav() {
    // TODO: implement showBottomNav
    return false;
  }

  void _onBackMethod() {
    toReplacementNamed(AppRoutes.getStarted,
        args: PageRouteArg(
            to: AppRoutes.getStarted,
            from: AppRoutes.quesFlow,
            pageRouteType: PageRouteType.pushReplacement,
            isFromDashboardNav: false,
            isBackAction: true));
  }

  _getButtonName() {
    if ((quesFlowBloc.state.currentIndex! + 1) ==
        quesFlowBloc.state.getStartedQues?.length) {
      return StringConstants.buttonSubmit;
    } else {
      return StringConstants.buttonNext;
    }
  }

  void _proceedToSubmit() {
    toReplacementNamed(AppRoutes.seeFullFeature,
        args: PageRouteArg(
          to: AppRoutes.seeFullFeature,
          from: AppRoutes.quesFlow,
          pageRouteType: PageRouteType.pushReplacement,
          isFromDashboardNav: false,
        ));
  }
}
