import 'package:ai_d_planner/app/modules/dashboard/tabs/profile/bloc/profile_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/utils/helper/print_log.dart';

profileDI(GetIt? getIt){
  getIt?.registerLazySingleton<ProfileBloc>(() {
    printLog("registerLazySingleton: ProfileBloc",level: "t");
    return ProfileBloc();
  });
}