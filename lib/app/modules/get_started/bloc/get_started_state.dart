import 'package:equatable/equatable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

enum GetStartedStateStatus{
  init,
  loading,
  loaded,
  error
}

class GetStartedState extends Equatable{
  final GetStartedStateStatus? getStartedStateStatus;
  final int? swiperCurrentIndex;
  final List<Package>? availablePackageLists;
  final StoreProduct? product;

  GetStartedState({this.getStartedStateStatus,this.swiperCurrentIndex,this.product,this.availablePackageLists});

  GetStartedState copyWith({
    GetStartedStateStatus? getStartedStateStatus,
    int? swiperCurrentIndex,
    StoreProduct? product,
    List<Package>? availablePackageLists,
}){
    return GetStartedState(
      getStartedStateStatus: getStartedStateStatus ?? this.getStartedStateStatus,
      swiperCurrentIndex: swiperCurrentIndex ?? this.swiperCurrentIndex,
      product: product,
      availablePackageLists: availablePackageLists ?? this.availablePackageLists
    );
}

  @override
  // TODO: implement props
  List<Object?> get props => [getStartedStateStatus,swiperCurrentIndex,product];




}
