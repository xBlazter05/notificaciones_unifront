import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificaciones_unifront/app/data/models/apoderado_model.dart';
import 'package:notificaciones_unifront/app/data/models/estudiante_model.dart';
import 'package:notificaciones_unifront/app/data/models/nivel_model.dart';
import 'package:notificaciones_unifront/app/data/models/sub_nivel_model.dart';
import 'package:notificaciones_unifront/app/data/repositorys/db_repository.dart';
import 'package:notificaciones_unifront/app/data/services/auth_service.dart';
import 'package:notificaciones_unifront/app/data/services/dialog_service.dart';
import 'package:notificaciones_unifront/app/routes/app_pages.dart';

class StudsProxiesAddLogic extends GetxController {
  String idNivel;
  String idGrade;

  StudsProxiesAddLogic(this.idNivel, this.idGrade);

  final _formKey = GlobalKey<FormState>();
  final _dbRepository = Get.find<DbRepository>();
  final TextEditingController _lastNameCtrl = TextEditingController();

  EstudianteModel? _estudianteModel;
  Nivele? _nivele;
  SubNivele? _subNivele;
  ApoderadoModel? _apoderadoModel;
  Apoderado? _apoderado;

  EstudianteModel? get estudianteModel => _estudianteModel;

  Nivele? get nivele => _nivele;

  SubNivele? get subNivele => _subNivele;

  ApoderadoModel? get apoderadoModel => _apoderadoModel;

  Apoderado? get apoderado => _apoderado;

  @override
  void onReady() {
    _getSubNivel();
    _getEstudiantes();
    super.onReady();
  }

  String? _isNotEmpty(String? value, String label) {
    if (value != null) if (value.isNotEmpty) return null;
    return 'Ingrese $label';
  }

  void _getSubNivel() async {
    final token = await AuthService.to.getToken();
    if (token != null) {
      _nivele = await _dbRepository.getNivel(token: token, idNivel: idNivel);
      _subNivele =
          await _dbRepository.getSubNivel(token: token, idSubNivel: idGrade);
    } else {
      Get.rootDelegate.toNamed(Routes.login);
    }
    update(['title']);
  }

  void _getEstudiantes() async {
    final token = await AuthService.to.getToken();
    if (token != null) {
      _estudianteModel = await _dbRepository.getEstudiantesNoApoderado(
          token: token, idSubNivel: idGrade);
    } else {
      Get.rootDelegate.toNamed(Routes.login);
    }
    update(['students']);
  }

  void _getApoderados() async {
    final token = await AuthService.to.getToken();
    if (token != null) {
      _apoderadoModel = await _dbRepository.getApoderadoLastName(
          token: token, lastName: _lastNameCtrl.text.trim());
    } else {
      Get.rootDelegate.toNamed(Routes.login);
    }
    update(['apoderados']);
  }

  void addProxie(Size size, Estudiante e) {
    Get.dialog(Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 749,
          height: size.height - 40,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Agregar apoderado',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                      icon: const Icon(Icons.close), onPressed: _closeDialog)
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'En la siguiente tabla, seleccione un nuevo apoderado para el estudiante.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 30),
              Container(
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _lastNameCtrl,
                    validator: (value) => _isNotEmpty(value, 'apellidos'),
                    onFieldSubmitted: (value) {
                      if (_formKey.currentState!.validate()) {
                        _getApoderados();
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _getApoderados();
                          }
                        },
                        icon: const ImageIcon(
                          AssetImage('assets/icons/search.png'),
                          color: Colors.black,
                          size: 15,
                        ),
                      ),
                      hintText: 'Buscar apoderado por apellidos',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                  child: GetBuilder<StudsProxiesAddLogic>(
                      id: 'apoderados',
                      builder: (_) {
                        final apoderadoModel = _.apoderadoModel;
                        return apoderadoModel != null
                            ? apoderadoModel.apoderados.isNotEmpty
                                ? SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: DataTable(
                                        columns: const [
                                          DataColumn(label: Text('#')),
                                          DataColumn(label: Text('Apellidos')),
                                          DataColumn(label: Text('Nombre(s)')),
                                          DataColumn(
                                              label:
                                                  Text('CORREO ELECTRONICO')),
                                          DataColumn(label: Text('Accion')),
                                        ],
                                        rows:
                                            apoderadoModel.apoderados.map((e) {
                                          int index = apoderadoModel.apoderados
                                                  .indexOf(e) +
                                              1;
                                          return DataRow(cells: [
                                            DataCell(Text(index.toString())),
                                            DataCell(Text(e.lastname)),
                                            DataCell(Text(e.name)),
                                            DataCell(Text(e.correo)),
                                            DataCell(Checkbox(
                                                value: apoderado != null
                                                    ? apoderado == e
                                                        ? true
                                                        : false
                                                    : false,
                                                onChanged: (value) =>
                                                    onSelectApod(e))),
                                          ]);
                                        }).toList()),
                                  )
                                : const Center(
                                    child: Text('No hay datos'),
                                  )
                            : const Center(
                                child: CircularProgressIndicator(),
                              );
                      })),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 125,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.white),
                        onPressed: _closeDialog,
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                              color: Color(0xff2E65F3),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 125,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff2E65F3)),
                        onPressed: () async {
                          if (apoderado != null) {
                            final token = await AuthService.to.getToken();
                            if (token != null) {
                              DialogService.to.openDialog();
                              final estudianteUpd =
                                  await _dbRepository.updateEstudiante(
                                      token: token,
                                      idapoderado: apoderado!.id,
                                      id: e.id,
                                      name: e.name,
                                      lastname: e.lastname,
                                      correo: e.correo,
                                      idSubNivel: e.idSubNivel);
                              DialogService.to.closeDialog();
                              if (estudianteUpd) {
                                _estudianteModel!.estudiantes.removeWhere(
                                    (element) => element.id == e.id);
                                _apoderadoModel = null;
                                update(['students', 'apoderados']);
                                _lastNameCtrl.clear();
                                _closeDialog();
                              } else {
                                DialogService.to.snackBar(Colors.red, 'ERROR',
                                    'No pudimos actualizar el apoderado');
                              }
                            } else {
                              Get.rootDelegate.toNamed(Routes.login);
                            }
                          } else {
                            DialogService.to.snackBar(
                                Colors.red, 'ERROR', 'Seleccione un apoderado');
                          }
                        },
                        child: const Text(
                          'Agregar',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  void _closeDialog() {
    Get.back();
  }

  void onSelectApod(Apoderado e) {
    _apoderado = e;
    update(['apoderados']);
  }
}
