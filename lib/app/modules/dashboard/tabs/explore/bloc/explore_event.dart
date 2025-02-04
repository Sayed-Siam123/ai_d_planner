import 'package:equatable/equatable.dart';

abstract class ExploreEvent extends Equatable{}

class FetchAllPlans extends ExploreEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChangeStatusFav extends ExploreEvent {

  final int? planID;
  final bool? status;

  ChangeStatusFav({this.planID,this.status});

  @override
  // TODO: implement props
  List<Object?> get props => [planID,status];
}

class DeletePlan extends ExploreEvent {

  final int? planID;

  DeletePlan({this.planID});

  @override
  // TODO: implement props
  List<Object?> get props => [planID];
}

class SortPlansByDateEvent extends ExploreEvent {
  final bool ascending;

  SortPlansByDateEvent({required this.ascending});

  @override
  // TODO: implement props
  List<Object?> get props => [ascending];
}