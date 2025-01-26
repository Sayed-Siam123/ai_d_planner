import 'dart:convert';

import 'package:flutter/material.dart';

List<QuestionPageDummyModel> questionPageDummyModelFromJson(String str) => List<QuestionPageDummyModel>.from(json.decode(str).map((x) => QuestionPageDummyModel.fromJson(x)));

String questionPageDummyModelToJson(List<QuestionPageDummyModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestionPageDummyModel {
  final String? ques;
  final String? hint;
  final String? textFieldType;
  final bool? isMultipleSelect,isRequired;
  final List<String>? options;
  final TextEditingController textEditingController; // Required field now
  final FocusNode focusNode; // Required field now
  dynamic selected;

  QuestionPageDummyModel({
    this.ques,
    this.hint,
    this.isMultipleSelect,
    this.isRequired,
    this.options,
    TextEditingController? textEditingController, // Accept as optional in constructor
    FocusNode? focusNode, // Accept as optional in constructor
    this.selected,
    this.textFieldType,
  })  : textEditingController = textEditingController ?? TextEditingController(), // Default initialization
        focusNode = focusNode ?? FocusNode(); // Default initialization

  factory QuestionPageDummyModel.fromJson(Map<String, dynamic> json) => QuestionPageDummyModel(
    ques: json["ques"],
    hint: json["hint"],
    isMultipleSelect: json["isMultipleSelect"],
    isRequired: json["isRequired"],
    options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
    textFieldType: json["textFieldType"],
    selected: json["selected"],
    textEditingController: _initializeTextEditingController(json["selected"]),
    //textEditingController: json["selected"] != null && json["selected"][0]["optionID"] == -1 ? TextEditingController(text: json["selected"][0]["option"].toString()) : TextEditingController(), // Always initialize
    focusNode: FocusNode(), // Always initialize
  );

  Map<String, dynamic> toJson() => {
    "ques": ques,
    "hint": hint,
    "isMultipleSelect": isMultipleSelect,
    "isRequired" : isRequired,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
    "selected": _getSelectedValue(),
  };

  QuestionPageDummyModel copyWith({
    String? ques,
    String? hint,
    TextEditingController? textEditingController,
    List<String>? options,
    bool? isMultipleSelect,
    bool? isRequired,
    dynamic selected,
    FocusNode? focusNode,
    String? textFieldType
  }) {
    return QuestionPageDummyModel(
      ques: ques ?? this.ques,
      isMultipleSelect: isMultipleSelect ?? this.isMultipleSelect,
      isRequired: isRequired ?? this.isRequired,
      options: options ?? this.options,
      hint: hint ?? this.hint,
      textEditingController: textEditingController ?? this.textEditingController,
      focusNode: focusNode ?? this.focusNode,
      selected: selected ?? this.selected,
      textFieldType: textFieldType ?? this.textFieldType
    );
  }

  _getSelectedValue() {
    if (selected == null || (selected is List && selected.any((item) => item["option"]?.toLowerCase() == "custom"))) {
      return [{
        "optionID": -1, // Indicating custom input
        "option": textEditingController.value.text.trim()
      }];
    }

    return selected;
  }

  static TextEditingController _initializeTextEditingController(dynamic selected) {
    if (selected != null &&
        selected is List &&
        selected.isNotEmpty &&
        selected[0]["optionID"] == -1 &&
        selected[0]["option"] != null) {
      return TextEditingController(text: selected[0]["option"].toString().trim());
    }
    return TextEditingController();
  }
}