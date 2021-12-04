import 'package:get/get.dart';

import 'studs_proxies_edit_logic.dart';

class StudsProxiesEditBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => StudsProxiesEditLogic(Get.parameters['idNivel'] ?? '',
        Get.parameters['idGrade'] ?? ''));
  }
}
