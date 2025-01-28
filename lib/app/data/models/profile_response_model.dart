// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

List<ProfileResponse> profileResponseFromJson(String str) => List<ProfileResponse>.from(json.decode(str).map((x) => ProfileResponse.fromJson(x)));

String profileResponseToJson(List<ProfileResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileResponse {
  final int? id;
  final String? name;
  final String? role;
  final DateTime? createdAt;
  final String? userUid;

  ProfileResponse({
    this.id,
    this.name,
    this.role,
    this.createdAt,
    this.userUid,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
    id: json["id"],
    name: json["name"],
    role: json["role"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    userUid: json["user_uid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "role": role,
    "created_at": createdAt?.toIso8601String(),
    "user_uid": userUid,
  };
}
