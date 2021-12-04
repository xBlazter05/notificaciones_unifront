// To parse this JSON data, do
//
//     final subNivelModel = subNivelModelFromJson(jsonString);

import 'dart:convert';

SubNivelModel subNivelModelFromJson(String str) =>
    SubNivelModel.fromJson(json.decode(str));

String subNivelModelToJson(SubNivelModel data) => json.encode(data.toJson());

class SubNivelModel {
  SubNivelModel({
    required this.subNiveles,
    required this.status,
    required this.message,
    required this.code,
  });

  List<SubNivele> subNiveles;
  String status;
  String message;
  int code;

  factory SubNivelModel.fromJson(Map<String, dynamic> json) => SubNivelModel(
        subNiveles: json["sub_niveles"] != null
            ? List<SubNivele>.from(
                json["sub_niveles"].map((x) => SubNivele.fromJson(x)))
            : [],
        status: json["status"],
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "sub_niveles": List<dynamic>.from(subNiveles.map((x) => x.toJson())),
        "status": status,
        "message": message,
        "code": code,
      };
}

class SubNivele {
  SubNivele({
    required this.id,
    required this.idNivel,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int idNivel;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory SubNivele.fromJson(Map<String, dynamic> json) => SubNivele(
        id: json["id"],
        idNivel: json["idNivel"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idNivel": idNivel,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
