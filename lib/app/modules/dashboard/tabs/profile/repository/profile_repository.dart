import 'dart:convert';

import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/data/models/profile_response_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../network/api_end_points.dart';

class ProfileRepository{
  ProfileRepository();

  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<ProfileResponse>?> getProfileInfo() async {
    try {
      final response = await _supabase
          .from(DBConfig.profileTable)
          .select('*')
          .eq(
        'user_uid',
        _supabase.auth.currentUser!.id,
      );

      return profileResponseFromJson(jsonEncode(response));
    } catch (e) {
      // Handle any exception thrown by Supabase
      return null;
    }
  }

}