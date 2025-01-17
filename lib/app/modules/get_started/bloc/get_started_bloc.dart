import 'package:bloc/bloc.dart';

import 'get_started_event.dart';
import 'get_started_state.dart';


class GetStartedBloc extends Bloc<GetStartedEvent, GetStartedState> {
  GetStartedBloc() : super(GetStartedState(getStartedStateStatus: GetStartedStateStatus.init)) {
    on<ChangeSlideIndicator>(_changeSlideIndicator);
  }

  void _changeSlideIndicator(ChangeSlideIndicator event, Emitter<GetStartedState> emit) async {
    emit(state.copyWith(
      swiperCurrentIndex: event.currentIndex
    ));
  }
}
