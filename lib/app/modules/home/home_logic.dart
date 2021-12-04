import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificaciones_unifront/app/data/services/auth_service.dart';
import 'package:notificaciones_unifront/app/data/services/dialog_service.dart';
import 'package:notificaciones_unifront/app/routes/app_pages.dart';

class HomeLogic extends GetxController {
  String _selectDrawer = 'Inicio';

  String get selectDrawer => _selectDrawer;

  void onSelectDrawer(String select, bool nav) {
    _selectDrawer = select;
    update(['drawer']);
    if (nav) {
      switch (select) {
        case 'Inicio':
          Get.rootDelegate.toNamed(Routes.inicio);
          break;
        case 'Notificaciones':
          Get.rootDelegate.toNamed(Routes.notifNivels);
          break;
        case 'Estudiantes':
          Get.rootDelegate.toNamed(Routes.studsNivels);
          break;
        case 'Apoderados':
          Get.rootDelegate.toNamed(Routes.proxies);
          break;
      }
    }
  }

  void logOut() async {
    final logOut = await AuthService.to.eraseSession();
    if (logOut) {
      Get.rootDelegate.toNamed(Routes.login);
    }else{
      DialogService.to.snackBar(
          Colors.red, 'ERROR', 'No se pudo cerrar sesión, intentelo mas tarde');
    }
  }
}
