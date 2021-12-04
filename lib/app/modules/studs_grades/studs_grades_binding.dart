import 'package:get/get.dart';

import 'studs_grades_logic.dart';

class StudsGradesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudsGradesLogic(Get.parameters['idNivel'] ?? ''));
  }
}
