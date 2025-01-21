import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationRepository{
  AuthenticationRepository();

  final SupabaseClient _supabase = Supabase.instance.client;
  Future<AuthResponse?>? signUp(String? email,String? password,String? name) async{
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password!,
      );

      await createUserProfile(
        name: name!,
        role: "user",
        authId: response.user!.id
      );

      return response;
    } on AuthException catch (e) {
      // Handle specific AuthException
      AppWidgets().getSnackBar(message: e.message,status: SnackBarStatus.error);
      return null; // Return the error message to the caller
    } catch (e) {
      // Handle other exceptions
      printLog("Unexpected error: $e");
      return null;
    }
  }

  Future<void> createUserProfile({
    required String name,
    required String role,
    required String authId,
  }) async {
    final supabase = Supabase.instance.client;

    try {
      // Perform the insert operation
      final response = await supabase.from('profile').insert({
        'user_uid': authId,
        'name': name,
        'role': role,
      });

      printLog(response);

      // Check if data is returned to confirm success
      if (response == null) {
        printLog("Profile created successfully");
      } else {
        printLog("Error: No data returned from insert.");
      }
    } catch (e) {
      // Handle any exception thrown by Supabase
      printLog("Error creating profile: $e");
    }
  }

}