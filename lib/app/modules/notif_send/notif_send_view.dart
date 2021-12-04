import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notif_send_logic.dart';

class NotifSendPage extends StatelessWidget {
  final logic = Get.find<NotifSendLogic>();

  NotifSendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GetBuilder<NotifSendLogic>(
          id: 'title',
          builder: (_) {
            final subNivel = _.subNivele;
            final nivel = _.nivele;
            return AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Notificaciones > ${nivel != null ? nivel.name : ''} > ${subNivel != null ? subNivel.name : ''}',
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
                          'Nueva notificación',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Elabore una notificación personalizada en el siguiente formulario',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 50),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(30),
                          child: Form(
                            key: logic.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    'Crear notificación',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 40),
                                const Text(
                                  'Título',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  color: Colors.white,
                                  child: TextFormField(
                                    controller: logic.titleCtrl,
                                    validator: (value) =>
                                        logic.isNotEmpty(value, 'un título'),
                                    decoration: InputDecoration(
                                      hintText: 'Título',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 50),
                                const Text(
                                  'Seleccione fecha de vencimiento',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: logic.onSelectDate,
                                    child: Container(
                                      color: Colors.white,
                                      child: TextFormField(
                                        enabled: false,
                                        controller: logic.dateCtrl,
                                        validator: (value) =>
                                            logic.isNotEmpty(value, 'un fecha'),
                                        decoration: InputDecoration(
                                          prefixIcon: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: ImageIcon(
                                              AssetImage(
                                                  'assets/icons/calendar.png'),
                                              size: 10,
                                            ),
                                          ),
                                          hintText:
                                              'Seleccione fecha de vencimiento',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 50),
                                const Text(
                                  'Mensaje',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  color: Colors.white,
                                  child: TextFormField(
                                    controller: logic.messageCtrl,
                                    validator: (value) =>
                                        logic.isNotEmpty(value, 'un mensaje'),
                                    maxLines: 8,
                                    decoration: InputDecoration(
                                      hintText: 'Mensaje',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Introduzca el mensaje de su notificación',
                                  style: TextStyle(fontSize: 11),
                                ),
                                const SizedBox(height: 50),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 162,
                                        height: 46,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary:
                                                    const Color(0xffA0AEC0)),
                                            onPressed: logic.cancel,
                                            child: const Text(
                                              'Cancelar',
                                            )),
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width: 162,
                                        height: 48,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary:
                                                    const Color(0xff4C6FFF)),
                                            onPressed: () {
                                              if (logic.formKey.currentState!
                                                  .validate()) {
                                                logic.send();
                                              }
                                            },
                                            child: const Text('Enviar')),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ]))))
    ]);
  }
}
