import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'bottom_nav_state.dart';

class BottomNavStateCubit extends Cubit<BottomNavStateState> {

  BottomNavStateCubit() : super(BottomNavStateState(currentIndex: 0));

  onChangeBottomNav(int? index){
    emit(BottomNavStateState(currentIndex: index));
    return index;
  }

}
