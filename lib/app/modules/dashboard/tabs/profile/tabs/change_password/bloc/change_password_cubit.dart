import 'package:bloc/bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'change_password_state.dart';


class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final SupabaseClient _supabase = Supabase.instance.client;

  ChangePasswordCubit() : super(ChangePasswordInitial());

  Future<void> changePassword(String newPassword) async {
    emit(ChangePasswordLoading());
    try {
      await _supabase.auth.updateUser(UserAttributes(password: newPassword));
      emit(ChangePasswordSuccess());
    } catch (error) {
      emit(ChangePasswordFailure(error.toString()));
    }
  }
}
