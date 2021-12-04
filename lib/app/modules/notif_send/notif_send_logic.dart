import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notificaciones_unifront/app/data/models/nivel_model.dart';
import 'package:notificaciones_unifront/app/data/models/sub_nivel_model.dart';
import 'package:notificaciones_unifront/app/data/repositorys/db_repository.dart';
import 'package:notificaciones_unifront/app/data/services/auth_service.dart';
import 'package:notificaciones_unifront/app/data/services/dialog_service.dart';
import 'package:notificaciones_unifront/app/routes/app_pages.dart';

class NotifSendLogic extends GetxController {
  String idNivel;
  String idGrade;

  NotifSendLogic(this.idNivel, this.idGrade);

  final formKey = GlobalKey<FormState>();
  final _dbRepository = Get.find<DbRepository>();
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController messageCtrl = TextEditingController();
  final TextEditingController dateCtrl = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Nivele? _nivele;
  SubNivele? _subNivele;

  Nivele? get nivele => _nivele;

  SubNivele? get subNivele => _subNivele;

  @override
  void onReady() {
    _getSubNivel();
    super.onReady();
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

  void onSelectDate() async {
    final picked = await showDatePicker(
        locale: const Locale('es', 'es_ES'),
        context: Get.context!,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(_selectedDate.year + 1));
    if (picked != null) {
      _selectedDate = picked;
      final dayWeek = DateFormat('EEEE', 'es_ES').format(_selectedDate);
      final day = DateFormat('d', 'es_ES').format(_selectedDate);
      final month = DateFormat('MMMM', 'es_ES').format(_selectedDate);
      final year = DateFormat('y', 'es_ES').format(_selectedDate);
      dateCtrl.text = '$dayWeek $day de $month del $year';
    }
  }

  void cancel() {
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
                  const Icon(Icons.close)
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
                          titleCtrl.clear();
                          messageCtrl.clear();
                          dateCtrl.clear();
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

  void send() {
    Get.dialog(Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 520,
          height: 212,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Enviar notificación',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                      icon: const Icon(Icons.close), onPressed: _closeDialog)
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '¿Está seguro de que desea enviar la notificación?',
                    style: TextStyle(fontSize: 16),
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
                          'No. Regresar',
                          style: TextStyle(
                              color: Color(0xff2E65F3),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 193,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff2E65F3)),
                        onPressed: () async {
                          final token = await AuthService.to.getToken();
                          if (token != null) {
                            if (idGrade == '0') {
                              DialogService.to.openDialog();
                              final send = await _dbRepository.sendNotifAll(
                                  token: token,
                                  title: titleCtrl.text.trim(),
                                  message: messageCtrl.text.trim(),
                                  dateTime: _selectedDate);
                              DialogService.to.closeDialog();
                              if (send) {
                                _success();
                              } else {
                                DialogService.to.snackBar(Colors.red, 'ERROR',
                                    'No pudimos enviar la notiricación');
                              }
                            } else {
                              DialogService.to.openDialog();
                              final send = await _dbRepository.sendNotifGra(
                                  token: token,
                                  idSubNivel: idGrade,
                                  title: titleCtrl.text.trim(),
                                  message: messageCtrl.text.trim(),
                                  dateTime: _selectedDate);
                              DialogService.to.closeDialog();
                              if (send) {
                                _success();
                              } else {
                                DialogService.to.snackBar(Colors.red, 'ERROR',
                                    'No pudimos enviar la notiricación');
                              }
                            }
                          } else {
                            Get.rootDelegate.toNamed(Routes.login);
                          }
                        },
                        child: const Text(
                          'Si. Enviar notificación',
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
                '¡Envío exitoso!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const Expanded(
                child: Text(
                  'Se ha enviado exitosamente su notificación',
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
                    dateCtrl.clear();
                    titleCtrl.clear();
                    messageCtrl.clear();
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

  String? isNotEmpty(String? value, String label) {
    if (value != null) if (value.isNotEmpty) return null;
    return 'Ingrese $label';
  }

  void _closeDialog() {
    Get.back();
  }
}
