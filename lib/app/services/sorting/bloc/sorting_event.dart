import 'package:equatable/equatable.dart';

abstract class SortEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SortByBudgetLowToHigh extends SortEvent {}

class SortByBudgetHighToLow extends SortEvent {}

class SortByAToZ extends SortEvent {}

class SortByZToA extends SortEvent {}

class SortByNewestToOldest extends SortEvent {}

class SortByOldestToNewest extends SortEvent {}