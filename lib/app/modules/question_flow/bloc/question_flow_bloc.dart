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

    if(updatedQuestions[event.questionIndex!].selected == null || updatedQuestions[event.questionIndex!].selected != event.selectedAnswer){
      updatedQuestions[event.questionIndex!] = updatedQuestions[event.questionIndex!].copyWith(
        selected: event.selectedAnswer,
      );
    } else if(updatedQuestions[event.questionIndex!].selected == event.selectedAnswer){

      printLog("I am here");
      updatedQuestions[event.questionIndex!] = updatedQuestions[event.questionIndex!].copyWith(
        selected: null,
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
    
    var listData = getStartedQuesModelFromJson(jsonEncode(getStartedDummy));

    emit(state.copyWith(
        questionFlowStateStatus: QuestionFlowStateStatus.loaded,
        getStartedQues: listData
    ));

  }
}
