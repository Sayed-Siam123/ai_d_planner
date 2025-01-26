import 'dart:convert';

import 'package:flutter/material.dart';

List<QuestionPageDummyModel> questionPageDummyModelFromJson(String str) => List<QuestionPageDummyModel>.from(json.decode(str).map((x) => QuestionPageDummyModel.fromJson(x)));

String questionPageDummyModelToJson(List<QuestionPageDummyModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestionPageDummyModel {
  final String? ques;
  final String? hint;
  final String? textFieldType;
  final bool? isMultipleSelect;
  final List<String>? options;
  final TextEditingController textEditingController; // Required field now
  final FocusNode focusNode; // Required field now
  dynamic selected;

  QuestionPageDummyModel({
    this.ques,
    this.hint,
    this.isMultipleSelect,
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
    options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
    textFieldType: json["textFieldType"],
    selected: json["selected"],
    textEditingController: json["selected"] != null && json["selected"][0]["optionID"] == -1 ? TextEditingController(text: json["selected"][0]["option"].toString()) : TextEditingController(), // Always initialize
    focusNode: FocusNode(), // Always initialize
  );

  Map<String, dynamic> toJson() => {
    "ques": ques,
    "hint": hint,
    "isMultipleSelect": isMultipleSelect,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
    "selected": selected ?? [{
      "optionID": -1,
      "option" : textEditingController.value.text
    }],
  };

  QuestionPageDummyModel copyWith({
    String? ques,
    String? hint,
    TextEditingController? textEditingController,
    List<String>? options,
    bool? isMultipleSelect,
    dynamic selected,
    FocusNode? focusNode,
  }) {
    return QuestionPageDummyModel(
      ques: ques ?? this.ques,
      isMultipleSelect: isMultipleSelect ?? this.isMultipleSelect,
      options: options ?? this.options,
      hint: hint ?? this.hint,
      textEditingController: textEditingController ?? this.textEditingController,
      focusNode: focusNode ?? this.focusNode,
      selected: selected ?? this.selected,
    );
  }
}