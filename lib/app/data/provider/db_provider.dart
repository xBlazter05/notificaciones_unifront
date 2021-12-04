import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notificaciones_unifront/app/core/utils/helpers/http/http.dart';
import 'package:notificaciones_unifront/app/data/models/apoderado_model.dart';
import 'package:notificaciones_unifront/app/data/models/estudiante_model.dart';
import 'package:notificaciones_unifront/app/data/models/nivel_model.dart';
import 'package:notificaciones_unifront/app/data/models/sub_nivel_model.dart';
import 'package:notificaciones_unifront/app/data/models/token_model.dart';

class DbProvider {
  final Http _http;

  DbProvider(this._http);

  Future<TokenModel?> login(
      {required String correo, required String password}) async {
    try {
      final json = {'correo': correo, 'password': password};
      final result = await _http.request('loginAdmin',
          method: HttpMethod.post, body: {'json': jsonEncode(json)});
      return TokenModel.fromJson(result.data);
    } catch (_) {
      return null;
    }
  }

  Future<TokenModel?> refresh({required String token}) async {
    try {
      final result = await _http.request('refresh',
          method: HttpMethod.post, headers: {'Authorization': token});
      return TokenModel.fromJson(result.data);
    } catch (_) {
      return null;
    }
  }

  Future<NivelModel?> getNiveles({required String token}) async {
    try {
      final result = await _http.request('niveles',
          method: HttpMethod.get, headers: {'Authorization': token});
      return NivelModel.fromJson(result.data);
    } catch (_) {
      return null;
    }
  }

  Future<Nivele?> getNivel(
      {required String token, required String idNivel}) async {
    try {
      final result = await _http.request('nivel',
          method: HttpMethod.get,
          headers: {'Authorization': token},
          queryParameters: {'idNivel': idNivel});
      final data = result.data as Map<String, dynamic>;
      return Nivele.fromJson(data['nivel']);
    } catch (_) {
      return null;
    }
  }

  Future<SubNivelModel?> getSubNiveles(
      {required String token, required String idNivel}) async {
    try {
      final result = await _http.request('subniveles',
          method: HttpMethod.get,
          headers: {'Authorization': token},
          queryParameters: {'idNivel': idNivel});
      return SubNivelModel.fromJson(result.data);
    } catch (_) {
      return null;
    }
  }

  Future<SubNivele?> getSubNivel(
      {required String token, required String idSubNivel}) async {
    try {
      final result = await _http.request('subnivel',
          method: HttpMethod.get,
          headers: {'Authorization': token},
          queryParameters: {'idSubNivel': idSubNivel});
      final data = result.data as Map<String, dynamic>;
      return SubNivele.fromJson(data['sub_nivel']);
    } catch (_) {
      return null;
    }
  }

  Future<EstudianteModel?> getEstudiantesNoApoderado(
      {required String token, required String idSubNivel}) async {
    try {
      final result = await _http.request('estudiantesNoApoderado',
          method: HttpMethod.get,
          headers: {'Authorization': token},
          queryParameters: {'idSubNivel': idSubNivel});
      return EstudianteModel.fromJson(result.data);
    } catch (_) {
      return null;
    }
  }

  Future<EstudianteModel?> getEstudiantesApoderado(
      {required String token, required String idSubNivel}) async {
    try {
      final result = await _http.request('estudiantesApoderado',
          method: HttpMethod.get,
          headers: {'Authorization': token},
          queryParameters: {'idSubNivel': idSubNivel});
      return EstudianteModel.fromJson(result.data);
    } catch (_) {
      return null;
    }
  }

