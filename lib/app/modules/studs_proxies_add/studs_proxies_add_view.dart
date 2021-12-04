import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'studs_proxies_add_logic.dart';

class StudsProxiesAddPage extends StatelessWidget {
  final logic = Get.find<StudsProxiesAddLogic>();

  StudsProxiesAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GetBuilder<StudsProxiesAddLogic>(
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
                          'Establecer apoderados',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Agregue un apoderado a cada estudiante',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 50),
                        const Text(
                          'Estudiantes sin apoderado establecido',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: GetBuilder<StudsProxiesAddLogic>(
                              id: 'students',
                              builder: (_) {
                                final estudianteModel = _.estudianteModel;
                                return estudianteModel != null
                                    ? estudianteModel.estudiantes.isNotEmpty
                                        ? SingleChildScrollView(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            child: DataTable(
                                                columns: const [
                                                  DataColumn(
                                                      label: Text('#',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  DataColumn(
                                                      label: Text('APELLIDOS',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  DataColumn(
                                                      label: Text('NOMBRES',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  DataColumn(
                                                      label: Text('ACCIONES',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                ],
                                                rows: estudianteModel
                                                    .estudiantes
                                                    .map((e) {
                                                  int index = estudianteModel
                                                      .estudiantes
                                                      .indexOf(e)+1;
                                                  return DataRow(cells: [
                                                    DataCell(SizedBox(
                                                        width: size.width * 0.02,
                                                        child: Text(
                                                            index.toString()))),
                                                    DataCell(SizedBox(
                                                        width: size.width * 0.1,
                                                        child:
                                                            Text(e.lastname))),
                                                    DataCell(SizedBox(
                                                        width: size.width * 0.1,
                                                        child: Text(e.name))),
                                                    DataCell(MouseRegion(
                                                      cursor: SystemMouseCursors
                                                          .click,
                                                      child: GestureDetector(
                                                        child: const ImageIcon(
                                                          AssetImage(
                                                              'assets/icons/person-plus.png'),
                                                          color: Colors.green,
                                                        ),
                                                        onTap: () => logic
                                                            .addProxie(size,e),
                                                      ),
                                                    )),
                                                  ]);
                                                }).toList()),
                                          )
                                        : const Center(
                                            child: Text('No hay datos'),
                                          )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      );
                              }),
                        ),
                        const SizedBox(height: 20),
                      ]))))
    ]);
  }
}
