import 'package:ai_d_planner/app/services/sorting/bloc/sorting_event.dart';
import 'package:ai_d_planner/app/services/sorting/bloc/sorting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortBloc extends Bloc<SortEvent, SortState> {
  SortBloc() : super(SortInitial()) {
    on<SortByBudgetLowToHigh>((event, emit) {
      emit(SortSelected('Budget (Low to High)'));
    });

    on<SortByBudgetHighToLow>((event, emit) {
      emit(SortSelected('Budget (High to Low)'));
    });

    on<SortByAToZ>((event, emit) {
      emit(SortSelected('A-Z'));
    });

    on<SortByZToA>((event, emit) {
      emit(SortSelected('Z-A'));
    });

    on<SortByNewestToOldest>((event, emit) {
      emit(SortSelected('Newest to Oldest'));
    });

    on<SortByOldestToNewest>((event, emit) {
      emit(SortSelected('Oldest to Newest'));
    });
  }
}