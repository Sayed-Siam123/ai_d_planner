import 'dart:convert';
import 'dart:developer';

import 'package:ai_d_planner/app/core/utils/helper/app_helper.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:ai_d_planner/app/data/dummy_json/question_page_dummy_json.dart';
import 'package:ai_d_planner/app/data/dummy_json/regenerate_question_dummy_json.dart';
import 'package:ai_d_planner/app/data/models/GetPlanResponseModel.dart';
import 'package:ai_d_planner/app/data/models/question_page_dummy_model.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/questions/repository/gemini_repo.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/questions/repository/response_supabase_repository.dart';
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
  ResponseSupaBaseRepository? responseSupaBaseRepository;

  QuestionPageBloc() : super(QuestionPageState(questionPageStateStatus: QuestionPageStateStatus.init)) {

    geminiRepo = GeminiRepo();
    responseSupaBaseRepository = ResponseSupaBaseRepository();

    on<FetchQuestionFromDummy>(_fetchQuestionFromDummy);
    on<FetchRegenerateQuestionFromDummy>(_fetchRegenerateQuestionFromDummy);
    on<SelectOption>(_selectOption);
    on<ResetOption>(_resetOption);
    on<ResetRegenerateQues>(_resetRegenerate);
    on<ResetAll>(_resetAll);
    on<FetchFromGemini>(_fetchFromGemini);
    on<ChangeStatusFav>(_changeStatusFav);
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
  _fetchRegenerateQuestionFromDummy(FetchRegenerateQuestionFromDummy event, Emitter<QuestionPageState> emit) async {
    emit(state.copyWith(
        questionPageStateStatus: QuestionPageStateStatus.loading,
        regenerateQuestionPageDummyData: []
    ));

    var listData = questionPageDummyModelFromJson(jsonEncode(getRegenerateQuestionDummy));

    emit(state.copyWith(
        questionPageStateStatus: QuestionPageStateStatus.success,
        regenerateQuestionPageDummyData: listData
    ));
  }

  _selectOption(SelectOption event, Emitter<QuestionPageState> emit) async {

    List<QuestionPageDummyModel> updatedQuestions = !event.isFromRegenerationDialog! ? List.from(state.questionPageDummyData!) : List.from(state.regenerateQuestionPageDummyData!); // Clone the list

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
    !event.isFromRegenerationDialog! ? emit(state.copyWith(
      questionPageDummyData: updatedQuestions,
    )) : emit(state.copyWith(
      regenerateQuestionPageDummyData: updatedQuestions,
    ));;
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

  _resetRegenerate(ResetRegenerateQues event, Emitter<QuestionPageState> emit) async {

    List<QuestionPageDummyModel> updatedQuestions = List.from(state.regenerateQuestionPageDummyData!); // Clone the list

    for(var question in updatedQuestions){
      updatedQuestions[updatedQuestions.indexOf(question)] = updatedQuestions[updatedQuestions.indexOf(question)].copyWith(
        selected: [],
      );
    }

    emit(state.copyWith(
        regenerateQuestionPageDummyData: updatedQuestions
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

    AppHelper().showLoader(dismissOnTap: true,hasMask: true);

    var dataList = questionPageDummyModelFromJson(questionPageDummyModelToJson(event.questionList!));

    var timeData = dataList[1].selectedData?[0].option;
    var time = _getTimeFormat(timeData);
    var date = _getDateFormat(timeData);
    var location = dataList[0].selectedData?[0].option;
    var budget = dataList[11].selectedData?[0].option;
    var duration = dataList[4].selectedData?[0].option;
    var dateType = dataList[5].selectedData?[0].option;
    var dateMoodType = dataList[7].selectedData?[0].option;
    var dateDietRestrictions = dataList[12].selectedData?[0].option;

    String formatOptions(List<String?> options) {
      if (options.contains("Surprise me!")) {
        return options.where((option) => option != "Surprise me!").join(", ") +
            (options.length > 1 ? " or Surprise me!" : "Surprise me!");
      }
      return options.join(", ");
    }

    var foodOptions = dataList[9].selectedData?.map((e) => e.option).toList() ?? [];
    var foodType = formatOptions(foodOptions);

    var activityOptions = dataList[10].selectedData?.map((e) => e.option).toList() ?? [];
    var activityType = formatOptions(activityOptions);

    // printLog("$time and $date and $location and $budget");

    var data = await geminiRepo?.getPlansFromGemini(
      date: date,
      time: time,
      location: location,
      budget: budget,
      foodType: foodType,
      dateType: dateType,
      dateMoodType: dateMoodType,
      dateDietRestrictions: dateDietRestrictions,
      activityType: activityType,
      duration: duration
    );

    var plansData = await compute(deserializePlansFromText, data!.candidates![0].content!.parts![0].text!);

    if(plansData != null){
      await _storePlansInDB(timeData,plansData.plans,location);

      emit(state.copyWith(
        questionPageStateApiStatus: QuestionPageStateApiStatus.success,
        plansFromDB: await _getLastThreePlans()
      ));

      event.pageController?.jumpToPage(dashboardResponseGeneration);
    } else{
      AppWidgets().getSnackBar(status: SnackBarStatus.error,message: "Something went wrong, Please try again");
    }

    AppHelper().hideLoader();

  }

  _changeStatusFav(ChangeStatusFav event, Emitter<QuestionPageState> emit) async{
    AppHelper().showLoader(hasMask: true,dismissOnTap: true);

    await responseSupaBaseRepository?.changeFavStatus(
      id: event.planID,
      status: event.status
    );

    emit(state.copyWith(
        plansFromDB: await _getLastThreePlans()
    ));
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

  _storePlansInDB(String? dateDateTime,List<Plan>? plans,location) async{
    for(var plan in plans!){
      await responseSupaBaseRepository?.createPlans(plan: jsonEncode(plan.toJson()),dateTime: dateDateTime,location: location);
    }
  }

  _getAllPlans() async{
    var data = await responseSupaBaseRepository?.getAllPlans();
    printLog(data!.length);
  }

  Future<List<GetPlanResponseModel>?> _getLastThreePlans() async{
    var data = await responseSupaBaseRepository?.getAllPlans();
    data!.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    List<GetPlanResponseModel> latestThree = data.length > 3
        ? data.sublist(0, 3)
        : data;

    return latestThree;
  }



}

PlansFromAiModel? deserializePlansFromText(String data){
  var dataMap = plansFromAiModelFromJson(data.toString());
  return dataMap;
}
