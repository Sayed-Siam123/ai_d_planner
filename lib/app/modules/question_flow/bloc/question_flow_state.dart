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
  final List<GetStartedQuesModel>? getStartedQues;

  final int? currentIndex;

  QuestionFlowState({this.questionFlowStateStatus,this.getStartedQues = null,this.currentIndex = 0});

  QuestionFlowState copyWith({
    QuestionFlowStateStatus? questionFlowStateStatus,
    List<GetStartedQuesModel>? getStartedQues,
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
