import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import '../../utils/helper/print_log.dart';
import '../internet_cubit/internet_cubit.dart';

networkSetup(GetIt? getIt){
  getIt?.registerLazySingleton<InternetCubit>(() {
    printLog("registerLazySingleton: InternetCubit",level: "t");
    return InternetCubit(connectivity: Connectivity());
  });
}