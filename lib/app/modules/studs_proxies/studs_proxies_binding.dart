import 'package:get/get.dart';

import 'studs_proxies_logic.dart';

class StudsProxiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudsProxiesLogic(
        Get.parameters['idNivel'] ?? '', Get.parameters['idGrade'] ?? ''));
  }
}
