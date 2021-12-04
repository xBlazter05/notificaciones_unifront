import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificaciones_unifront/app/data/models/apoderado_model.dart';
import 'package:notificaciones_unifront/app/data/repositorys/db_repository.dart';
import 'package:notificaciones_unifront/app/data/services/auth_service.dart';
import 'package:notificaciones_unifront/app/data/services/dialog_service.dart';
import 'package:notificaciones_unifront/app/routes/app_pages.dart';

class ProxiesLogic extends GetxController {
  final _dbRepository = Get.find<DbRepository>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();

  ApoderadoModel? _apoderadoModel;

  ApoderadoModel? get apoderadoModel => _apoderadoModel;

  @override
  void onReady() {
    _getProxies();
    super.onReady();
  }

  @override
  void onClose() {
    _nameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    super.onClose();
  }

  void _getProxies() async {
    final token = await AuthService.to.getToken();
    if (token != null) {
      _apoderadoModel = await _dbRepository.getApoderados(token: token);
    } else {
      Get.rootDelegate.toNamed(Routes.login);
    }
    update(['apoderados']);
  }

  String? _isNotEmpty(String? value, String label) {
    if (value != null) if (value.isNotEmpty) return null;
    return 'Ingrese $label';
  }

  String? _validateEmail(String? value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    return (!regex.hasMatch(value ?? '')) ? 'Ingrese su correo' : null;
  }

