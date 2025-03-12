import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/network/api_client.dart';
import 'package:ai_d_planner/app/network/api_end_points.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangePasswordRepository{

  ChangePasswordRepository();

  changePass(newPass) async{
    try {
      final supabase = Supabase.instance.client;

      final response = await supabase.auth.updateUser(
        UserAttributes(password: newPass),
      );

      printLog('Password updated successfully: ${response.user?.id}');
    } catch (e) {
      printLog('Error updating password: $e');
    }
  }

}