import 'package:get/get.dart';
import 'package:notificaciones_unifront/app/routes/app_pages.dart';

class InicioLogic extends GetxController {

  void toNotifys() {
    Get.rootDelegate.toNamed(Routes.notifNivels);
  }

  void students() {
    Get.rootDelegate.toNamed(Routes.studsNivels);
  }

  void toProxies() {
    Get.rootDelegate.toNamed(Routes.proxies);
  }
}
