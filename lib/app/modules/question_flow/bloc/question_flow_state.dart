import 'package:ai_d_planner/app/data/models/question_page_dummy_model.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/get_started_ques_model.dart';

enum QuestionFlowStateStatus{
  init,
  loading,
  loaded,
  error
}

class QuestionFlowState extends Equatable{

  final QuestionFlowStateStatus? questionFlowStateStatus;
  final List<QuestionPageDummyModel>? getStartedQues;

  final int? currentIndex;

  QuestionFlowState({this.questionFlowStateStatus,this.getStartedQues = null,this.currentIndex = 0});

  QuestionFlowState copyWith({
    QuestionFlowStateStatus? questionFlowStateStatus,
    List<QuestionPageDummyModel>? getStartedQues,
    int? currentIndex
}){
    return QuestionFlowState(
      questionFlowStateStatus: questionFlowStateStatus ?? this.questionFlowStateStatus,
      getStartedQues: getStartedQues ?? this.getStartedQues,
      currentIndex: currentIndex ?? this.currentIndex
    );
}

  @override
  // TODO: implement props
  List<Object?> get props => [questionFlowStateStatus,getStartedQues,currentIndex];
}
