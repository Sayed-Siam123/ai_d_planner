import 'dart:convert';

import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseRepo{

  PurchaseRepo();

  Future<void> fetchProducts() async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null && offerings.current!.availablePackages.isNotEmpty) {
        printLog('Available packages: ${jsonEncode(offerings.current!.availablePackages)}');
      } else{
        printLog('Available packages: Null');
      }
    } catch (e) {
      printLog('Error fetching products: $e');
    }
  }

  Future<void> purchaseSubscription(Package package) async {
    try {
      CustomerInfo purchaserInfo = await Purchases.purchasePackage(package);
      printLog('Purchase successful: ${purchaserInfo.entitlements.all}');
    } catch (e) {
      printLog('Purchase failed: $e');
    }
  }

  Future<bool> checkUserSubscription() async {
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    return customerInfo.entitlements.active.isNotEmpty;
  }

  Future<void> restorePurchases() async {
    try {
      CustomerInfo restoredInfo = await Purchases.restorePurchases();
      printLog('Restored purchases: ${restoredInfo.entitlements.active}');
    } catch (e) {
      printLog('Restore failed: $e');
    }
  }
}