import 'dart:convert';

import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/data/dummy_json/get_started_dummy_json.dart';
import 'package:ai_d_planner/app/data/models/question_page_dummy_model.dart';
import 'package:ai_d_planner/app/modules/question_flow/bloc/question_flow_event.dart';
import 'package:ai_d_planner/app/modules/question_flow/bloc/question_flow_state.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/app_widgets.dart';
import '../../../data/models/get_started_ques_model.dart';

class QuestionFlowBloc extends Bloc<QuestionFlowEvent, QuestionFlowState> {
  QuestionFlowBloc() : super(QuestionFlowState(questionFlowStateStatus: QuestionFlowStateStatus.init)) {
    on<ChangeToNext>(_changeToNext);
    on<FetchDummyQues>(_fetchDummyQues);
    on<SelectOption>(_selectOption);
  }

  _changeToNext(ChangeToNext event, Emitter<QuestionFlowState> emit) async {
    emit(state.copyWith(
        currentIndex: event.pageCurrentIndex,
    ));
  }

  /*_selectOption(SelectOption event, Emitter<QuestionFlowState> emit) async {

    List<QuestionPageDummyModel> updatedQuestions = List.from(state.getStartedQues!); // Clone the list

    if (updatedQuestions[event.questionIndex!].isMultipleSelect!) {
      // Handle multiple selection
      printLog("Handle multiple selection");

      List<SelectedOption> selectedAnswers = updatedQuestions[event.questionIndex!].selectedData ?? [];

      SelectedOption selectedAnswer = SelectedOption(
        optionID: event.selectedAnswer?.optionID,
        option: event.selectedAnswer?.option,
      );

      // Check if the answer already exists in the list
      bool exists = selectedAnswers.any((answer) =>
      answer.optionID == selectedAnswer.optionID &&
          answer.option == selectedAnswer.option);

      if (exists) {
        // Deselect the answer
        selectedAnswers.removeWhere((answer) =>
        answer.optionID == selectedAnswer.optionID &&
            answer.option == selectedAnswer.option);
      } else {
        // Select the answer
        selectedAnswers.add(selectedAnswer);
      }

      // Update the question with the modified selected answers
      updatedQuestions[event.questionIndex!] = updatedQuestions[event.questionIndex!].copyWith(
        selected: selectedAnswers,
      );

    } else {
      // Handle single selection
      printLog("Handle single selection");

      List<SelectedOption> selectedAnswer = updatedQuestions[event.questionIndex!].selectedData ?? [];

      SelectedOption selectedAnswerSingle = SelectedOption(
        optionID: event.selectedAnswer?.optionID,
        option: event.selectedAnswer?.option,
      );

      if (selectedAnswer.isEmpty ||
          !(selectedAnswer.any((answer) =>
          answer.optionID == selectedAnswerSingle.optionID &&
              answer.option == selectedAnswerSingle.option))) {
        // Select the answer (replace the existing selection for single-select)
        selectedAnswer = [selectedAnswerSingle];
      } else {
        // Deselect the answer
        selectedAnswer = [];
      }

      // Update the question with the modified selected answers
      updatedQuestions[event.questionIndex!] = updatedQuestions[event.questionIndex!].copyWith(
        selected: selectedAnswer,
      );
      }

    emit(state.copyWith(
        getStartedQues: updatedQuestions
    ));
  }*/

  _selectOption(SelectOption event, Emitter<QuestionFlowState> emit) async {
    List<QuestionPageDummyModel> updatedQuestions = List.from(state.getStartedQues!); // Clone the list

    printLog(event.selectedAnswer?.option.toString().toLowerCase());

    // Starting from multiple selection process
    if (updatedQuestions[event.questionIndex!].isMultipleSelect!) {
      // For multiple selection
      List<SelectedOption> selectedAnswers = [];

      if (event.selectedAnswer?.option.toString().toLowerCase() != "custom") {
        printLog("Handle multiple selection");

        // Retrieve existing selected answers or initialize a new list
        selectedAnswers = updatedQuestions[event.questionIndex!].selectedData ?? [];

        if (selectedAnswers.isNotEmpty && selectedAnswers[0].option?.toLowerCase() == "custom") {
          selectedAnswers = [];
        }

        SelectedOption selectedAnswer = SelectedOption(
          optionID: event.selectedAnswer?.optionID,
          option: event.selectedAnswer?.option,
        );

        // Check if the answer already exists in the list
        bool exists = selectedAnswers.any((answer) =>
        answer.optionID == selectedAnswer.optionID &&
            answer.option == selectedAnswer.option);

        if (exists) {
          // Deselect the answer
          selectedAnswers.removeWhere((answer) =>
          answer.optionID == selectedAnswer.optionID &&
              answer.option == selectedAnswer.option);
        } else {
          // Select the answer
          selectedAnswers.add(selectedAnswer);
        }

        printLog(selectedAnswers);

        // Update the question with the modified selected answers
        updatedQuestions[event.questionIndex!] = updatedQuestions[event.questionIndex!].copyWith(
          selected: selectedAnswers,
        );
      } else {
        // For "custom" option, handle as single selection stored in a list
        printLog("Handle single selection for 'custom'");

        SelectedOption selectedAnswer = SelectedOption(
          optionID: event.selectedAnswer?.optionID,
          option: event.selectedAnswer?.option,
        );

        List<SelectedOption> selectedAnswersForCustom = updatedQuestions[event.questionIndex!].selectedData ?? [];

        if (selectedAnswersForCustom.isNotEmpty &&
            selectedAnswersForCustom[0].option?.toLowerCase() != "custom") {
          selectedAnswersForCustom = [];
        }

        // Check if the selected answer already exists in the list
        bool exists = selectedAnswersForCustom.any((answer) =>
        answer.optionID == selectedAnswer.optionID &&
            answer.option == selectedAnswer.option);

        if (exists) {
          // Deselect the answer by removing it from the list
          selectedAnswersForCustom.removeWhere((answer) =>
          answer.optionID == selectedAnswer.optionID &&
              answer.option == selectedAnswer.option);
        } else {
          // Select the answer by adding it to the list
          selectedAnswersForCustom = [selectedAnswer]; // Clear any existing and add the new custom selection
        }

        // Update the question with the modified selected answers
        updatedQuestions[event.questionIndex!] = updatedQuestions[event.questionIndex!].copyWith(
          selected: selectedAnswersForCustom,
        );
      }
    } else {
      // Handle single selection (when isMultipleSelect is false)
      printLog("Handle single selection");

      List<SelectedOption> selectedAnswers = updatedQuestions[event.questionIndex!].selectedData ?? [];

      SelectedOption selectedAnswer = SelectedOption(
        optionID: event.selectedAnswer?.optionID,
        option: event.selectedAnswer?.option,
      );

      if (selectedAnswers.isEmpty ||
          !(selectedAnswers.any((answer) =>
          answer.optionID == selectedAnswer.optionID &&
              answer.option == selectedAnswer.option))) {
        // Select the answer (replace the existing selection for single-select)
        selectedAnswers = [selectedAnswer];
      } else {
        // Deselect the answer
        selectedAnswers = [];
      }

      // Update the question with the modified selected answers
      updatedQuestions[event.questionIndex!] = updatedQuestions[event.questionIndex!].copyWith(
        selected: selectedAnswers,
      );
    }

    // Emit updated state
    emit(state.copyWith(
      getStartedQues: updatedQuestions,
    ));
  }

