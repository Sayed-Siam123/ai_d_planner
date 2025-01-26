import 'dart:convert';
import 'dart:developer';

import 'package:ai_d_planner/app/data/dummy_json/question_page_dummy_json.dart';
import 'package:ai_d_planner/app/data/models/question_page_dummy_model.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/questions/repository/gemini_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/utils/helper/print_log.dart';
import '../../../../../data/models/plan_from_ai_model.dart';
import 'question_page_event.dart';
import 'question_page_state.dart';

class QuestionPageBloc extends Bloc<QuestionPageEvent, QuestionPageState> {

  GeminiRepo? geminiRepo;

  QuestionPageBloc() : super(QuestionPageState(questionPageStateStatus: QuestionPageStateStatus.init)) {

    geminiRepo = GeminiRepo();

    on<FetchQuestionFromDummy>(_fetchQuestionFromDummy);
    on<SelectOption>(_selectOption);
    on<ResetOption>(_resetOption);
    on<ResetAll>(_resetAll);
    on<FetchFromGemini>(_fetchFromGemini);
  }

  _fetchQuestionFromDummy(FetchQuestionFromDummy event, Emitter<QuestionPageState> emit) async {
    emit(state.copyWith(
      questionPageStateStatus: QuestionPageStateStatus.loading,
      questionPageDummyData: []
    ));

    var listData = questionPageDummyModelFromJson(jsonEncode(getQuestionPageDummy));

    emit(state.copyWith(
      questionPageStateStatus: QuestionPageStateStatus.success,
      questionPageDummyData: listData
    ));
  }
  _selectOption(SelectOption event, Emitter<QuestionPageState> emit) async {

    List<QuestionPageDummyModel> updatedQuestions = List.from(state.questionPageDummyData!); // Clone the list

    printLog(event.selectedAnswer["option"].toString().toLowerCase());

// Starting from multiple selection process
    if (updatedQuestions[event.questionIndex!].isMultipleSelect!) {
      // For multiple selection
      List<Map<String, dynamic>> selectedAnswersForMultiple = [];

      if (event.selectedAnswer["option"].toString().toLowerCase() != "custom") {
        printLog("Handle multiple selection");

        // Retrieve existing selected answers or initialize a new list
        selectedAnswersForMultiple = updatedQuestions[event.questionIndex!].selected != null
            ? List<Map<String, dynamic>>.from(updatedQuestions[event.questionIndex!].selected!)
            : [];

        if(selectedAnswersForMultiple.isNotEmpty && selectedAnswersForMultiple[0]["option"].toString().toLowerCase() == "custom"){
          selectedAnswersForMultiple = [];
        }

        Map<String, dynamic> selectedAnswer = {
          "optionID": event.selectedAnswer["optionID"],
          "option": event.selectedAnswer["option"]
        };

        // Check if the answer already exists in the list
        bool exists = selectedAnswersForMultiple.any((answer) =>
        answer["optionID"] == selectedAnswer["optionID"] &&
            answer["option"] == selectedAnswer["option"]);

        if (exists) {
          // Deselect the answer
          selectedAnswersForMultiple.removeWhere((answer) =>
          answer["optionID"] == selectedAnswer["optionID"] &&
              answer["option"] == selectedAnswer["option"]);
        } else {
          // Select the answer
          selectedAnswersForMultiple.add(selectedAnswer);
        }

        printLog(selectedAnswersForMultiple);

        // Update the question with the modified selected answers
        updatedQuestions[event.questionIndex!] = updatedQuestions[event.questionIndex!].copyWith(
          selected: selectedAnswersForMultiple,
        );
      } else {
        // For "custom" option, handle as single selection stored in a list

        printLog("Handle single selection for 'custom'");

        Map<String, dynamic> selectedAnswer = {
          "optionID": event.selectedAnswer["optionID"],
          "option": event.selectedAnswer["option"]
        };

        List<Map<String, dynamic>> selectedAnswersForCustom = updatedQuestions[event.questionIndex!].selected != null
            ? List<Map<String, dynamic>>.from(updatedQuestions[event.questionIndex!].selected!)
            : [];

        if(selectedAnswersForCustom.isNotEmpty && selectedAnswersForCustom[0]["option"].toString().toLowerCase() != "custom"){
          selectedAnswersForCustom = [];
        }

        // Check if the selected answer already exists in the list
        bool exists = selectedAnswersForCustom.any((answer) =>
        answer["optionID"] == selectedAnswer["optionID"] &&
            answer["option"] == selectedAnswer["option"]);

        if (exists) {
          // Deselect the answer by removing it from the list
          selectedAnswersForCustom.removeWhere((answer) =>
          answer["optionID"] == selectedAnswer["optionID"] &&
              answer["option"] == selectedAnswer["option"]);
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

      List<Map<String, dynamic>> selectedAnswersForSingle = updatedQuestions[event.questionIndex!].selected != null
          ? List<Map<String, dynamic>>.from(updatedQuestions[event.questionIndex!].selected!)
          : [];

      Map<String, dynamic> selectedAnswer = {
        "optionID": event.selectedAnswer["optionID"],
        "option": event.selectedAnswer["option"]
      };

      if (selectedAnswersForSingle.isEmpty ||
          !(selectedAnswersForSingle.any((answer) =>
          answer["optionID"] == selectedAnswer["optionID"] &&
              answer["option"] == selectedAnswer["option"]))) {
        // Select the answer (replace the existing selection for single-select)
        selectedAnswersForSingle = [selectedAnswer];
      } else {
        // Deselect the answer
        selectedAnswersForSingle = [];
      }

      // Update the question with the modified selected answers
      updatedQuestions[event.questionIndex!] = updatedQuestions[event.questionIndex!].copyWith(
        selected: selectedAnswersForSingle,
      );
    }

// Emit updated state
    emit(state.copyWith(
      questionPageDummyData: updatedQuestions,
    ));

  }
  _resetOption(ResetOption event, Emitter<QuestionPageState> emit) async {

    List<QuestionPageDummyModel> updatedQuestions = List.from(state.questionPageDummyData!); // Clone the list

    updatedQuestions[event.questionIndex!] = updatedQuestions[event.questionIndex!].copyWith(
      selected: null,
    );

    emit(state.copyWith(
        questionPageDummyData: updatedQuestions
    ));
  }
  _resetAll(ResetAll event, Emitter<QuestionPageState> emit) async {
    emit(state.copyWith(
        questionPageStateStatus: QuestionPageStateStatus.init
    ));
  }

  _fetchFromGemini(FetchFromGemini event, Emitter<QuestionPageState> emit) async {
    emit(state.copyWith(
        questionPageStateApiStatus: QuestionPageStateApiStatus.loading
    ));


    log(questionPageDummyModelToJson(event.questionList!));

    var timeData = event.questionList![0].selected as List<Map<String,dynamic>>;

    printLog(timeData);

    //WILL WORK TOMORROW

    // printLog(event.questionList![1].selected);

    // String? time = _getTimeFormat(event.questionList![1].selected);
    // printLog(time);

    // var data = await geminiRepo?.getPlansFromGemini(
    //
    // );
    //
    // log(data!.candidates![0].content!.parts![0].text!);
    //
    // var datam = await compute(deserializePlansFromText, data!.candidates![0].content!.parts![0].text!);
    //
    // printLog(datam?.plans![0].datePlanId.toString());

    //WORKING --
    // NOW NEED TO DO ACTUAL JSON WITH ACTUAL DATA

    emit(state.copyWith(
        questionPageStateApiStatus: QuestionPageStateApiStatus.success
    ));

  }

  String? _getTimeFormat(String? dateTime) {
    return "";
  }

}

PlansFromAiModel? deserializePlansFromText(String data){
  var dataMap = plansFromAiModelFromJson(data.toString());
  return dataMap;
}
