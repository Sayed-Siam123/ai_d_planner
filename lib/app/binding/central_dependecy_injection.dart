import 'package:ai_d_planner/app/modules/authentication/binding/auth_binding.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/profile/binding/profile_binding.dart';
import 'package:ai_d_planner/app/modules/question_flow/binding/question_flow_binding.dart';
import 'package:ai_d_planner/app/services/filter/binding/filter_binding.dart';
import 'package:get_it/get_it.dart';

import '../core/connection_manager/binding/network_dependecy_injection.dart';
import '../modules/dashboard/tabs/explore/binding/explore_binding.dart';
import '../modules/dashboard/tabs/profile/tabs/change_password/binding/change_pass_binding.dart';
import '../modules/dashboard/tabs/questions/binding/questions_binding.dart';
import '../modules/get_started/binding/get_started_binding.dart';
import '../services/bottom_nav_state/binding/bottom_nav_state_binding.dart';
import '../services/expansion/binding/expansion_binding.dart';
import '../services/password_obscure_operation/binding/password_obscure_ops_dependency_injection.dart';
import '../services/sorting/binding/sorting_binding.dart';
import '../services/subscription_purchase/binding/subscription_purchase_binding.dart';
import '../services/timer_bloc/binding/timer_dependency_injection.dart';

GetIt getIt = GetIt.instance;

dependencySetup() async{
  await networkSetup(getIt);
  await passwordObscureOpsDI(getIt);
  await bottomNavStateDI(getIt);
  await subscriptionPurchaseDI(getIt);
  await getStartedDI(getIt);
  await questionFlowDI(getIt);
  await timerDI(getIt);
  await authDI(getIt);
  await questionsDI(getIt);
  await exploreDI(getIt);
  await profileDI(getIt);
  await sortingDI(getIt);
  await expansionDI(getIt);
  await filterDI(getIt);
  await changePassDI(getIt);
}

isRegistered({object}){
  return getIt.isRegistered(instance: object);
}

unregister({object}){
  return getIt.unregister(instance: object);
}