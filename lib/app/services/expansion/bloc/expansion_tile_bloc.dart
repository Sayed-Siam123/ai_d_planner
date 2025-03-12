import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// Event: Represents the index of the tile to expand
class ExpansionEvent {
  final int? index;
  ExpansionEvent(this.index);
}

// State: Represents the currently expanded tile index
class ExpansionState {
  final int? expandedIndex; // Null means no tile is expanded
  ExpansionState(this.expandedIndex);
}

// BLoC: Handles the logic for expanding/collapsing tiles
class ExpansionBloc extends Bloc<ExpansionEvent, ExpansionState> {

  ExpansionTileController? expansionTileController;


  ExpansionBloc() : super(ExpansionState(null)) {
    // Register the event handler
    expansionTileController = ExpansionTileController();

    on<ExpansionEvent>(_onExpansionEvent);
  }

  // Event handler for ExpansionEvent
  void _onExpansionEvent(ExpansionEvent event, Emitter<ExpansionState> emit) {
    // If the same tile is tapped, collapse it (set to null)
    if (state.expandedIndex == event.index) {
      emit(ExpansionState(null));
    } else {
      // Otherwise, expand the tapped tile
      emit(ExpansionState(event.index));
    }
  }
}