import 'dart:convert';

PlansFromAiModel plansFromAiModelFromJson(String str) => PlansFromAiModel.fromJson(json.decode(str));

String plansFromAiModelToJson(PlansFromAiModel data) => json.encode(data.toJson());

class PlansFromAiModel {
  final List<Plan>? plans;

  PlansFromAiModel({
    this.plans,
  });

  factory PlansFromAiModel.fromJson(Map<String, dynamic> json) => PlansFromAiModel(
    plans: json["plans"] == null ? [] : List<Plan>.from(json["plans"]!.map((x) => Plan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "plans": plans == null ? [] : List<dynamic>.from(plans!.map((x) => x.toJson())),
  };
}

class Plan {
  final int? datePlanId;
  final List<Activity>? activities;
  final int? totalEstimatedCost;

  Plan({
    this.datePlanId,
    this.activities,
    this.totalEstimatedCost,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    datePlanId: json["datePlanId"],
    activities: json["activities"] == null ? [] : List<Activity>.from(json["activities"]!.map((x) => Activity.fromJson(x))),
    totalEstimatedCost: json["totalEstimatedCost"],
  );

  Map<String, dynamic> toJson() => {
    "datePlanId": datePlanId,
    "activities": activities == null ? [] : List<dynamic>.from(activities!.map((x) => x.toJson())),
    "totalEstimatedCost": totalEstimatedCost,
  };
}

class Activity {
  final String? name;
  final String? startTime;
  final double? durationHours;
  final String? description;
  final double? estimatedCost;
  final String? location;

  Activity({
    this.name,
    this.startTime,
    this.durationHours,
    this.description,
    this.estimatedCost,
    this.location,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    name: json["name"],
    startTime: json["startTime"],
    durationHours: double.parse(json["durationHours"].toString()),
    description: json["description"],
    estimatedCost: double.parse(json["estimatedCost"].toString()),
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "startTime": startTime,
    "durationHours": durationHours,
    "description": description,
    "estimatedCost": estimatedCost,
    "location": location,
  };
}
