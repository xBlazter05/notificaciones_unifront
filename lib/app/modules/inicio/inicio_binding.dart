import 'package:get/get.dart';

import 'inicio_logic.dart';

class InicioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InicioLogic());
  }
}
