import 'package:ai_d_planner/app/services/sorting/bloc/sorting_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/utils/helper/print_log.dart';

sortingDI(GetIt? getIt){
  getIt?.registerLazySingleton<SortBloc>(() {
    printLog("registerLazySingleton: SortBloc",level: "t");
    return SortBloc();
  });
}