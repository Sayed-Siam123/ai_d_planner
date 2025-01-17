import 'package:ai_d_planner/app/modules/get_started/bloc/get_started_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/utils/helper/print_log.dart';

getStartedDI(GetIt? getIt){
  getIt?.registerLazySingleton<GetStartedBloc>(() {
    printLog("registerLazySingleton: GetStartedBloc",level: "t");
    return GetStartedBloc();
  });
}