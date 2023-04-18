// To parse this JSON data, do
//
//     final movieErrorModels = movieErrorModelsFromJson(jsonString);

import 'dart:convert';

MovieErrorModels movieErrorModelsFromJson(String str) =>
    MovieErrorModels.fromJson(json.decode(str));

String movieErrorModelsToJson(MovieErrorModels data) =>
    json.encode(data.toJson());

class MovieErrorModels {
  MovieErrorModels({
    required this.statusMessage,
    required this.success,
    required this.statusCode,
  });

  String statusMessage;
  bool success;
  int statusCode;

  factory MovieErrorModels.fromJson(Map<String, dynamic> json) =>
      MovieErrorModels(
        statusMessage: json["status_message"],
        success: json["success"],
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "status_message": statusMessage,
        "success": success,
        "status_code": statusCode,
      };
}
