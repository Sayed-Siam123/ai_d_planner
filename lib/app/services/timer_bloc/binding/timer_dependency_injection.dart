import 'package:get_it/get_it.dart';

import '../../../core/utils/helper/print_log.dart';
import '../cubit/timer_bloc_cubit.dart';

timerDI(GetIt? getIt){
  getIt?.registerLazySingleton<TimerCubit>(() {
    printLog("registerLazySingleton: TimerBlocCubit",level: "t");
    return TimerCubit();
  });
}