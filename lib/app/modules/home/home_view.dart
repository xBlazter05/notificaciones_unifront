import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificaciones_unifront/app/routes/app_pages.dart';

import 'home_logic.dart';

class HomePage extends StatelessWidget {
  final logic = Get.find<HomeLogic>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(builder: (context, delegate, current) {
      final title = current?.location;
      if (title != null) {
        logic.onSelectDrawer(title.contains('proxies')
            ? 'Apoderados'
            : title.contains('notif')
                ? 'Notificaciones'
                : title.contains('studs')
                    ? 'Estudiantes'
                    : 'Inicio',false);
      }
      return Scaffold(
        body: Row(
          children: [
            GetBuilder<HomeLogic>(
                id: 'drawer',
                builder: (_) {
                  final selectDrawer = _.selectDrawer;
                  return Drawer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DrawerHeader(
                            child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Image.asset('assets/images/logo1.png'),
                        )),
                        Expanded(
                          child: Column(
                            children: [
                              ListTile(
                                leading: ImageIcon(
                                  const AssetImage('assets/icons/home.png'),
                                  color: selectDrawer == 'Inicio'
                                      ? const Color(0xffE7B400)
                                      : const Color(0xff425466),
                                ),
                                title: Text(
                                  'Inicio',
                                  style: TextStyle(
                                      color: selectDrawer == 'Inicio'
                                          ? const Color(0xffE7B400)
                                          : const Color(0xff425466)),
                                ),
                                onTap: () => _.onSelectDrawer('Inicio',true),
                              ),
                              ListTile(
                                leading: ImageIcon(
                                  const AssetImage('assets/icons/bell.png'),
                                  color: selectDrawer == 'Notificaciones'
                                      ? const Color(0xffE7B400)
                                      : const Color(0xff425466),
                                ),
                                title: Text(
                                  'Notificaciones',
                                  style: TextStyle(
                                    color: selectDrawer == 'Notificaciones'
                                        ? const Color(0xffE7B400)
                                        : const Color(0xff425466),
                                  ),
                                ),
                                onTap: () => _.onSelectDrawer('Notificaciones',true),
                              ),
                              ListTile(
                                leading: ImageIcon(
                                  const AssetImage('assets/icons/people.png'),
                                  color: selectDrawer == 'Estudiantes'
                                      ? const Color(0xffE7B400)
                                      : const Color(0xff425466),
                                ),
                                title: Text(
                                  'Estudiantes',
                                  style: TextStyle(
                                      color: selectDrawer == 'Estudiantes'
                                          ? const Color(0xffE7B400)
                                          : const Color(0xff425466)),
                                ),
                                onTap: () => _.onSelectDrawer('Estudiantes',true),
                              ),
                              ListTile(
                                leading: ImageIcon(
                                  const AssetImage(
                                      'assets/icons/person-plus.png'),
                                  color: selectDrawer == 'Apoderados'
                                      ? const Color(0xffE7B400)
                                      : const Color(0xff425466),
                                ),
                                title: Text(
                                  'Apoderados',
                                  style: TextStyle(
                                      color: selectDrawer == 'Apoderados'
                                          ? const Color(0xffE7B400)
                                          : const Color(0xff425466)),
                                ),
                                onTap: () => _.onSelectDrawer('Apoderados',true),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          leading:
                          const ImageIcon(AssetImage('assets/icons/close.png')),
                          title:const Text(
                            'Cerrar sesión',
                            style: TextStyle(color: Color(0xff425466)),
                          ),
                          onTap: _.logOut,
                        ),
                      ],
                    ),
                  );
                }),
            Expanded(
                child: GetRouterOutlet(
              initialRoute: Routes.inicio,
              key: Get.nestedKey(Routes.home),
            ))
          ],
        ),
      );
    });
  }
}
