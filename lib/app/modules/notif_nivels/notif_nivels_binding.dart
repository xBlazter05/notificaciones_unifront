import 'package:get/get.dart';

import 'notif_nivels_logic.dart';

class NotifNivelsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotifNivelsLogic());
  }
}
