import 'package:equatable/equatable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

abstract class GetStartedEvent extends Equatable {}

class ChangeSlideIndicator extends GetStartedEvent {

  final int? currentIndex;

  ChangeSlideIndicator({this.currentIndex});
  @override
  // TODO: implement props
  List<Object?> get props => [currentIndex];
}

class SelectSubscription extends GetStartedEvent {
  final StoreProduct? selectedProduct;
  SelectSubscription(this.selectedProduct);

  @override
  // TODO: implement props
  List<Object?> get props => [selectedProduct];
}

class PurchaseSubsList extends GetStartedEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
