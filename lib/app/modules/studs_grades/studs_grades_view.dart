import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'studs_grades_logic.dart';

class StudsGradesPage extends StatelessWidget {
  final logic = Get.find<StudsGradesLogic>();

  StudsGradesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const tileHeight = 200.0;
    const tileWidth = 300.0;
    const spacing = 20.0;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GetBuilder<StudsGradesLogic>(
          id: 'title',
          builder: (_) {
            final nivel = _.nivele;
            return AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Estudiantes >  ${nivel != null ? nivel.name : ''}',
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
                        GetBuilder<StudsGradesLogic>(
                            id: 'subniveles',
                            builder: (_) {
                              final subNivelModel = _.subNivelModel;
                              return subNivelModel != null
                                  ? subNivelModel.subNiveles.isNotEmpty
                                  ? LayoutBuilder(
                                  builder: (context, constaints) {
                                    final count =
                                        constaints.maxWidth ~/ tileWidth;
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: count,
                                          childAspectRatio:
                                          tileWidth / tileHeight,
                                          crossAxisSpacing: spacing,
                                          mainAxisSpacing: spacing),
                                      itemBuilder: (__, index) {
                                        final subNivel = subNivelModel
                                            .subNiveles[index];
                                        return MouseRegion(
                                          cursor:
                                          SystemMouseCursors.click,
                                          child: GestureDetector(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(
                                                      index % 2 == 0
                                                          ? 0xff1E4280
                                                          : 0xffF4C300),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(8)),
                                              child: Center(
                                                  child: Text(
                                                    subNivel.name,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 40,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                    textAlign:
                                                    TextAlign.center,
                                                  )),
                                            ),
                                            onTap: () => logic
                                                .toStudsProxies(subNivel.id),
                                          ),
                                        );
                                      },
                                      itemCount:
                                      subNivelModel.subNiveles.length,
                                    );
                                  })
                                  : const Center(
                                child: Text('Datos no encontrados'),
                              )
                                  : const Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                        const SizedBox(height: 20),
                      ]))))
    ]);
  }
}
