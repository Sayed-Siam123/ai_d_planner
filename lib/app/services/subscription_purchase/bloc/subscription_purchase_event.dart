import 'package:purchases_flutter/purchases_flutter.dart';

abstract class SubscriptionPurchaseEvent {}

class PurchaseSubscription extends SubscriptionPurchaseEvent {
  final StoreProduct product;
  PurchaseSubscription(this.product);
}

class CheckUserSubscription extends SubscriptionPurchaseEvent {}

class RestorePurchases extends SubscriptionPurchaseEvent {}