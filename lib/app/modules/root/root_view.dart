import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificaciones_unifront/app/routes/app_pages.dart';

import 'root_logic.dart';

class RootPage extends StatelessWidget {
  final logic = Get.find<RootLogic>();

  RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(builder: (context, delegate, current) {
      debugPrint('title ${current?.location}');
      return Scaffold(
        body: GetRouterOutlet(initialRoute: Routes.login),
      );
    });
  }
}
