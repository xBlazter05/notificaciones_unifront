// To parse this JSON data, do
//
//     final nivelModel = nivelModelFromJson(jsonString);

import 'dart:convert';

NivelModel nivelModelFromJson(String str) =>
    NivelModel.fromJson(json.decode(str));

String nivelModelToJson(NivelModel data) => json.encode(data.toJson());

class NivelModel {
  NivelModel({
    required this.niveles,
    required this.status,
    required this.message,
    required this.code,
  });

  List<Nivele> niveles;
  String status;
  String message;
  int code;

  factory NivelModel.fromJson(Map<String, dynamic> json) => NivelModel(
        niveles: json["niveles"] != null
            ? List<Nivele>.from(json["niveles"].map((x) => Nivele.fromJson(x)))
            : [],
        status: json["status"],
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "niveles": List<dynamic>.from(niveles.map((x) => x.toJson())),
        "status": status,
        "message": message,
        "code": code,
      };
}

class Nivele {
  Nivele({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory Nivele.fromJson(Map<String, dynamic> json) => Nivele(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
