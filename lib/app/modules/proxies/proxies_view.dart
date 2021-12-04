import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'proxies_logic.dart';

class ProxiesPage extends StatelessWidget {
  final logic = Get.find<ProxiesLogic>();

  ProxiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Apoderados',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      Expanded(
          child: Padding(
              padding: const EdgeInsets.only(top: 60, right: 60, left: 60),
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Crear apoderados',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Agregue un nuevo apoderado, o bien, modifique o elimine un apoderado ya existente',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 50),
                        Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 135,
                              height: 46,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xff4C6FFF)),
                                onPressed: logic.addProxie,
                                icon: const ImageIcon(
                                    AssetImage('assets/icons/person-plus.png')),
                                label: const Text('Agregar'),
                              ),
                            )),
                        const SizedBox(height: 50),
                        const Text(
                          'Estudiantes con apoderado establecido',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: GetBuilder<ProxiesLogic>(
                              id: 'apoderados',
                              builder: (_) {
                                final apoderadoModel = _.apoderadoModel;
                                return apoderadoModel != null ? apoderadoModel
                                    .apoderados.isNotEmpty ?
                                SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: DataTable(columns: const [
                                    DataColumn(
                                        label: Text('#',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),

                                    DataColumn(
                                        label: Text('APELLIDOS',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),
                                    DataColumn(
                                        label: Text('NOMBRES',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),      DataColumn(
                                        label: Text('CORREO',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),
                                    DataColumn(
                                        label: Text('ACCIONES',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),
                                  ], rows: apoderadoModel.apoderados.map((e) {
                                    int index = apoderadoModel
                                        .apoderados
                                        .indexOf(e)+1;
                                    return DataRow(cells: [
                                      DataCell(SizedBox(
                                          width:
                                          size.width *
                                              0.1,
                                          child:
                                          Text(
                                              index.toString()))),

                                      DataCell(SizedBox(
                                          width:
                                          size.width *
                                              0.1,
                                          child: Text(
                                              e.name))),
                                      DataCell(SizedBox(
                                          width:
                                          size.width *
                                              0.1,
                                          child: Text(
                                              e.lastname))),
                                      DataCell(SizedBox(
                                          width:
                                          size.width *
                                              0.1,
                                          child: Text(
                                              e.correo))),
                                      DataCell(Row(
                                        mainAxisSize:
                                        MainAxisSize
                                            .min,
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
                                              onTap: () =>
                                                  logic.editProxie(
                                                      e),
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
                                              onTap: () =>
                                                  logic.deleteProxie(
                                                      e.id),
                                            ),
                                          ),
                                        ],
                                      )),
                                    ]);
                                  }).toList()),
                                ) : const Center(
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
