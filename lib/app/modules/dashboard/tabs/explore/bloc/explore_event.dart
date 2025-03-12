import 'package:ai_d_planner/app/services/sorting/bloc/sorting_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

class SortPlansList extends ExploreEvent {
  final bool ascending;
  final SortSelectedItem sortSelectedItem;

  SortPlansList({required this.ascending,required this.sortSelectedItem});

  @override
  // TODO: implement props
  List<Object?> get props => [ascending,sortSelectedItem];
}

class FilterPlansEvent extends ExploreEvent {
  final DateTimeRange? startEndDate;
  final String? location;
  final RangeValues? budgetRange;
  final String? moodType,dateType;


  FilterPlansEvent({this.startEndDate = null, this.location = null,this.budgetRange = null, this.moodType = null,this.dateType = null});

  @override
  // TODO: implement props
  List<Object?> get props => [startEndDate,location,budgetRange,moodType,dateType];
}