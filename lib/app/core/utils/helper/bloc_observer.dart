import 'package:flutter_bloc/flutter_bloc.dart';

import 'print_log.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    printLog(bloc.state);
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    printLog(bloc.state);
    super.onChange(bloc, change);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    printLog(bloc.state);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    printLog(bloc.state);
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    printLog(bloc.state);
    super.onClose(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    printLog(error);
    super.onError(bloc, error, stackTrace);
  }
}
