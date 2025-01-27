import 'dart:convert';
import 'dart:developer';

import 'package:ai_d_planner/app/core/utils/helper/app_helper.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:ai_d_planner/app/data/dummy_json/question_page_dummy_json.dart';
import 'package:ai_d_planner/app/data/models/question_page_dummy_model.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/questions/repository/gemini_repo.dart';
import 'package:ai_d_planner/app/routes/app_pages.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

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

    printLog(event.selectedAnswer?.option.toString().toLowerCase());

    // Starting from multiple selection process
    if (updatedQuestions[event.questionIndex!].isMultipleSelect!) {
      // For multiple selection
      List<SelectedOption> selectedAnswersForMultiple = [];

      if (event.selectedAnswer?.option.toString().toLowerCase() != "custom") {
        printLog("Handle multiple selection");

        // Retrieve existing selected answers or initialize a new list
        selectedAnswersForMultiple = updatedQuestions[event.questionIndex!].selectedData ?? [];

        if (selectedAnswersForMultiple.isNotEmpty &&
            selectedAnswersForMultiple[0].option?.toLowerCase() == "custom") {
          selectedAnswersForMultiple = [];
        }

        SelectedOption selectedAnswer = SelectedOption(
          optionID: event.selectedAnswer?.optionID,
          option: event.selectedAnswer?.option,
        );

        // Check if the answer already exists in the list
        bool exists = selectedAnswersForMultiple.any((answer) =>
        answer.optionID == selectedAnswer.optionID &&
            answer.option == selectedAnswer.option);

        if (exists) {
          // Deselect the answer
          selectedAnswersForMultiple.removeWhere((answer) =>
          answer.optionID == selectedAnswer.optionID &&
              answer.option == selectedAnswer.option);
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

      List<SelectedOption> selectedAnswersForSingle = updatedQuestions[event.questionIndex!].selectedData ?? [];

      SelectedOption selectedAnswer = SelectedOption(
        optionID: event.selectedAnswer?.optionID,
        option: event.selectedAnswer?.option,
      );

      if (selectedAnswersForSingle.isEmpty ||
          !(selectedAnswersForSingle.any((answer) =>
          answer.optionID == selectedAnswer.optionID &&
              answer.option == selectedAnswer.option))) {
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

    AppHelper().showLoader(dismissOnTap: false,hasMask: true);

    var dataList = questionPageDummyModelFromJson(questionPageDummyModelToJson(event.questionList!));

    var timeData = dataList[1].selectedData?[0].option;
    var time = _getTimeFormat(timeData);
    var date = _getDateFormat(timeData);
    var location = dataList[0].selectedData?[0].option;
    var budget = dataList[3].selectedData?[0].option;

    // printLog("$time and $date and $location and $budget");

    var data = await geminiRepo?.getPlansFromGemini(
      date: date,
      time: time,
      location: location,
      budget: budget
    );

    var plansData = await compute(deserializePlansFromText, data!.candidates![0].content!.parts![0].text!);

    if(plansData != null){
      emit(state.copyWith(
        questionPageStateApiStatus: QuestionPageStateApiStatus.success,
        plansFromAiModel: plansData
      ));
      event.pageController?.jumpToPage(dashboardResponseGeneration);
    } else{
      AppWidgets().getSnackBar(status: SnackBarStatus.error,message: "Something went wrong, Please try again");
    }

    AppHelper().hideLoader();

  }

  String? _getTimeFormat(String? dateTime) {
    // Parse the input string
    DateFormat inputFormat = DateFormat("dd-MMM-yyyy, hh:mm a");
    DateTime parsedDate = inputFormat.parse(dateTime!);

    // Format the date
    String formattedTime = DateFormat("HH:mm a").format(parsedDate);

    return formattedTime;
  }

  String? _getDateFormat(String? dateTime) {
    // Parse the input string
    DateFormat inputFormat = DateFormat("dd-MMM-yyyy, hh:mm a");
    DateTime parsedDate = inputFormat.parse(dateTime!);

    // Format the date
    String formattedDate = DateFormat("dd-MM-yyyy").format(parsedDate);

    return formattedDate;
  }

}

PlansFromAiModel? deserializePlansFromText(String data){
  var dataMap = plansFromAiModelFromJson(data.toString());
  return dataMap;
}
