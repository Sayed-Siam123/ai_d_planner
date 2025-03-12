import 'package:purchases_flutter/purchases_flutter.dart';

abstract class SubscriptionPurchaseState {}

class GetStartedInitial extends SubscriptionPurchaseState {}

class PurchaseLoading extends SubscriptionPurchaseState {}

class PurchaseSuccess extends SubscriptionPurchaseState {
  final CustomerInfo customerInfo;
  PurchaseSuccess(this.customerInfo);
}

class PurchaseFailure extends SubscriptionPurchaseState {
  final String error;
  PurchaseFailure(this.error);
}

class SubscriptionActive extends SubscriptionPurchaseState {}

class SubscriptionInactive extends SubscriptionPurchaseState {}

class RestoreSuccess extends SubscriptionPurchaseState {}

class RestoreFailure extends SubscriptionPurchaseState {
  final String error;
  RestoreFailure(this.error);
}

class ProductsFetched extends SubscriptionPurchaseState {
  final List<Package> products;
  ProductsFetched(this.products);
}
