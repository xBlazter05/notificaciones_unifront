import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'studs_proxies_edit_logic.dart';

class StudsProxiesEditPage extends StatelessWidget {
  final logic = Get.find<StudsProxiesEditLogic>();

  StudsProxiesEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GetBuilder<StudsProxiesEditLogic>(
          id: 'title',
          builder: (_) {
            final subNivel = _.subNivele;
            final nivel = _.nivele;
            return AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Estudiantes > ${nivel != null ? nivel.name : ''} > ${subNivel != null ? subNivel.name : ''}',
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
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
                          'Apoderados establecidos',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Consulte, modifique o elimine el apoderado de un estudiante',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 50),
                        const Text(
                          'Estudiantes con apoderado establecido',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: GetBuilder<StudsProxiesEditLogic>(
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
                                                      label: Text('APODERADO',
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
                                                          .indexOf(e) +
                                                      1;
                                                  return DataRow(cells: [
                                                    DataCell(SizedBox(
                                                        width: size.width * 0.02,
                                                        child: Text(
                                                            index.toString()))),
                                                    DataCell(SizedBox(
                                                        width: size.width * 0.1,
                                                        child: Text(
                                                  '${e.apoderado.lastname} ${e.apoderado.name}'))),
                                                    DataCell(SizedBox(
                                                        width: size.width * 0.1,
                                                        child:
                                                            Text(e.lastname))),
                                                    DataCell(SizedBox(
                                                        width: size.width * 0.1,
                                                        child: Text(e.name))),
                                                    DataCell(Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        MouseRegion(
                                                          cursor:
                                                              SystemMouseCursors
                                                                  .click,
                                                          child:
                                                              GestureDetector(
                                                            child:
                                                                const ImageIcon(
                                                              AssetImage(
                                                                  'assets/icons/pencil-square.png'),
                                                              color: Color(
                                                                  0xffF4C300),
                                                            ),
                                                            onTap: () => logic
                                                                .editProxie(
                                                                    size, e),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 15),
                                                        MouseRegion(
                                                          cursor:
                                                              SystemMouseCursors
                                                                  .click,
                                                          child:
                                                              GestureDetector(
                                                            child:
                                                                const ImageIcon(
                                                              AssetImage(
                                                                  'assets/icons/search.png'),
                                                              color: Color(
                                                                  0xff4C6FFF),
                                                            ),
                                                            onTap: () =>
                                                                logic.search(e
                                                                    .idapoderado),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 15),
                                                        MouseRegion(
                                                          cursor:
                                                              SystemMouseCursors
                                                                  .click,
                                                          child:
                                                              GestureDetector(
                                                            child:
                                                                const ImageIcon(
                                                              AssetImage(
                                                                  'assets/icons/trash1.png'),
                                                              color: Color(
                                                                  0xffF16063),
                                                            ),
                                                            onTap:()=> logic.delete(e),
                                                          ),
                                                        ),
                                                      ],
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
