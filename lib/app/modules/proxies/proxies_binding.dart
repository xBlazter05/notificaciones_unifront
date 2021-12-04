import 'package:get/get.dart';

import 'proxies_logic.dart';

class ProxiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProxiesLogic());
  }
}
