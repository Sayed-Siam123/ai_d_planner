import 'dart:convert';

List<GetStartedQuesModel> getStartedQuesModelFromJson(String str) => List<GetStartedQuesModel>.from(json.decode(str).map((x) => GetStartedQuesModel.fromJson(x)));

String getStartedQuesModelToJson(List<GetStartedQuesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetStartedQuesModel {
  final String? ques;
  final List<String>? options;
  final bool? isMultipleSelect;
  dynamic selected;

  GetStartedQuesModel({
    this.ques,
    this.isMultipleSelect,
    this.options,
    this.selected = null
  });

  factory GetStartedQuesModel.fromJson(Map<String, dynamic> json) => GetStartedQuesModel(
    ques: json["ques"],
    isMultipleSelect: json["isMultipleSelect"] ?? false,
    options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
    selected: null,
  );

  Map<String, dynamic> toJson() => {
    "ques": ques,
    "isMultipleSelect" : isMultipleSelect,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
    "selected" : selected
  };

  // CopyWith Method
  GetStartedQuesModel copyWith({
    String? ques,
    List<String>? options,
    bool? isMultipleSelect,
    dynamic selected,
  }) {
    return GetStartedQuesModel(
      ques: ques ?? this.ques,
      isMultipleSelect: isMultipleSelect ?? this.isMultipleSelect,
      options: options ?? this.options,
      selected: selected,
    );
  }
}