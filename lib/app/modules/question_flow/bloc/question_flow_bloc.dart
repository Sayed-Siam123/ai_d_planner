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

  _selectOption(SelectOption event, Emitter<QuestionFlowState> emit) async {

    List<QuestionPageDummyModel> updatedQuestions = List.from(state.getStartedQues!); // Clone the list

    /*    if (updatedQuestions[event.questionIndex!].isMultipleSelect!) {
      // Handle multiple selection
      printLog("Handle multiple selection");
      List<dynamic>? selectedAnswers = updatedQuestions[event.questionIndex!].selected ?? [];

      if (selectedAnswers!.contains(event.selectedAnswer)) {
        // Deselect the answer
        selectedAnswers.remove(event.selectedAnswer);
      } else {
        // Select the answer
        selectedAnswers.add(event.selectedAnswer);
      }

      printLog(selectedAnswers);

      updatedQuestions[event.questionIndex!] = updatedQuestions[event.questionIndex!].copyWith(
        selected: selectedAnswers,
      );

    } else {
      // Handle single selection
      printLog("Handle single selection");
      if (updatedQuestions[event.questionIndex!].selected == null ||
          updatedQuestions[event.questionIndex!].selected != event.selectedAnswer) {
        updatedQuestions[event.questionIndex!] = updatedQuestions[event.questionIndex!].copyWith(
          selected: event.selectedAnswer,
        );
      } else if (updatedQuestions[event.questionIndex!].selected == event.selectedAnswer) {
        // Deselect the answer
        updatedQuestions[event.questionIndex!] = updatedQuestions[event.questionIndex!].copyWith(
          selected: null,
        );
      }
    }*/

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
  Future<bool> validateCurrentQuestion({
    required QuestionPageDummyModel question,
  }) async {
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
}
