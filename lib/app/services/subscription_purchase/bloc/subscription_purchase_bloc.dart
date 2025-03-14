import 'dart:convert';
import 'dart:developer';

import 'package:ai_d_planner/app/core/utils/helper/app_helper.dart';
import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:ai_d_planner/app/modules/get_started/respository/purchase_repository.dart';
import 'package:ai_d_planner/app/services/subscription_purchase/bloc/subscription_purchase_event.dart';
import 'package:ai_d_planner/app/services/subscription_purchase/bloc/subscription_purchase_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../data/models/page_route_arguments.dart';
import '../../../data/models/subscription_response_model.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/app_routes.dart';

class SubscriptionPurchaseBloc extends Bloc<SubscriptionPurchaseEvent, SubscriptionPurchaseState> {

  PurchaseRepo? purchaseRepo;

  SubscriptionPurchaseBloc() : super(GetStartedInitial()) {
    purchaseRepo = PurchaseRepo();

    on<PurchaseSubscription>(_purchaseSubscription);
    on<CheckUserSubscription>(_checkUserSubscription);
    on<RestorePurchases>(_restorePurchases);
  }

  Future<void> _purchaseSubscription(PurchaseSubscription event, Emitter<SubscriptionPurchaseState> emit) async {
    try {
      emit(PurchaseLoading());
      AppHelper().showLoader(dismissOnTap: false,hasMask: true);
      CustomerInfo customerInfo = await Purchases.purchaseStoreProduct(event.product);
      emit(PurchaseSuccess(customerInfo));
      AppHelper().hideLoader();
      await _forwardTask();
    } catch (e) {
      emit(PurchaseFailure("Purchase failed: $e"));
    }
  }

  Future<void> _checkUserSubscription(CheckUserSubscription event, Emitter<SubscriptionPurchaseState> emit) async {
    try {
      emit(PurchaseLoading());
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      bool isSubscribed = customerInfo.entitlements.active.isNotEmpty;
      if (isSubscribed) {
        emit(SubscriptionActive());
      } else {
        emit(SubscriptionInactive());
      }
    } catch (e) {
      emit(PurchaseFailure("Error checking subscription: $e"));
    }
  }

  Future<void> _restorePurchases(RestorePurchases event, Emitter<SubscriptionPurchaseState> emit) async {
    try {
      emit(PurchaseLoading());
      AppHelper().showLoader(dismissOnTap: false,hasMask: true);
      await Purchases.restorePurchases();

      CustomerInfo customerInfo = await Purchases.getCustomerInfo();

      bool isSubscribed = customerInfo.entitlements.active.isNotEmpty;

      printLog(jsonEncode(customerInfo.entitlements.active.isNotEmpty));

      if(!isSubscribed){
        AppWidgets().getSnackBar(
          status: SnackBarStatus.error,
          message: "Please subscribe a plan first!"
        );
      } else{
        AppHelper().hideLoader();
        await _forwardTask();
      }

      AppHelper().hideLoader();

      emit(RestoreSuccess());
    } catch (e) {
      emit(RestoreFailure("Restore failed: $e"));
    }
  }

  _forwardTask() {
    toReplacementNamed(AppRoutes.login,
        args: PageRouteArg(
          to: AppRoutes.login,
          from: AppRoutes.packagePricePlan,
          pageRouteType: PageRouteType.pushReplacement,
          isFromDashboardNav: false,
        ));
  }
}
