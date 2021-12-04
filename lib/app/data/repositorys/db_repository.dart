import 'package:get/get.dart';
import 'package:notificaciones_unifront/app/data/models/apoderado_model.dart';
import 'package:notificaciones_unifront/app/data/models/estudiante_model.dart';
import 'package:notificaciones_unifront/app/data/models/nivel_model.dart';
import 'package:notificaciones_unifront/app/data/models/sub_nivel_model.dart';
import 'package:notificaciones_unifront/app/data/models/token_model.dart';
import 'package:notificaciones_unifront/app/data/provider/db_provider.dart';

class DbRepository {
  final _dbProvider = Get.find<DbProvider>();

  Future<TokenModel?> login(
          {required String correo, required String password}) =>
      _dbProvider.login(correo: correo, password: password);

  Future<NivelModel?> getNiveles({required String token}) =>
      _dbProvider.getNiveles(token: token);

  Future<SubNivelModel?> getSubNiveles(
          {required String token, required String idNivel}) =>
      _dbProvider.getSubNiveles(token: token, idNivel: idNivel);

  Future<TokenModel?> refresh({required String token}) =>
      _dbProvider.refresh(token: token);

  Future<SubNivele?> getSubNivel(
          {required String token, required String idSubNivel}) =>
      _dbProvider.getSubNivel(token: token, idSubNivel: idSubNivel);

  Future<Nivele?> getNivel({required String token, required String idNivel}) =>
      _dbProvider.getNivel(token: token, idNivel: idNivel);

  Future<EstudianteModel?> getEstudiantesNoApoderado(
          {required String token, required String idSubNivel}) =>
      _dbProvider.getEstudiantesNoApoderado(
          token: token, idSubNivel: idSubNivel);

  Future<EstudianteModel?> getEstudiantesApoderado(
          {required String token, required String idSubNivel}) =>
      _dbProvider.getEstudiantesApoderado(token: token, idSubNivel: idSubNivel);

  Future<bool> updateEstudiante(
          {required String token,
          required int idapoderado,
          required int id,
          required String name,
          required String lastname,
          required String correo,
          required int idSubNivel}) =>
      _dbProvider.updateEstudiante(
          token: token,
          idapoderado: idapoderado,
          id: id,
          name: name,
          lastname: lastname,
          correo: correo,
          idSubNivel: idSubNivel);

  Future<Apoderado?> createApoderado(
          {required String token,
          required String name,
          required String lastname,
          required String correo}) =>
      _dbProvider.createApoderado(
          token: token, name: name, lastname: lastname, correo: correo);

  Future<bool> updateApoderado(
          {required String token,
          required int id,
          required String name,
          required String lastname,
          required String correo}) =>
      _dbProvider.updateApoderado(
          token: token, id: id, name: name, lastname: lastname, correo: correo);

  Future<ApoderadoModel?> getApoderadoLastName(
          {required String token, required String lastName}) =>
      _dbProvider.getApoderadoLastName(token: token, lastName: lastName);

  Future<ApoderadoModel?> getApoderados({required String token}) =>
      _dbProvider.getApoderados(token: token);

  Future<Apoderado?> getApoderado(
          {required String token, required String idApoderado}) =>
      _dbProvider.getApoderado(token: token, idApoderado: idApoderado);

  Future<Apoderado?> deleteApoderado(
          {required String token, required int id}) =>
      _dbProvider.deleteApoderado(token: token, id: id);

  Future<bool> sendNotifAll(
          {required String token,
          required String title,
          required String message,
          required DateTime dateTime}) =>
      _dbProvider.sendNotifAll(
          token: token, title: title, message: message, dateTime: dateTime);

  Future<bool> sendNotifGra(
          {required String token,
          required String idSubNivel,
          required String title,
          required String message,
          required DateTime dateTime}) =>
      _dbProvider.sendNotifGra(
          token: token,
          idSubNivel: idSubNivel,
          title: title,
          message: message,
          dateTime: dateTime);

  Future<bool> logOut({required String token}) =>
      _dbProvider.logOut(token: token);
}
