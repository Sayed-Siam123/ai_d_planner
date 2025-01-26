
import 'package:ai_d_planner/app/data/models/question_page_dummy_model.dart';
import 'package:equatable/equatable.dart';

enum QuestionPageStateStatus{
  init,
  loading,
  success,
  error
}

class QuestionPageState extends Equatable{
  final QuestionPageStateStatus? questionPageStateStatus;
  final List<QuestionPageDummyModel>? questionPageDummyData;

  QuestionPageState({this.questionPageStateStatus,this.questionPageDummyData});

  QuestionPageState copyWith({
    QuestionPageStateStatus? questionPageStateStatus,
    List<QuestionPageDummyModel>? questionPageDummyData
}){
    return QuestionPageState(
      questionPageStateStatus: questionPageStateStatus ?? this.questionPageStateStatus,
        questionPageDummyData: questionPageDummyData ?? this.questionPageDummyData
    );
}

  @override
  // TODO: implement props
  List<Object?> get props => [questionPageStateStatus,questionPageDummyData];

}
