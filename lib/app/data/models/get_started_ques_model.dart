import 'dart:convert';

List<GetStartedQuesModel> getStartedQuesModelFromJson(String str) => List<GetStartedQuesModel>.from(json.decode(str).map((x) => GetStartedQuesModel.fromJson(x)));

String getStartedQuesModelToJson(List<GetStartedQuesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetStartedQuesModel {
  final String? ques;
  final List<String>? options;
  dynamic selected;

  GetStartedQuesModel({
    this.ques,
    this.options,
    this.selected = null
  });

  factory GetStartedQuesModel.fromJson(Map<String, dynamic> json) => GetStartedQuesModel(
    ques: json["ques"],
    options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
    selected: null,
  );

  Map<String, dynamic> toJson() => {
    "ques": ques,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
    "selected" : selected
  };

  // CopyWith Method
  GetStartedQuesModel copyWith({
    String? ques,
    List<String>? options,
    dynamic selected,
  }) {
    return GetStartedQuesModel(
      ques: ques ?? this.ques,
      options: options ?? this.options,
      selected: selected,
    );
  }
}