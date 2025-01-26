import 'dart:developer';

import 'package:ai_d_planner/app/core/constants/size_constants.dart';
import 'package:ai_d_planner/app/core/style/app_colors.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../binding/central_dependecy_injection.dart';
import '../../../../../core/constants/assets_constants.dart';
import '../../../../../core/constants/string_constants.dart';
import '../../../../../core/style/app_style.dart';
import '../../../../../core/utils/helper/print_log.dart';
import '../../../../../core/widgets/app_widgets.dart';
import '../../../../../core/widgets/custom_buttons_widget.dart';
import '../../../../../core/widgets/text_field_widget.dart';
import '../../../../../data/models/question_page_dummy_model.dart';
import '../bloc/question_page_bloc.dart';
import '../bloc/question_page_event.dart';
import '../bloc/question_page_state.dart';

class QuestionAnswerDialogWidget extends StatefulWidget {
  const QuestionAnswerDialogWidget({super.key});

  @override
  _QuestionAnswerDialogWidgetState createState() => _QuestionAnswerDialogWidgetState();
}

class _QuestionAnswerDialogWidgetState extends State<QuestionAnswerDialogWidget> {

  var questionBloc = getIt<QuestionPageBloc>();
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.whitePure,
        borderRadius: BorderRadius.circular(boxRadiusDialogBox),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.0,20.0,20.0,0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Text("Let’s Make It Even Better! 🌟",style: textRegularStyle(context,fontWeight: FontWeight.w600,fontSize: 18),)),
                Material(
                  color: AppColors.transparentPure,
                  borderRadius: BorderRadius.circular(roundRadius),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(roundRadius),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(20.0,0.0,20.0,20.0),
              child: BlocBuilder<QuestionPageBloc, QuestionPageState>(
            builder: (context, state) {
              Widget widget = const SizedBox();

              if (state.questionPageStateStatus ==
                  QuestionPageStateStatus.success) {
                widget = Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text("sasas")
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      // controller: _scrollController,
                      itemCount: state.questionPageDummyData!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return _getQuestionTile(context, state, index);
                      },
                    ),
                    AppWidgets().gapH24(),
                    CustomAppMaterialButton(
                      title: "Submit",
                      backgroundColor: AppColors.primaryColor,
                      borderColor: AppColors.primaryColor,
                      usePrefixIcon: false,
                      needSplashEffect: true,
                      borderRadius: 50,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      onPressed: () async {
                        validateAndSubmit(state.questionPageDummyData!);
                      },
                    ),
                  ],
                );
              }

              return widget;
            },
            ),
            ),
          ),
        ],
      ),
    );
  }

  _getQuestionTile(BuildContext? context, QuestionPageState state, index) {
    bool isCustomSelected =
        state.questionPageDummyData![index].selected != null &&
            state.questionPageDummyData![index].selected
            is List<Map<String, dynamic>> &&
            (state.questionPageDummyData![index].selected
            as List<Map<String, dynamic>>)
                .any((selected) =>
            selected["option"].toString().toLowerCase() == "custom");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppWidgets().gapH12(),
        Text(state.questionPageDummyData![index].ques ?? "",
          style: textRegularStyle(
              context,
              fontSize: state.questionPageDummyData![index].hint != null ? 16 : 18,
              fontWeight: state.questionPageDummyData![index].hint != null ? FontWeight.w600 : FontWeight.bold
          ),
        ),
        AppWidgets().gapH12(),
        if (state.questionPageDummyData![index].isMultipleSelect == false &&
            state.questionPageDummyData![index].options!.isEmpty)
        // Text("TextField")
          _getTextField(
              context,
              state.questionPageDummyData![index].ques,
              state.questionPageDummyData![index].hint,
              state.questionPageDummyData![index].textEditingController,
              state.questionPageDummyData![index].focusNode,
              textFieldType: state.questionPageDummyData![index].textFieldType,
              isActive: true,
              isReadOnly: state.questionPageDummyData![index].textFieldType ==
                  "dateField" ||
                  state.questionPageDummyData![index].textFieldType ==
                      "location"
                  ? true
                  : false)
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children:
                state.questionPageDummyData![index].options!.map((option) {
                  int optionIndex = state.questionPageDummyData![index].options!
                      .indexOf(option);

                  // Determine if the option is selected
                  bool isSelected = false;
                  var selectedAnswers =
                      state.questionPageDummyData![index].selected;

                  if (selectedAnswers != null &&
                      selectedAnswers is List<Map<String, dynamic>>) {
                    // Handle both multiple and single selection since `selected` is a list
                    isSelected = selectedAnswers.any((selected) =>
                    selected["optionID"] == optionIndex &&
                        selected["option"].toString().toLowerCase() ==
                            option.toLowerCase());
                  }

                  // Special case: custom option selection
                  if (option.toLowerCase() == "custom" &&
                      selectedAnswers != null &&
                      selectedAnswers is List<Map<String, dynamic>>) {
                    isSelected = selectedAnswers.any((selected) =>
                    selected["option"].toString().toLowerCase() ==
                        "custom");
                  }

                  return Material(
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.whitePure,
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
                        questionBloc.add(SelectOption(
                          questionIndex: index,
                          selectedAnswer: {
                            "optionID": optionIndex,
                            "option": option,
                          },
                        ));
                      },
                      borderRadius: BorderRadius.circular(roundRadius),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: option.toLowerCase() != "custom"
                            ? Text(
                          option,
                          style: textRegularStyle(
                            context,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            isWhiteColor: isSelected,
                          ),
                        )
                            : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              customQuestionIcon,
                              scale: 1.8,
                            ),
                            AppWidgets().gapW8(),
                            Text(
                              option,
                              style: textRegularStyle(
                                context,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                isWhiteColor: isSelected,
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
              isCustomSelected
                  ? _getTextField(
                  context,
                  state.questionPageDummyData![index].ques,
                  state.questionPageDummyData![index].ques,
                  state.questionPageDummyData![index].textEditingController,
                  state.questionPageDummyData![index].focusNode,
                  textFieldType: "text",
                  isActive: true,
                  isReadOnly:
                  state.questionPageDummyData![index].textFieldType ==
                      "dateField" ||
                      state.questionPageDummyData![index]
                          .textFieldType ==
                          "location"
                      ? true
                      : false)
                  : const SizedBox(),
            ],
          ),
        AppWidgets().gapH12(),
      ],
    );
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

  void _showDateTimePicker(
      BuildContext? context, TextEditingController? textEditingController) {
    BottomPicker.dateTime(
      bottomPickerTheme: BottomPickerTheme.plumPlate,
      pickerTitle: Text(
        'Set the event exact time and date',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
      onSubmit: (date) {
        printLog(date);
        textEditingController?.text = date.toString();
      },
      onCloseButtonPressed: () {
        printLog('Picker closed');
        Navigator.of(context!).pop();
      },
      dateOrder: DatePickerDateOrder.dmy,
      minDateTime: DateTime.now(),
      maxDateTime: DateTime(
          DateTime.now().year + 5, DateTime.now().month, DateTime.now().day),
      initialDateTime: DateTime.now(),
      buttonSingleColor: AppColors.primaryColor,
    ).show(context!);
  }

  void _setLocationData(
      BuildContext? context, TextEditingController? textEditingController) {
    textEditingController?.text = "New York";
  }

  void validateAndSubmit(List<QuestionPageDummyModel> questionList) {
    bool isValid = true;
    String errorMessage = '';

    for (var question in questionList) {
      if (question.isRequired == true) {
        if (question.options != null && question.options!.isNotEmpty) {
          // Check if "Custom" is selected
          if (question.selected != null &&
              question.selected is List<Map<String, dynamic>>) {
            bool isCustomSelected = question.selected.any((selected) =>
            selected["option"] != null &&
                selected["option"].toString().toLowerCase() == "custom");

            if (isCustomSelected) {
              // Check if textEditingController is empty for "Custom"
              if (question.textEditingController.text.trim().isEmpty) {
                isValid = false;
                int i = questionList.indexOf(question);
                _scrollToQuestion(i);
                errorMessage = "Please provide input for: ${question.ques}";
                break;
              }
            } else {
              // General validation for non-custom options
              if (question.selected.isEmpty) {
                isValid = false;
                int i = questionList.indexOf(question);
                _scrollToQuestion(i);
                errorMessage = "Please answer: ${question.ques}";
                break;
              }
            }
          } else if (question.selected == null) {
            // If nothing is selected
            isValid = false;
            int i = questionList.indexOf(question);
            _scrollToQuestion(i);
            errorMessage = "Please answer: ${question.ques}";
            break;
          }
        } else {
          // For textFieldType (non-options)
          if (question.textEditingController.text.trim().isEmpty) {
            isValid = false;
            int i = questionList.indexOf(question);
            _scrollToQuestion(i);
            errorMessage = "Please fill in: ${question.ques}";
            break;
          }
        }
      }
    }

    if (isValid) {
      // Proceed with submission
      printLog("Form is valid. Submitting data...");
      var data = questionPageDummyModelToJson(questionList);
      log(data);
      // Add your submit logic here
    } else {
      // Show error message
      printLog("Validation failed: $errorMessage");
      AppWidgets().getSnackBar(status: SnackBarStatus.error,message: errorMessage);
    }
  }

  void _scrollToQuestion(int index) {

    double questionHeight = 100.0;

    _scrollController.animateTo(
      index * questionHeight,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
