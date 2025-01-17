import 'package:ai_d_planner/app/data/models/get_started_ques_model.dart';
import 'package:equatable/equatable.dart';

abstract class QuestionFlowEvent extends Equatable{}

class ChangeToNext extends QuestionFlowEvent {
  final int? pageCurrentIndex;
  ChangeToNext({this.pageCurrentIndex});
  @override
  // TODO: implement props
  List<Object?> get props => [pageCurrentIndex];
}

class FetchDummyQues extends QuestionFlowEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SelectOption extends QuestionFlowEvent {

  final int? questionIndex;

  final dynamic selectedAnswer;

  SelectOption({this.questionIndex,this.selectedAnswer});

  @override
  // TODO: implement props
  List<Object?> get props => [selectedAnswer,questionIndex];
}