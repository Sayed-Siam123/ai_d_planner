import 'package:ai_d_planner/app/services/expansion/bloc/expansion_tile_bloc.dart';
import 'package:ai_d_planner/app/services/filter/bloc/filter_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../../core/utils/helper/print_log.dart';

filterDI(GetIt? getIt){
  getIt?.registerLazySingleton<FilterCubit>(() {
    printLog("registerLazySingleton: FilterCubit",level: "t");
    return FilterCubit();
  });
}