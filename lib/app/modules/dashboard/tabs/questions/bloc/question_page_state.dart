
import 'package:ai_d_planner/app/data/models/GetPlanResponseModel.dart';
import 'package:ai_d_planner/app/data/models/plan_from_ai_model.dart';
import 'package:ai_d_planner/app/data/models/question_page_dummy_model.dart';
import 'package:equatable/equatable.dart';

enum QuestionPageStateStatus{
  init,
  loading,
  success,
  error
}

enum QuestionPageStateApiStatus{
  init,
  loading,
  success,
  error
}

class QuestionPageState extends Equatable{
  final QuestionPageStateStatus? questionPageStateStatus;
  final QuestionPageStateApiStatus? questionPageStateApiStatus;

  final List<QuestionPageDummyModel>? questionPageDummyData;
  final List<QuestionPageDummyModel>? regenerateQuestionPageDummyData;
  final List<GetPlanResponseModel>? plansFromDB;


  QuestionPageState({this.questionPageStateStatus,this.questionPageDummyData,this.questionPageStateApiStatus,this.plansFromDB,this.regenerateQuestionPageDummyData});

  QuestionPageState copyWith({
    QuestionPageStateStatus? questionPageStateStatus,
    List<QuestionPageDummyModel>? questionPageDummyData,
    QuestionPageStateApiStatus? questionPageStateApiStatus,
    List<GetPlanResponseModel>? plansFromDB,
    List<QuestionPageDummyModel>? regenerateQuestionPageDummyData,
  }){
    return QuestionPageState(
      questionPageStateStatus: questionPageStateStatus ?? this.questionPageStateStatus,
        questionPageDummyData: questionPageDummyData ?? this.questionPageDummyData,
      regenerateQuestionPageDummyData: regenerateQuestionPageDummyData ?? this.regenerateQuestionPageDummyData,
      questionPageStateApiStatus: questionPageStateApiStatus ?? this.questionPageStateApiStatus,
      plansFromDB: plansFromDB ?? this.plansFromDB
    );
}

  @override
  // TODO: implement props
  List<Object?> get props => [questionPageStateStatus,questionPageDummyData,questionPageStateApiStatus,plansFromDB,regenerateQuestionPageDummyData];

}
