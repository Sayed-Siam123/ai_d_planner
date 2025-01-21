import 'package:ai_d_planner/app/services/bottom_nav_state/bloc/bottom_nav_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../../core/utils/helper/print_log.dart';

bottomNavStateDI(GetIt? getIt){
  getIt?.registerLazySingleton<BottomNavStateCubit>(() {
    printLog("registerLazySingleton: BottomNavStateCubit",level: "t");
    return BottomNavStateCubit();
  });
}