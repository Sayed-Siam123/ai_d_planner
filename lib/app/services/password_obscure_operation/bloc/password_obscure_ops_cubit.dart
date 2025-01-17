import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'password_obscure_ops_state.dart';

class PasswordObscureCubit extends Cubit<PasswordObscureState> {
  PasswordObscureCubit() : super(const PasswordObscureState(isShow: false));

  toggleObscureOnClick({currentValue}){
    if(currentValue == false){
      emit(PasswordObscureState(isShow: true));
      return true;
    } else{
      emit(PasswordObscureState(isShow: false));
      return false;
    }
  }

}
