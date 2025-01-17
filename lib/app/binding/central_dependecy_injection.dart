import 'package:ai_d_planner/app/modules/question_flow/binding/question_flow_binding.dart';
import 'package:get_it/get_it.dart';

import '../core/connection_manager/binding/network_dependecy_injection.dart';
import '../modules/get_started/binding/get_started_binding.dart';
import '../services/password_obscure_operation/binding/password_obscure_ops_dependency_injection.dart';

GetIt getIt = GetIt.instance;

dependencySetup() async{
  await networkSetup(getIt);
  await passwordObscureOpsDI(getIt);
  await getStartedDI(getIt);
  await questionFlowDI(getIt);
}

isRegistered({object}){
  return getIt.isRegistered(instance: object);
}

unregister({object}){
  return getIt.unregister(instance: object);
}