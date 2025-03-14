import 'dart:convert';

import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/modules/get_started/respository/purchase_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../core/utils/helper/app_helper.dart';
import 'get_started_event.dart';
import 'get_started_state.dart';


class GetStartedBloc extends Bloc<GetStartedEvent, GetStartedState> {
  GetStartedBloc() : super(GetStartedState(getStartedStateStatus: GetStartedStateStatus.init)) {
    on<ChangeSlideIndicator>(_changeSlideIndicator);
    on<SelectSubscription>(_selectSubscription);
    on<PurchaseSubsList>(_fetchProducts);
  }

  void _changeSlideIndicator(ChangeSlideIndicator event, Emitter<GetStartedState> emit) async {
    emit(state.copyWith(
      swiperCurrentIndex: event.currentIndex
    ));
  }

  void _selectSubscription(SelectSubscription event, Emitter<GetStartedState> emit) {
    emit(state.copyWith(product: event.selectedProduct));
  }

  _fetchProducts(PurchaseSubsList event, Emitter<GetStartedState> emit) async {
    try {
      AppHelper().showLoader(dismissOnTap: true);

      var data = await Purchases.getOfferings();
      var offerings = data.all["Default"];
      printLog(offerings!.availablePackages[0].storeProduct.price);

      emit(state.copyWith(availablePackageLists: offerings.availablePackages,product: offerings.availablePackages[0].storeProduct));
      AppHelper().hideLoader();
    } catch (e) {
      AppHelper().hideLoader();
    }
  }

}
