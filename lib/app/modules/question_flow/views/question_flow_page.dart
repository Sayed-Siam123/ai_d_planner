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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/string_constants.dart';
import '../../../core/widgets/custom_buttons_widget.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/app_routes.dart';

class QuestionFlowPage extends BaseView {
  final BuildContext? context;
  final PageRouteArg? pageRouteArg;
  QuestionFlowPage(this.context, {super.key,this.pageRouteArg});

  final quesFlowBloc = getIt<QuestionFlowBloc>();

  PageController? pageController;

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    // TODO: implement appBar
    return CustomAppBar.customAppBar(context,
      "",
      backgroundColor: AppColors.backgroundColor,
      elevation: 0.0,
      navBarColor: AppColors.backgroundColor,
      statusBarColor: AppColors.backgroundColor,
      isDarkBrightness: false,
      onBackTap: () {
        _onBackMethod();
      },
    );
  }

  @override
  Widget body(BuildContext context) {
    // TODO: implement body
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<QuestionFlowBloc,QuestionFlowState>(
            builder: (context, state) {
              Widget widget = const SizedBox();

              if(state.questionFlowStateStatus == QuestionFlowStateStatus.loaded){
                widget = Row(
                  children: state.getStartedQues!.map((questions) {
                    int index = state.getStartedQues!.indexOf(questions);
                    return Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: index < state.currentIndex! ? AppColors.primaryColor : index == state.currentIndex! ? AppColors.primaryColor.withValues(alpha: 0.5) : AppColors.textFieldBorderColor,
                                borderRadius: BorderRadius.circular(boxRadius),
                              ),
                            ),
                          ),
                          if (index != state.getStartedQues!.length - 1) AppWidgets().gapW8(),
                        ],
                      ),
                    );
                  },).toList(),
                );
              }

              return widget;
            },
          ),
          AppWidgets().gapH12(),
          Expanded(
            child: BlocBuilder<QuestionFlowBloc,QuestionFlowState>(
              builder: (context, state) {
                Widget widget = const SizedBox();

                if(state.questionFlowStateStatus == QuestionFlowStateStatus.loaded){
                  widget = PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: pageController,
                    onPageChanged: (value) {
                      quesFlowBloc.add(ChangeToNext(pageCurrentIndex: value));
                    },
                    children: state.getStartedQues!.map((questions) {
                      int questionIndex = state.getStartedQues!.indexOf(questions);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(questions.ques!,style: textRegularStyle(context,fontSize: 32,fontWeight: FontWeight.bold),),
                          AppWidgets().gapH12(),
                          /*Wrap(
                            spacing: 15,
                            runSpacing: 15,
                            children: questions.options!.map((option) {
                              int optionIndex = questions.options!.indexOf(option);

                              // Determine selection status for single or multiple selection
                              bool isSelected;
                              if (questions.isMultipleSelect!) {
                                isSelected = questions.selected?.contains(option) ?? false;
                              } else {
                                isSelected = questions.selected == option;
                              }

                              return Material(
                                color: isSelected ? AppColors.primaryColor : AppColors.whitePure,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(roundRadius),
                                  side: BorderSide(
                                    color: AppColors.primaryColor.withOpacity(0.15),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    // Trigger the appropriate event for single or multiple selection
                                    quesFlowBloc.add(SelectOption(
                                      questionIndex: questionIndex,
                                      selectedAnswer: {
                                        "optionID" : optionIndex,
                                        "option": option
                                      },
                                    ));
                                  },
                                  borderRadius: BorderRadius.circular(roundRadius),
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
                          ),*/

                          Wrap(
                            spacing: 15,
                            runSpacing: 15,
                            children: questions.options!.map((option) {
                              // Get the index of the current option
                              int optionIndex = questions.options!.indexOf(option);

                              // Determine selection status for single or multiple selection
                              bool isSelected;
                              if (questions.isMultipleSelect!) {
                                isSelected = questions.selected?.any((selected) =>
                                selected["optionID"] == optionIndex && selected["option"] == option) ?? false;
                              } else {
                                isSelected = questions.selected?["optionID"] == optionIndex &&
                                    questions.selected?["option"] == option;
                              }

                              return Material(
                                color: isSelected ? AppColors.primaryColor : AppColors.whitePure,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(roundRadius),
                                  side: BorderSide(
                                    color: AppColors.primaryColor.withOpacity(0.15),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    // Trigger the appropriate event for single or multiple selection
                                    quesFlowBloc.add(SelectOption(
                                      questionIndex: questionIndex,
                                      selectedAnswer: {
                                        "optionID": optionIndex,
                                        "option": option,
                                      },
                                    ));
                                  },
                                  borderRadius: BorderRadius.circular(roundRadius),
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
                    },).toList(),
                  );
                }

                return widget;
              },
            ),
          ),
          BlocBuilder<QuestionFlowBloc,QuestionFlowState>(
            builder: (context, state) {
              return CustomAppMaterialButton(
                title: _getButtonName(),
                backgroundColor: AppColors.primaryColor,
                borderColor: AppColors.primaryColor,
                usePrefixIcon: false,
                needSplashEffect: true,
                borderRadius: 50,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                onPressed: () async {
                  int nextPageIndex = quesFlowBloc.state.currentIndex!+1;

                  if(nextPageIndex == quesFlowBloc.state.getStartedQues?.length){
                    _proceedToSubmit();
                  } else{
                    pageController!.animateToPage(nextPageIndex,duration: Duration(milliseconds: 200),curve: Curves.easeOutExpo);
                    quesFlowBloc.add(ChangeToNext(pageCurrentIndex: nextPageIndex));
                  }

                },
              );
            },
          ),
          AppWidgets().gapH24(),
        ],
      ),
    );
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
    pageController = PageController();
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
    toReplacementNamed(AppRoutes.getStarted,args: PageRouteArg(
      to: AppRoutes.getStarted,
      from: AppRoutes.quesFlow,
      pageRouteType: PageRouteType.pushReplacement,
      isFromDashboardNav: false,
      isBackAction: true
    ));
  }

  _getButtonName() {
    if((quesFlowBloc.state.currentIndex!+1) == quesFlowBloc.state.getStartedQues?.length){
      return StringConstants.buttonSubmit;
    } else{
      return StringConstants.buttonNext;
    }
  }

  void _proceedToSubmit() {
    toReplacementNamed(AppRoutes.seeFullFeature,args: PageRouteArg(
        to: AppRoutes.seeFullFeature,
        from: AppRoutes.quesFlow,
        pageRouteType: PageRouteType.pushReplacement,
        isFromDashboardNav: false,
    ));
  }

}

