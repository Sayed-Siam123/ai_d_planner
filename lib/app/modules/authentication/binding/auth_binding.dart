import 'package:ai_d_planner/app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/utils/helper/print_log.dart';

authDI(GetIt? getIt){
  getIt?.registerLazySingleton<AuthenticationBloc>(() {
    printLog("registerLazySingleton: AuthenticationBloc",level: "t");
    return AuthenticationBloc();
  });
}