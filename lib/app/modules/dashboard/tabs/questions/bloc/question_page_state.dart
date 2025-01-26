
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

  QuestionPageState({this.questionPageStateStatus,this.questionPageDummyData,this.questionPageStateApiStatus});

  QuestionPageState copyWith({
    QuestionPageStateStatus? questionPageStateStatus,
    List<QuestionPageDummyModel>? questionPageDummyData,
    QuestionPageStateApiStatus? questionPageStateApiStatus,
}){
    return QuestionPageState(
      questionPageStateStatus: questionPageStateStatus ?? this.questionPageStateStatus,
        questionPageDummyData: questionPageDummyData ?? this.questionPageDummyData,
      questionPageStateApiStatus: questionPageStateApiStatus ?? this.questionPageStateApiStatus
    );
}

  @override
  // TODO: implement props
  List<Object?> get props => [questionPageStateStatus,questionPageDummyData,questionPageStateApiStatus];

}
