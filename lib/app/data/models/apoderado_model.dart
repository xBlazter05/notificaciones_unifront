// To parse this JSON data, do
//
//     final apoderadoModel = apoderadoModelFromJson(jsonString);

import 'dart:convert';

ApoderadoModel apoderadoModelFromJson(String str) => ApoderadoModel.fromJson(json.decode(str));

String apoderadoModelToJson(ApoderadoModel data) => json.encode(data.toJson());

class ApoderadoModel {
  ApoderadoModel({
    required this.apoderados,
    required this.status,
    required this.message,
    required this.code,
  });

  List<Apoderado> apoderados;
  String status;
  String message;
  int code;

  factory ApoderadoModel.fromJson(Map<String, dynamic> json) => ApoderadoModel(
    apoderados: List<Apoderado>.from(json["apoderados"].map((x) => Apoderado.fromJson(x))),
    status: json["status"],
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "apoderados": List<dynamic>.from(apoderados.map((x) => x.toJson())),
    "status": status,
    "message": message,
    "code": code,
  };
}

class Apoderado {
  Apoderado({
    required this.id,
    required this.name,
    required this.lastname,
    required this.correo,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String lastname;
  String correo;
  DateTime createdAt;
  DateTime updatedAt;

  factory Apoderado.fromJson(Map<String, dynamic> json) => Apoderado(
    id: json["id"],
    name: json["name"],
    lastname: json["lastname"],
    correo: json["correo"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "lastname": lastname,
    "correo": correo,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
