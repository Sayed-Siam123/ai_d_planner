import 'package:ai_d_planner/app/services/subscription_purchase/bloc/subscription_purchase_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/utils/helper/print_log.dart';

subscriptionPurchaseDI(GetIt? getIt){
  getIt?.registerLazySingleton<SubscriptionPurchaseBloc>(() {
    printLog("registerLazySingleton: SubscriptionPurchaseBloc",level: "t");
    return SubscriptionPurchaseBloc();
  });
}