import 'dart:convert';

import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/data/dummy_json/get_started_dummy_json.dart';
import 'package:ai_d_planner/app/modules/question_flow/bloc/question_flow_event.dart';
import 'package:ai_d_planner/app/modules/question_flow/bloc/question_flow_state.dart';
import 'package:bloc/bloc.dart';

import '../../../data/models/get_started_ques_model.dart';

class QuestionFlowBloc extends Bloc<QuestionFlowEvent, QuestionFlowState> {
  QuestionFlowBloc() : super(QuestionFlowState(questionFlowStateStatus: QuestionFlowStateStatus.init)) {
    on<ChangeToNext>(_changeToNext);
    on<FetchDummyQues>(_fetchDummyQues);
    on<SelectOption>(_selectOption);
  }

  _changeToNext(ChangeToNext event, Emitter<QuestionFlowState> emit) async {
    emit(state.copyWith(
        currentIndex: event.pageCurrentIndex
    ));
  }

  _selectOption(SelectOption event, Emitter<QuestionFlowState> emit) async {

    List<GetStartedQuesModel> updatedQuestions = List.from(state.getStartedQues!); // Clone the list

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

      List<Map<String, dynamic>> selectedAnswers = List<Map<String, dynamic>>.from(updatedQuestions[event.questionIndex!].selected ?? []);

      Map<String, dynamic> selectedAnswer = {
        "optionID": event.selectedAnswer["optionID"],
        "option": event.selectedAnswer["option"]
      };

      // Check if the answer already exists in the list
      bool exists = selectedAnswers.any((answer) =>
      answer["optionID"] == selectedAnswer["optionID"] &&
          answer["option"] == selectedAnswer["option"]);

      if (exists) {
        // Deselect the answer
        selectedAnswers.removeWhere((answer) =>
        answer["optionID"] == selectedAnswer["optionID"] &&
            answer["option"] == selectedAnswer["option"]);
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

      Map<String, dynamic>? selectedAnswer = updatedQuestions[event.questionIndex!].selected;

      if (selectedAnswer == null ||
          selectedAnswer["optionID"] != event.selectedAnswer["optionID"] ||
          selectedAnswer["option"] != event.selectedAnswer["option"]) {
        // Select the answer
        updatedQuestions[event.questionIndex!] = updatedQuestions[event.questionIndex!].copyWith(
          selected: {
            "optionID": event.selectedAnswer["optionID"],
            "option": event.selectedAnswer["option"]
          },
        );
      } else {
        // Deselect the answer
        updatedQuestions[event.questionIndex!] = updatedQuestions[event.questionIndex!].copyWith(
          selected: null,
        );
      }
    }

    emit(state.copyWith(
        getStartedQues: updatedQuestions
    ));
  }

  _fetchDummyQues(FetchDummyQues event, Emitter<QuestionFlowState> emit) async {
    emit(state.copyWith(
      questionFlowStateStatus: QuestionFlowStateStatus.loading
    ));
    
    var listData = getStartedQuesModelFromJson(jsonEncode(getStartedDummy));

    emit(state.copyWith(
        questionFlowStateStatus: QuestionFlowStateStatus.loaded,
        getStartedQues: listData
    ));

  }
}
