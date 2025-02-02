import 'dart:convert';
import 'package:flutter/material.dart';

List<QuestionPageDummyModel> questionPageDummyModelFromJson(String str) =>
    List<QuestionPageDummyModel>.from(
        json.decode(str).map((x) => QuestionPageDummyModel.fromJson(x)));

String questionPageDummyModelToJson(List<QuestionPageDummyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestionPageDummyModel {
  GlobalKey? questionKey;
  final String? ques;
  final String? hint;
  final String? textFieldType;
  final bool? isMultipleSelect;
  final bool? isRequired;
  final List<String>? options;
  final TextEditingController textEditingController; // Required field now
  final FocusNode focusNode; // Required field now
  List<SelectedOption>? selectedData; // Using SelectedOption class here

  QuestionPageDummyModel({
    this.questionKey,
    this.ques,
    this.hint,
    this.isMultipleSelect,
    this.isRequired,
    this.options,
    TextEditingController? textEditingController,
    FocusNode? focusNode,
    this.selectedData,
    this.textFieldType,
  })  : textEditingController = textEditingController ?? TextEditingController(), // Default initialization
        focusNode = focusNode ?? FocusNode(); // Default initialization

  factory QuestionPageDummyModel.fromJson(Map<String, dynamic> json) =>
      QuestionPageDummyModel(
        questionKey: GlobalKey(),
        ques: json["ques"],
        hint: json["hint"],
        isMultipleSelect: json["isMultipleSelect"],
        isRequired: json["isRequired"],
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"].map((x) => x)),
        textFieldType: json["textFieldType"],
        // selectedData: json["selected"] == null
        //     ? []
        //     : List<SelectedOption>.from(
        //     json["selected"].map((x) => SelectedOption.fromJson(x))),
        // textEditingController: _initializeTextEditingController(json["selected"]),
        selectedData: json["selected"] == null || json["selected"].isEmpty
            ? []
            : List<SelectedOption>.from(
            json["selected"].map((x) => SelectedOption.fromJson(x))),
        textEditingController: _initializeTextEditingController(
            json["options"],
            json["selected"]),
        focusNode: FocusNode(),
      );

  Map<String, dynamic> toJson() => {
    "ques": ques,
    "hint": hint,
    "isMultipleSelect": isMultipleSelect,
    "isRequired": isRequired,
    "options": options == null
        ? []
        : List<dynamic>.from(options!.map((x) => x)),
    "selected": _getSelectedValue(),
  };

  QuestionPageDummyModel copyWith({
    String? ques,
    String? hint,
    TextEditingController? textEditingController,
    List<String>? options,
    bool? isMultipleSelect,
    bool? isRequired,
    List<SelectedOption>? selected,
    FocusNode? focusNode,
    String? textFieldType,
  }) {
    return QuestionPageDummyModel(
      ques: ques ?? this.ques,
      isMultipleSelect: isMultipleSelect ?? this.isMultipleSelect,
      isRequired: isRequired ?? this.isRequired,
      options: options ?? this.options,
      hint: hint ?? this.hint,
      textEditingController:
      textEditingController ?? this.textEditingController,
      focusNode: focusNode ?? this.focusNode,
      selectedData: selected ?? this.selectedData,
      textFieldType: textFieldType ?? this.textFieldType,
    );
  }

  _getSelectedValue() {
    return (options == null || options!.isEmpty ||
        selectedData == null ||
        (selectedData is List<SelectedOption> &&
            selectedData!.any((item) => item.option?.toLowerCase() == "custom")))
        ? [{
      "optionID": -1, // Indicating custom input
      "option": textEditingController.value.text.trim(),
    }] : List<dynamic>.from(selectedData!.map((x) => x.toJson()));
  }

  /*static TextEditingController _initializeTextEditingController(
      List<dynamic>? selected) {
    if (selected != null &&
        selected.isNotEmpty &&
        selected[0]["optionID"] == -1 &&
        selected[0]["option"] != null) {
      return TextEditingController(text: selected[0]["option"].toString().trim());
    }
    return TextEditingController();
  }*/
  static TextEditingController _initializeTextEditingController(
      List<dynamic>? options,
      List<dynamic>? selected) {
    if ((options == null || options.isEmpty) && selected != null && selected.isNotEmpty) {
      // If no options are provided, treat as a text field
      if (selected[0]["optionID"] == -1 && selected[0]["option"] != null) {
        return TextEditingController(text: selected[0]["option"].toString().trim());
      }
    } else if (selected != null &&
        selected.isNotEmpty &&
        selected[0]["optionID"] == -1 &&
        selected[0]["option"] != null) {
      // Handle "custom" option case
      return TextEditingController(text: selected[0]["option"].toString().trim());
    }
    // Default case
    return TextEditingController();
  }
}

class SelectedOption {
  int? optionID;
  String? option;

  SelectedOption({this.optionID, this.option});

  factory SelectedOption.fromJson(Map<String, dynamic> json) {
    return SelectedOption(
      optionID: json['optionID'],
      option: json['option'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'optionID': optionID,
      'option': option,
    };
  }
}
