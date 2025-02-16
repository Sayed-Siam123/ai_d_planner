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
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/assets_constants.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/utils/helper/print_log.dart';
import '../../../core/widgets/custom_buttons_widget.dart';
import '../../../core/widgets/text_field_widget.dart';
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
                                  if (state.getStartedQues![questionIndex].isMultipleSelect == false &&
                                      state.getStartedQues![questionIndex].options!.isEmpty)
                                  // Text("TextField")
                                    _getTextField(
                                        context,
                                        state.getStartedQues![questionIndex].ques,
                                        state.getStartedQues![questionIndex].hint,
                                        state.getStartedQues![questionIndex].textEditingController,
                                        state.getStartedQues![questionIndex].focusNode,
                                        textFieldType: state.getStartedQues![questionIndex].textFieldType,
                                        isActive: true,
                                        isReadOnly: state.getStartedQues![questionIndex].textFieldType ==
                                            "dateField" ||
                                            state.getStartedQues![questionIndex].textFieldType ==
                                                "location"
                                            ? true
                                            : false)
                                  else
                                    Wrap(
                                      spacing: 15,
                                      runSpacing: 15,
                                      children: questions.options!.map((option) {
                                        int optionIndex = questions.options!.indexOf(option);

                                        // Determine if the option is selected
                                        bool isSelected = false;
                                        List<SelectedOption>? selectedAnswers = questions.selectedData;

                                        if (selectedAnswers != null) {
                                          // Check if the option is selected
                                          isSelected = selectedAnswers.any((selected) =>
                                          selected.optionID == optionIndex &&
                                              selected.option?.toLowerCase() == option.toLowerCase());
                                        }

                                        // Special case: custom option selection
                                        if (option.toLowerCase() == "custom" && selectedAnswers != null) {
                                          isSelected = selectedAnswers.any((selected) =>
                                          selected.option?.toLowerCase() == "custom");
                                        }

                                        return Material(
                                          color: isSelected ? AppColors.primaryColor : AppColors.transparentPure,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(roundRadius),
                                            side: BorderSide(
                                              color: AppColors.primaryColor.withOpacity(0.15),
                                            ),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              FocusScope.of(context!).unfocus();
                                              // Trigger the appropriate event for single or multiple selection
                                              quesFlowBloc.add(SelectOption(
                                                questionIndex: questionIndex,
                                                selectedAnswer: SelectedOption(
                                                  optionID: optionIndex,
                                                  option: option,
                                                ),
                                              ));
                                            },
                                            borderRadius: BorderRadius.circular(roundRadius),
                                            child: Padding(
                                              padding: const EdgeInsets.all(13.0),
                                              child: option.toLowerCase() != "custom"
                                                  ? Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                        child: Text(
                                                          option,
                                                          textAlign: TextAlign.center,
                                                          style: textRegularStyle(
                                                        context,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        isWhiteColor: isSelected,
                                                      ),
                                                    ),
                                                  ) : Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    customQuestionIcon,
                                                    scale: 1.8,
                                                  ),
                                                  AppWidgets().gapW8(),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: Text(
                                                      option,
                                                      textAlign: TextAlign.center,
                                                      style: textRegularStyle(
                                                        context,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        isWhiteColor: isSelected,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  AppWidgets().gapH12(),

                                  // Display a text field if "custom" is selected
                                  questions.selectedData?.any(
                                        (selected) => selected.option?.toLowerCase() == "custom",
                                  ) ?? false
                                      ? _getTextField(
                                    context,
                                    questions.ques,
                                    questions.ques,
                                    questions.textEditingController,
                                    questions.focusNode,
                                    textFieldType: "text",
                                    isActive: true,
                                    isReadOnly: questions.textFieldType == "dateField" ||
                                        questions.textFieldType == "location",
                                  )
                                      : const SizedBox(),
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

  _getTextField(BuildContext? context, title, hint,
      TextEditingController controller, FocusNode? focusNode,
      {bool? isReadOnly, bool? isActive, String? textFieldType = "text"}) {
    return CustomTextFieldWidget(
      context: context!,
      hint: hint,
      name: title,
      errorText: StringConstants.emailError,
      isPasswordType: false,
      showStar: true,
      keyboardType: KeyboardType.text,
      autoFillEnabled: false,
      controller: controller,
      focusNode: focusNode,
      isReadOnly: isReadOnly!,
      fieldEnable: isActive,
      fillColor: AppColors.whitePure,
      borderColor: AppColors.textFieldBorderColor,
      hasCustomIcon: true,
      showSuffixIcon: true,
      suffixIcon: textFieldType == "location"
          ? Image.asset(
        mapPin,
        scale: 2,
      )
          : textFieldType == "dateField"
          ? Image.asset(
        calender,
        scale: 2,
      )
          : null,
      onTap: () {
        if (textFieldType == "dateField") {
          printLog("Open date selector");
          _showDateTimePicker(context, controller);
        } else if (textFieldType == "location") {
          printLog("Open location selector");
          _setLocationData(context, controller);
        }
      },
    );
  }

  _showDateTimePicker(BuildContext context,TextEditingController? textEditingController) async {
    // First: Show Date Picker
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year+1),
    );

    if (pickedDate == null) return null; // User canceled date picker

    // Second: Show Time Picker
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );

    if (pickedTime == null) return null; // User canceled time picker

    // Combine date and time
    var date = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    textEditingController?.text = _getFormattedTime(date.toString());
  }

  void _setLocationData(
      BuildContext? context, TextEditingController? textEditingController) {
    textEditingController?.text = "New York";
  }

  String _getFormattedTime(String time){
    try {
      // Parse the input time string into a DateTime object
      DateTime dateTime = DateTime.parse(time);

      // Format the DateTime object into a readable string
      String formattedTime = DateFormat('dd-MMM-yyyy, hh:mm a').format(dateTime);

      return formattedTime;
    } catch (e) {
      // Handle parsing errors by returning an empty string or error message
      return "Invalid time format";
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

    if (quesFlowBloc.state.currentIndex == 0) {
      // If it's the first question, go back to the previous screen
      toReplacementNamed(AppRoutes.getStarted,
          args: PageRouteArg(
              to: AppRoutes.getStarted,
              from: AppRoutes.quesFlow,
              pageRouteType: PageRouteType.pushReplacement,
              isFromDashboardNav: false,
              isBackAction: true));
    } else {
      // Otherwise, move to the previous question
      pageController!.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      // Update the bloc state to reflect the previous question
      quesFlowBloc.add(ChangeToNext(pageCurrentIndex: quesFlowBloc.state.currentIndex! - 1));
    }
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
