import 'package:ai_d_planner/app/modules/dashboard/tabs/explore/bloc/explore_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/utils/helper/print_log.dart';

exploreDI(GetIt? getIt){
  getIt?.registerLazySingleton<ExploreBloc>(() {
    printLog("registerLazySingleton: ExploreBloc",level: "t");
    return ExploreBloc();
  });
}