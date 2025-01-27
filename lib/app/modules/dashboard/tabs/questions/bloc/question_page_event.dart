import 'package:ai_d_planner/app/data/models/question_page_dummy_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class QuestionPageEvent extends Equatable{}

class FetchQuestionFromDummy extends QuestionPageEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SelectOption extends QuestionPageEvent {

  final int? questionIndex;

  final SelectedOption? selectedAnswer;

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

class ResetAll extends QuestionPageEvent {

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchFromGemini extends QuestionPageEvent {

  final PageController? pageController;
  final List<QuestionPageDummyModel>? questionList;

  FetchFromGemini({this.pageController,this.questionList});

  @override
  // TODO: implement props
  List<Object?> get props => [pageController,questionList];
}