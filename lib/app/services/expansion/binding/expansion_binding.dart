import 'package:ai_d_planner/app/services/expansion/bloc/expansion_tile_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/utils/helper/print_log.dart';

expansionDI(GetIt? getIt){
  getIt?.registerLazySingleton<ExpansionBloc>(() {
    printLog("registerLazySingleton: ExpansionBloc",level: "t");
    return ExpansionBloc();
  });
}