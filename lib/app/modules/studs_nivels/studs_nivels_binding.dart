import 'package:get/get.dart';

import 'studs_nivels_logic.dart';

class StudsNivelsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudsNivelsLogic());
  }
}
