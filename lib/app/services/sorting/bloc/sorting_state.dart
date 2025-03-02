import 'package:equatable/equatable.dart';

abstract class SortState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SortInitial extends SortState {}

class SortSelected extends SortState {
  final String sortOption;

  SortSelected(this.sortOption);

  @override
  List<Object?> get props => [sortOption];
}