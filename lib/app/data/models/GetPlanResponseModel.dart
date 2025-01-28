import 'dart:convert';

import 'package:ai_d_planner/app/data/models/plan_from_ai_model.dart';

List<GetPlanResponseModel> responseModelFromJson(String str) => List<GetPlanResponseModel>.from(json.decode(str).map((x) => GetPlanResponseModel.fromJson(x)));
String responseModelToJson(List<GetPlanResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetPlanResponseModel {
  final int? id;
  final String? userUid;
  final String? location;
  final String? dateDateTime;
  final bool? isFav;
  final Plan? plan;
  final DateTime? createdAt;

  GetPlanResponseModel({
    this.id,
    this.userUid,
    this.isFav,
    this.plan,
    this.createdAt,
    this.location,
    this.dateDateTime
  });

  factory GetPlanResponseModel.fromJson(Map<String, dynamic> json) => GetPlanResponseModel(
    id: json["id"],
    userUid: json["user_uid"],
    isFav: json["is_fav"],
    location: json["location_name"],
    dateDateTime: json["date_date_time"],
    plan: json["plan"] == null ? null : Plan.fromJson(jsonDecode(json["plan"])),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_uid": userUid,
    "is_fav": isFav,
    "location_name" : location,
    "date_date_time" : dateDateTime,
    "plan": plan == null ? null : jsonEncode(plan!.toJson()),
    "created_at": createdAt?.toIso8601String(),
  };
}