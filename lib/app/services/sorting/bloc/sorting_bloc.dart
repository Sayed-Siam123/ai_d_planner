import 'package:ai_d_planner/app/services/sorting/bloc/sorting_event.dart';
import 'package:ai_d_planner/app/services/sorting/bloc/sorting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


enum SortSelectedItem{
  none,
  budgetLowToHigh,
  budgetHighToLow,
  aToZ,
  zToA,
  newestToOldest,
  oldestToNewest,
}

class SortBloc extends Bloc<SortEvent, SortState> {
  SortBloc() : super(SortSelected(SortSelectedItem.none)) {
    on<SortByNone>((event, emit) {
      emit(SortSelected(SortSelectedItem.none));
    });

    on<SortByBudgetLowToHigh>((event, emit) {
      emit(SortSelected(SortSelectedItem.budgetLowToHigh));
    });

    on<SortByBudgetHighToLow>((event, emit) {
      emit(SortSelected(SortSelectedItem.budgetHighToLow));
    });

    on<SortByAToZ>((event, emit) {
      emit(SortSelected(SortSelectedItem.aToZ));
    });

    on<SortByZToA>((event, emit) {
      emit(SortSelected(SortSelectedItem.zToA));
    });

    on<SortByNewestToOldest>((event, emit) {
      emit(SortSelected(SortSelectedItem.newestToOldest));
    });

    on<SortByOldestToNewest>((event, emit) {
      emit(SortSelected(SortSelectedItem.oldestToNewest));
    });
  }
}