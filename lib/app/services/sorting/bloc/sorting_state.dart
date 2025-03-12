import 'package:ai_d_planner/app/services/sorting/bloc/sorting_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class SortState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SortInitial extends SortState {}

class SortSelected extends SortState {
  final SortSelectedItem sortOption;

  SortSelected(this.sortOption);

  @override
  List<Object?> get props => [sortOption];
}