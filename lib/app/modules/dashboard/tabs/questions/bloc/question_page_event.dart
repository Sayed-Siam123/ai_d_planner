import 'package:equatable/equatable.dart';

abstract class QuestionPageEvent extends Equatable{}

class FetchQuestionFromDummy extends QuestionPageEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SelectOption extends QuestionPageEvent {

  final int? questionIndex;

  final dynamic selectedAnswer;

  SelectOption({this.questionIndex,this.selectedAnswer});

  @override
  // TODO: implement props
  List<Object?> get props => [selectedAnswer,questionIndex];
}

class ResetOption extends QuestionPageEvent {

  final int? questionIndex;

  ResetOption({this.questionIndex});

  @override
  // TODO: implement props
  List<Object?> get props => [questionIndex];
}