  Future<bool> updateEstudiante(
      {required String token,
      required int idapoderado,
      required int id,
      required String name,
      required String lastname,
      required String correo,
      required int idSubNivel}) async {
    final password = name.toLowerCase().replaceAll(' ', '');
    try {
      final json = {
        'idapoderado': idapoderado,
        'name': name,
        'lastname': lastname,
        'correo': correo,
        'password': password,
        'idSubNivel': idSubNivel
      };
      final result = await _http.request('estudiante/$id',
          method: HttpMethod.put,
          headers: {'Authorization': token},
          body: {'json': jsonEncode(json)});
      debugPrint('result ${result.data}');
      final data = result.data as Map<String, dynamic>;
      if (data['status'] == 'success') {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  Future<Apoderado?> createApoderado(
      {required String token,
      required String name,
      required String lastname,
      required String correo}) async {
    final password = name.replaceAll(' ', '');
    try {
      final json = {
        'name': name,
        'lastname': lastname,
        'correo': correo,
        'password': password
      };
      final result = await _http.request('apoderado',
          method: HttpMethod.post,
          headers: {'Authorization': token},
          body: {'json': jsonEncode(json)});
      final data = result.data as Map<String, dynamic>;
      return Apoderado.fromJson(data['apoderado']);
    } catch (_) {
      return null;
    }
  }

  Future<bool> updateApoderado(
      {required String token,
      required int id,
      required String name,
      required String lastname,
      required String correo}) async {
    final password = name.toLowerCase().replaceAll(' ', '');
    try {
      final json = {
        'name': name,
        'lastname': lastname,
        'correo': correo,
        'password': password
      };
      final result = await _http.request('apoderado/$id',
          method: HttpMethod.put,
          headers: {'Authorization': token},
          body: {'json': jsonEncode(json)});
      debugPrint('result ${result.data}');
      final data = result.data as Map<String, dynamic>;
      if (data['status'] == 'success') {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  Future<Apoderado?> deleteApoderado(
      {required String token, required int id}) async {
    try {
      final json = {'role': 'proxie'};
      final result = await _http.request('apoderado/$id',
          method: HttpMethod.delete,
          headers: {'Authorization': token},
          body: {'json': jsonEncode(json)});
      debugPrint('result ${result.data}');
      final data = result.data as Map<String, dynamic>;
      return Apoderado.fromJson(data['apoderado']);
    } catch (_) {
      return null;
    }
  }

  Future<ApoderadoModel?> getApoderadoLastName(
      {required String token, required String lastName}) async {
    try {
      final result = await _http.request('apoderadosName',
          method: HttpMethod.get,
          headers: {'Authorization': token},
          queryParameters: {'lastName': lastName});
      return ApoderadoModel.fromJson(result.data);
    } catch (_) {
      return null;
    }
  }

  Future<ApoderadoModel?> getApoderados({required String token}) async {
    try {
      final result = await _http.request('apoderados',
          method: HttpMethod.get, headers: {'Authorization': token});
      return ApoderadoModel.fromJson(result.data);
    } catch (_) {
      return null;
    }
  }

  Future<Apoderado?> getApoderado(
      {required String token, required String idApoderado}) async {
    try {
      final result = await _http.request('apoderado',
          method: HttpMethod.get,
          headers: {'Authorization': token},
          queryParameters: {'idApoderado': idApoderado});
      final data = result.data as Map<String, dynamic>;
      return Apoderado.fromJson(data['apoderado']);
    } catch (_) {
      return null;
    }
  }

  Future<bool> sendNotifAll(
      {required String token,
      required String title,
      required String message,
      required DateTime dateTime}) async {
    try {
      final json = {
        'titulo': title,
        'mensaje': message,
        'date_limit': dateTime.toString()
      };
      final result = await _http.request('notificacionesAll',
          method: HttpMethod.post,
          headers: {'Authorization': token},
          body: {'json': jsonEncode(json)});
      final data = result.data as Map<String, dynamic>;
      if (data['status'] == 'success') {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  Future<bool> sendNotifGra(
      {required String token,
      required String idSubNivel,
      required String title,
      required String message,
      required DateTime dateTime}) async {
    try {
      final json = {
        'titulo': title,
        'mensaje': message,
        'date_limit': dateTime.toString()
      };
      final result = await _http.request('notificacionesGrade/$idSubNivel',
          method: HttpMethod.post,
          headers: {'Authorization': token},
          body: {'json': jsonEncode(json)});
      final data = result.data as Map<String, dynamic>;
      if (data['status'] == 'success') {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  Future<bool> logOut({required String token}) async {
    try {
      final result = await _http.request('logOut',
          method: HttpMethod.post, headers: {'Authorization': token});
      final data = result.data as Map<String, dynamic>;
      if (data['status'] == 'success') {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }
}
