
import 'package:ai_d_planner/app/data/models/GetPlanResponseModel.dart';
import 'package:equatable/equatable.dart';

enum ExploreStateStatus{
  init,
  loading,
  success,
  error
}

class ExploreState extends Equatable{
  final ExploreStateStatus? exploreStateStatus;
  final List<GetPlanResponseModel>? favList,upcomingList,passedList;

  const ExploreState({this.exploreStateStatus,this.favList,this.passedList,this.upcomingList});

  ExploreState copyWith({
    ExploreStateStatus? exploreStateStatus,
    List<GetPlanResponseModel>? favList,
    List<GetPlanResponseModel>? upcomingList,
    List<GetPlanResponseModel>? passedList
}){
    return ExploreState(
      exploreStateStatus: exploreStateStatus ?? this.exploreStateStatus,
      favList: favList ?? this.favList,
      upcomingList: upcomingList ?? this.upcomingList,
      passedList: passedList ?? this.passedList
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [exploreStateStatus,favList,upcomingList,passedList];



}
