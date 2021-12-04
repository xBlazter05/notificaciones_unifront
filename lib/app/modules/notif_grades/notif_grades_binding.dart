import 'package:get/get.dart';

import 'notif_grades_logic.dart';

class NotifGradesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotifGradesLogic(Get.parameters['idNivel']??''));
  }
}
