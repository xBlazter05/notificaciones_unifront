import 'package:get/get.dart';

import 'studs_proxies_add_logic.dart';

class StudsProxiesAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudsProxiesAddLogic(Get.parameters['idNivel'] ?? '',
        Get.parameters['idGrade'] ?? ''));
  }
}
