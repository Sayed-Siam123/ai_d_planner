import 'package:get_it/get_it.dart';
import '../../../core/utils/helper/print_log.dart';
import '../bloc/password_obscure_ops_cubit.dart';

passwordObscureOpsDI(GetIt? getIt){
  getIt?.registerLazySingleton<PasswordObscureCubit>(() {
    printLog("registerLazySingleton: PasswordObscureCubit",level: "t");
    return PasswordObscureCubit();
  });
}