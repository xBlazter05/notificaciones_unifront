import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'studs_proxies_logic.dart';

class StudsProxiesPage extends StatelessWidget {
  final logic = Get.find<StudsProxiesLogic>();

  StudsProxiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const tileHeight = 250.0;
    const tileWidth = 450.0;
    const spacing = 20.0;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GetBuilder<StudsProxiesLogic>(
          id: 'title',
          builder: (_) {
            final subNivel = _.subNivele;
            final nivel = _.nivele;
            return AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Estudiantes > ${nivel != null ? nivel.name : ''} > ${subNivel!=null ? subNivel.name  : ''}',
                style:
                const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            );
          }),
      Expanded(
          child: Padding(
              padding: const EdgeInsets.only(top: 60, right: 60, left: 60),
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Establezca un nuevo apoderado a cada estudiante',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Seleccione el grado en el que desea establecer apoderados',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 50),
                        LayoutBuilder(builder: (context, constaints) {
                          final count = constaints.maxWidth ~/ tileWidth;
                          return GridView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: count,
                                    childAspectRatio: tileWidth / tileHeight,
                                    crossAxisSpacing: spacing,
                                    mainAxisSpacing: spacing),
                            children: [
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xff1E4280),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Center(
                                        child: Text(
                                      'Agregar apoderado a un estudiante',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    )),
                                  ),
                                  onTap: logic.toStudsProxiesAdd,
                                ),
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF4C300),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Center(
                                        child: Text(
                                      'Modificar el apoderado de un estudiante',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    )),
                                  ),
                                  onTap:  logic.toStudsProxiesEdit,
                                ),
                              )
                            ],
                          );
                        }),
                        const SizedBox(height: 20),
                      ]))))
    ]);
  }
}
