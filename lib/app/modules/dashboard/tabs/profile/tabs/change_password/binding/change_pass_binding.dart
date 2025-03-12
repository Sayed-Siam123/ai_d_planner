import 'package:ai_d_planner/app/modules/dashboard/tabs/profile/tabs/change_password/bloc/change_password_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../../core/utils/helper/print_log.dart';

changePassDI(GetIt? getIt){
  getIt?.registerLazySingleton<ChangePasswordCubit>(() {
    printLog("registerLazySingleton: ChangePasswordCubit",level: "t");
    return ChangePasswordCubit();
  });
}