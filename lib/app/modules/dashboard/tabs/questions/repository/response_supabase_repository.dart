import 'dart:convert';
import 'dart:developer';

import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:ai_d_planner/app/data/models/GetPlanResponseModel.dart';
import 'package:ai_d_planner/app/data/models/plan_from_ai_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/utils/helper/print_log.dart';
import '../../../../../network/api_end_points.dart';

class ResponseSupaBaseRepository {
  ResponseSupaBaseRepository();

  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> createPlans({required String plan, bool? isFav = false,String? dateTime,String? location}) async {
    try {
      // Perform the insert operation
      final response = await _supabase.from(DBConfig.plansTable).insert({
        'user_uid': _supabase.auth.currentUser!.id,
        'is_fav' : isFav,
        'plan' : plan,
        'date_date_time' : dateTime,
        'location_name' : location
      });

      // Check if data is returned to confirm success
      if (response == null) {
        printLog("Plans created successfully");
      } else {
        printLog("Error: No data returned from insert.");
      }
    } catch (e) {
      // Handle any exception thrown by Supabase
      printLog("Error creating Plans: $e");
    }
  }

  Future<List<GetPlanResponseModel>?> getAllPlans() async {
    try {
      final response = await _supabase
          .from(DBConfig.plansTable)
          .select('*')
          .eq(
        'user_uid',
        _supabase.auth.currentUser!.id,
      );

      return responseModelFromJson(jsonEncode(response));
    } catch (e) {
      // Handle any exception thrown by Supabase
      return null;
    }
  }

  Future<void> changeFavStatus({int? id,bool? status}) async {
    try {
      final response = await _supabase
          .from(DBConfig.plansTable)
          .update({'is_fav': status})
          .eq('id', id!);

    } catch (e) {
      // Handle any exception thrown by Supabase
      AppWidgets().getSnackBar(message: e,status: SnackBarStatus.error);
    }
  }

}