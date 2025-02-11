import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:ai_d_planner/app/network/api_end_points.dart';
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

      final user = _supabase.auth.currentUser;

      if (user != null) {
        printLog('User authenticated');
        await createUserProfile(
            name: name!,
            role: "user",
            authId: user.id
        );
        await _supabase.auth.signOut();
        return response;
      } else{
        printLog('User not authenticated');
        return null;
      }
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

  Future<AuthResponse?>? signInUser(String email, String password) async {

    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      return response;
    } on AuthException catch (e) {
      // Handle specific AuthException
      print(e.message);
      AppWidgets().getSnackBar(message: e.message,status: SnackBarStatus.error);
      return null; // Return the error message to the caller
    } catch (e) {
      // Handle other exceptions
      printLog("Unexpected error: $e");
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
    } on AuthException catch (e) {
      AppWidgets().getSnackBar(message: e.message,status: SnackBarStatus.error);
    } catch (e) {
      // Handle other exceptions
      printLog("Unexpected error: $e");
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
      final response = await supabase.from(DBConfig.profileTable).insert({
        'user_uid': authId,
        'name': name,
        'role': role,
      });

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

  Future<bool> getUserProfileByID(userID) async {
    try {
      final response = await _supabase
          .from(DBConfig.profileTable)
          .select('*')
          .eq(
        'user_uid',
        userID,
      );

      //return responseModelFromJson(jsonEncode(response));
      return response.isNotEmpty ? true : false;
    } catch (e) {
      // Handle any exception thrown by Supabase
      return false;
    }
  }


  /*
  *final data = await _supabase
          .from('followers_with_names')
          .select('*')
          .eq(
            'user_id',
            _currentUuid,
          )
  * */

}