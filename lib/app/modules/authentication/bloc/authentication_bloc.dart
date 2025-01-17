import 'package:bloc/bloc.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.clone());
  }
}