  _fetchDummyQues(FetchDummyQues event, Emitter<QuestionFlowState> emit) async {
    emit(state.copyWith(
      questionFlowStateStatus: QuestionFlowStateStatus.loading
    ));
    
    var listData = questionPageDummyModelFromJson(jsonEncode(getStartedDummy));

    emit(state.copyWith(
        questionFlowStateStatus: QuestionFlowStateStatus.loaded,
        getStartedQues: listData
    ));

  }

  /*Future<bool> validateAndSubmit({required List<QuestionPageDummyModel> questionList}) async {
    bool isValid = true;
    String errorMessage = '';

    for (var question in questionList) {
      if (question.isRequired == true) {
        if (question.options != null && question.options!.isNotEmpty) {
          if (question.selectedData != null && question.selectedData!.isNotEmpty) {
            continue; // At least one option is selected
          } else {
            isValid = false;
            errorMessage = "Please select an option for: ${question.ques}";
            break;
          }
        } else {
          isValid = false;
          errorMessage = "No options available to answer: ${question.ques}";
          break;
        }
      }
    }

    if (!isValid) {
      // Show snackbar if validation fails
      await AppWidgets().getSnackBar(
        status: SnackBarStatus.error,
        message: errorMessage,
        position: MobileSnackBarPosition.top,
      );
      printLog("Validation failed: $errorMessage");
    }

    return isValid;
  }*/

  /*
  Future<bool> validateCurrentQuestion({required QuestionPageDummyModel question,}) async {
    bool isValid = true;
    String errorMessage = '';

    // Check if the question is required
    if (question.isRequired == true) {
      if (question.options != null && question.options!.isNotEmpty) {
        // Check if at least one option is selected
        if (question.selectedData != null && question.selectedData!.isNotEmpty) {
          isValid = true;
        } else {
          isValid = false;
          errorMessage = "Please select an option for: ${question.ques}";
        }
      } else {
        isValid = false;
        errorMessage = "No options available to answer: ${question.ques}";
      }
    }

    if (!isValid) {
      // Show snackbar if validation fails
      await AppWidgets().getSnackBar(
        status: SnackBarStatus.error,
        message: errorMessage,
        position: MobileSnackBarPosition.top,
      );
      printLog("Validation failed: $errorMessage");
    }

    return isValid;
  }
*/

  Future<bool> validateCurrentQuestion({required QuestionPageDummyModel question}) async {
    bool isValid = true;
    String errorMessage = '';

    // Check if the question is required
    if (question.isRequired == true) {
      if (question.options != null && question.options!.isNotEmpty) {
        // Check if "Custom" is selected
        if (question.selectedData != null && question.selectedData!.isNotEmpty) {
          bool isCustomSelected = question.selectedData!.any((selected) =>
          selected.option != null && selected.option!.toLowerCase() == "custom");

          if (isCustomSelected) {
            // Check if textEditingController is empty for "Custom"
            if (question.textEditingController.text.trim().isEmpty) {
              isValid = false;
              errorMessage = "Please provide input for: ${question.ques}";
            }
          } else {
            // General validation for non-custom options
            isValid = true; // Since at least one option is selected
          }
        } else {
          // If nothing is selected
          isValid = false;
          errorMessage = "Please answer: ${question.ques}";
        }
      } else {
        // For textFieldType (non-options)
        if (question.textEditingController.text.trim().isEmpty) {
          isValid = false;
          errorMessage = "Please fill in: ${question.ques}";
        }
      }
    }

    if (!isValid) {
      // Show snackbar if validation fails
      await AppWidgets().getSnackBar(
        status: SnackBarStatus.error,
        message: errorMessage,
        position: MobileSnackBarPosition.top,
      );
      printLog("Validation failed: $errorMessage");
    }

    return isValid;
  }
}
