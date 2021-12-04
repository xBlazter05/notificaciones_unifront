import 'package:get/get.dart';

import 'notif_send_logic.dart';

class NotifSendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotifSendLogic(Get.parameters['idNivel']??'',Get.parameters['idGrade']??''));
  }
}
