import 'dart:convert';

GeminiResponse geminiResponseFromJson(String str) => GeminiResponse.fromJson(json.decode(str));

String geminiResponseToJson(GeminiResponse data) => json.encode(data.toJson());

class GeminiResponse {
  final List<Candidate>? candidates;
  final UsageMetadata? usageMetadata;
  final String? modelVersion;

  GeminiResponse({
    this.candidates,
    this.usageMetadata,
    this.modelVersion,
  });

  factory GeminiResponse.fromJson(Map<String, dynamic> json) => GeminiResponse(
    candidates: json["candidates"] == null ? [] : List<Candidate>.from(json["candidates"]!.map((x) => Candidate.fromJson(x))),
    usageMetadata: json["usageMetadata"] == null ? null : UsageMetadata.fromJson(json["usageMetadata"]),
    modelVersion: json["modelVersion"],
  );

  Map<String, dynamic> toJson() => {
    "candidates": candidates == null ? [] : List<dynamic>.from(candidates!.map((x) => x.toJson())),
    "usageMetadata": usageMetadata?.toJson(),
    "modelVersion": modelVersion,
  };
}

class Candidate {
  final Content? content;
  final String? finishReason;
  final List<SafetyRating>? safetyRatings;
  final double? avgLogprobs;

  Candidate({
    this.content,
    this.finishReason,
    this.safetyRatings,
    this.avgLogprobs,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
    content: json["content"] == null ? null : Content.fromJson(json["content"]),
    finishReason: json["finishReason"],
    safetyRatings: json["safetyRatings"] == null ? [] : List<SafetyRating>.from(json["safetyRatings"]!.map((x) => SafetyRating.fromJson(x))),
    avgLogprobs: json["avgLogprobs"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "content": content?.toJson(),
    "finishReason": finishReason,
    "safetyRatings": safetyRatings == null ? [] : List<dynamic>.from(safetyRatings!.map((x) => x.toJson())),
    "avgLogprobs": avgLogprobs,
  };
}

class Content {
  final List<Part>? parts;
  final String? role;

  Content({
    this.parts,
    this.role,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    parts: json["parts"] == null ? [] : List<Part>.from(json["parts"]!.map((x) => Part.fromJson(x))),
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "parts": parts == null ? [] : List<dynamic>.from(parts!.map((x) => x.toJson())),
    "role": role,
  };
}

class Part {
  final String? text;

  Part({
    this.text,
  });

  factory Part.fromJson(Map<String, dynamic> json) => Part(
    text: json["text"].replaceAll(RegExp(r"^```json|```|\n"), ""),
  );

  Map<String, dynamic> toJson() => {
    "text": text,
  };
}

class SafetyRating {
  final String? category;
  final String? probability;

  SafetyRating({
    this.category,
    this.probability,
  });

  factory SafetyRating.fromJson(Map<String, dynamic> json) => SafetyRating(
    category: json["category"],
    probability: json["probability"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "probability": probability,
  };
}

class UsageMetadata {
  final int? promptTokenCount;
  final int? candidatesTokenCount;
  final int? totalTokenCount;

  UsageMetadata({
    this.promptTokenCount,
    this.candidatesTokenCount,
    this.totalTokenCount,
  });

  factory UsageMetadata.fromJson(Map<String, dynamic> json) => UsageMetadata(
    promptTokenCount: json["promptTokenCount"],
    candidatesTokenCount: json["candidatesTokenCount"],
    totalTokenCount: json["totalTokenCount"],
  );

  Map<String, dynamic> toJson() => {
    "promptTokenCount": promptTokenCount,
    "candidatesTokenCount": candidatesTokenCount,
    "totalTokenCount": totalTokenCount,
  };
}