  void editProxie(Apoderado apoderado) {
    _nameCtrl.text = apoderado.name;
    _lastNameCtrl.text = apoderado.lastname;
    _emailCtrl.text = apoderado.correo;
    Get.dialog(Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 725,
          height: 444,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Editar apoderado',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _nameCtrl.clear();
                      _lastNameCtrl.clear();
                      _emailCtrl.clear();
                      _closeDialog();
                    },
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Edite la información del apoderado en este formulario.',
                style: TextStyle(fontSize: 14),
              ),
              Expanded(
                  child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 306,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Apellido(s)',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                color: Colors.white,
                                child: TextFormField(
                                  controller: _lastNameCtrl,
                                  validator: (value) =>
                                      _isNotEmpty(value, 'apellidos'),
                                  decoration: InputDecoration(
                                    hintText: 'Sanchez Vazquez',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 306,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Nombre(s)',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                color: Colors.white,
                                child: TextFormField(
                                  controller: _nameCtrl,
                                  validator: (value) =>
                                      _isNotEmpty(value, 'nombres'),
                                  decoration: InputDecoration(
                                    hintText: 'Ixchel Alejandra',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Correo electrónico',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          color: Colors.white,
                          child: TextFormField(
                            controller: _emailCtrl,
                            validator: _validateEmail,
                            decoration: InputDecoration(
                              hintText: 'ixchel.sanchez@uabc.edu.mx',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
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
                        onPressed: () {
                          _nameCtrl.clear();
                          _lastNameCtrl.clear();
                          _emailCtrl.clear();
                          _closeDialog();
                        },
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
                          final token = await AuthService.to.getToken();
                          if (token != null) {
                            if (_formKey.currentState!.validate()) {
                              DialogService.to.openDialog();
                              final apoderadoUpd =
                                  await _dbRepository.updateApoderado(
                                      token: token,
                                      id: apoderado.id,
                                      name: _nameCtrl.text.trim(),
                                      lastname: _lastNameCtrl.text.trim(),
                                      correo: _emailCtrl.text.trim());
                              DialogService.to.closeDialog();
                              if (apoderadoUpd) {
                                final indexApod = apoderadoModel?.apoderados
                                    .indexOf(apoderado);
                                if (indexApod != null) {
                                  _apoderadoModel?.apoderados[indexApod].name =
                                      _nameCtrl.text.trim();
                                  _apoderadoModel?.apoderados[indexApod]
                                      .lastname = _lastNameCtrl.text.trim();
                                  _apoderadoModel?.apoderados[indexApod]
                                      .correo = _emailCtrl.text.trim();
                                  update(['apoderados']);
                                  _nameCtrl.clear();
                                  _lastNameCtrl.clear();
                                  _emailCtrl.clear();
                                }
                                _closeDialog();
                              } else {
                                DialogService.to.snackBar(Colors.red, 'ERROR',
                                    'No pudimos actualizar el apoderado');
                              }
                            }
                          } else {
                            Get.rootDelegate.toNamed(Routes.login);
                          }
                        },
                        child: const Text(
                          'Editar',
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

  void deleteProxie(int idProxie) {
    Get.dialog(Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 520,
          height: 256,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          shape: BoxShape.circle),
                      padding: const EdgeInsets.all(10),
                      child: const ImageIcon(
                        AssetImage('assets/icons/trash.png'),
                        color: Colors.red,
                      )),
                  const SizedBox(width: 10),
                  const Text(
                    'Eliminar apoderado',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: _closeDialog,
                  )
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '¿Está seguro de que desea continuar?',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Esta acción eliminará el apoderado definitivamente',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              )),
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
                          'No. Cancelar',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 125,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () async {
                          final token = await AuthService.to.getToken();
                          if (token != null) {
                            DialogService.to.openDialog();
                            final apoderadoDel = await _dbRepository
                                .deleteApoderado(token: token, id: idProxie);
                            DialogService.to.closeDialog();
                            if (apoderadoDel != null) {
                              _apoderadoModel?.apoderados.removeWhere((item)=> item.id==idProxie);
                              update(['apoderados']);
                              _closeDialog();
                            } else {
                              DialogService.to.snackBar(Colors.red, 'ERROR',
                                  'No pudimos crear el apoderado');
                            }
                          } else {
                            Get.rootDelegate.toNamed(Routes.login);
                          }
                        },
                        child: const Text(
                          'Si. Continuar',
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

  void addProxie() {
    Get.dialog(Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 725,
          height: 444,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Crear apoderado',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Agregue un nuevo apoderado en el siguiente formulario',
                style: TextStyle(fontSize: 14),
              ),
              Expanded(
                  child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Nombre(s)',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          color: Colors.white,
                          child: TextFormField(
                            controller: _nameCtrl,
                            validator: (value) => _isNotEmpty(value, 'nombres'),
                            decoration: InputDecoration(
                              hintText: 'Ingrese el nombre del apoderado',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Apellido(s) ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          color: Colors.white,
                          child: TextFormField(
                            controller: _lastNameCtrl,
                            validator: (value) =>
                                _isNotEmpty(value, 'apellidos'),
                            decoration: InputDecoration(
                              hintText: 'Ingrese el apellido del apoderado',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Correo electrónico',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          color: Colors.white,
                          child: TextFormField(
                            controller: _emailCtrl,
                            validator: _validateEmail,
                            decoration: InputDecoration(
                              hintText:
                                  'Ingrese el correo electrónico del apoderado',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
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
                        onPressed: _cancel,
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _add();
                          }
                        },
                        child: const Text(
                          'Crear',
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

  void _cancel() {
    Get.dialog(Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 520,
          height: 256,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          shape: BoxShape.circle),
                      padding: const EdgeInsets.all(10),
                      child: const ImageIcon(
                        AssetImage('assets/icons/trash.png'),
                        color: Colors.red,
                      )),
                  const SizedBox(width: 10),
                  const Text(
                    'Eliminar progreso',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: _closeDialog,
                  )
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '¿Está seguro de que desea continuar?',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Esta acción eliminará su progreso',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              )),
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
                          'No. Cancelar',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 125,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () {
                          _closeDialog();
                          _closeDialog();
                        },
                        child: const Text(
                          'Si. Continuar',
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

  void _add() {
    Get.dialog(Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 520,
          height: 256,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Crear apoderado',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                      icon: const Icon(Icons.close), onPressed: _closeDialog)
                ],
              ),
              const SizedBox(height: 30),
              const Expanded(
                child: Text(
                  '¿Está seguro de que desea crear el apoderado?',
                  style: TextStyle(fontSize: 16),
                ),
              ),
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
                          'No. Regresar',
                          style: TextStyle(
                              color: Color(0xff2E65F3),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 179,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff2E65F3)),
                        onPressed: () async {
                          final token = await AuthService.to.getToken();
                          if (token != null) {
                            if (_formKey.currentState!.validate()) {
                              DialogService.to.openDialog();
                              final apoderadoNew =
                                  await _dbRepository.createApoderado(
                                      token: token,
                                      name: _nameCtrl.text.trim(),
                                      lastname: _lastNameCtrl.text.trim(),
                                      correo: _emailCtrl.text.trim());
                              DialogService.to.closeDialog();
                              if (apoderadoNew != null) {
                                _apoderadoModel?.apoderados.add(apoderadoNew);
                                update(['apoderados']);
                                _nameCtrl.clear();
                                _lastNameCtrl.clear();
                                _emailCtrl.clear();
                                _success();
                              } else {
                                DialogService.to.snackBar(Colors.red, 'ERROR',
                                    'No pudimos crear el apoderado');
                              }
                            }
                          } else {
                            Get.rootDelegate.toNamed(Routes.login);
                          }
                        },
                        child: const Text(
                          'Si. Crear apoderado',
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

  void _success() {
    Get.dialog(Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 480,
          height: 215,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.green, shape: BoxShape.circle),
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.check, color: Colors.white),
              ),
              const SizedBox(height: 30),
              const Text(
                '¡Creación de apoderado exitoso!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const Expanded(
                child: Text(
                  'Se ha creado exitosamente el nuevo apoderado',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xff2E65F3)),
                  onPressed: () {
                    _closeDialog();
                    _closeDialog();
                    _closeDialog();
                  },
                  child: const Text(
                    'Aceptar',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
