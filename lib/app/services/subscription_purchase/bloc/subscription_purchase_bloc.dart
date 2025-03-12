import 'dart:convert';
import 'dart:developer';

import 'package:ai_d_planner/app/core/utils/helper/app_helper.dart';
import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/modules/get_started/respository/purchase_repository.dart';
import 'package:ai_d_planner/app/services/subscription_purchase/bloc/subscription_purchase_event.dart';
import 'package:ai_d_planner/app/services/subscription_purchase/bloc/subscription_purchase_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../data/models/subscription_response_model.dart';

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
      CustomerInfo customerInfo = await Purchases.purchaseStoreProduct(event.product);
      emit(PurchaseSuccess(customerInfo));
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
      await Purchases.restorePurchases();
      emit(RestoreSuccess());
    } catch (e) {
      emit(RestoreFailure("Restore failed: $e"));
    }
  }
}
