import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class FilterState {
  final String location;
  final DateTimeRange? dateRange;
  final RangeValues budgetRange;
  final String? mood;
  final String? dateType;

  FilterState({
    this.location = '',
    this.dateRange,
    this.budgetRange = const RangeValues(100, 1000),
    this.mood,
    this.dateType,
  });

  FilterState copyWith({
    String? location,
    DateTimeRange? dateRange,
    RangeValues? budgetRange,
    String? mood,
    String? dateType,
  }) {
    return FilterState(
      location: location ?? this.location,
      dateRange: dateRange ?? this.dateRange,
      budgetRange: budgetRange ?? this.budgetRange,
      mood: mood ?? this.mood,
      dateType: dateType ?? this.dateType,
    );
  }
}

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState());

  void updateLocation(String location) => emit(state.copyWith(location: location));
  void updateDateRange(DateTimeRange? range) => emit(state.copyWith(dateRange: range));
  void updateBudgetRange(RangeValues range) => emit(state.copyWith(budgetRange: range));
  void updateMood(String? mood) => emit(state.copyWith(mood: mood));
  void updateDateType(String? dateType) => emit(state.copyWith(dateType: dateType));

  void resetFilters() => emit(FilterState());
}