import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'inicio_logic.dart';

class InicioPage extends StatelessWidget {
  final logic = Get.find<InicioLogic>();

  InicioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Inicio',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 60, right: 60, left: 60),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const Text(
                    'Bienvenido(a) al sistema\n administrativo de notificaciones',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '¡Creemos notificaciones!',
                    style: TextStyle(
                      fontSize: 28,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      runAlignment: WrapAlignment.spaceEvenly,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: const Color(0xffE4ECF7),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: const Offset(0, 5),
                                    blurRadius: 5)
                              ]),
                          child: Column(
                            children: [
                              const Text(
                                'Notificaciones',
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'Cree una notificación',
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 30),
                              Image.asset('assets/icons/Vector.png',
                                  width: 210, height: 210),
                              const SizedBox(height: 30),
                              SizedBox(
                                height: 35,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color(0xff3754DB)),
                                  onPressed: logic.toNotifys,
                                  child: const Text('Comenzar'),
                                ),
                              ),
                            ],
                          ),
                        ),  Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: const Color(0xffE4ECF7),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: const Offset(0, 5),
                                    blurRadius: 5)
                              ]),
                          child: Column(
                            children: [
                              const Text(
                                'Estudiantes',
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'Apoderado para un estudiante',
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 30),
                              Image.asset('assets/icons/images.png',
                                  width: 210, height: 210),
                              const SizedBox(height: 30),
                              SizedBox(
                                height: 35,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color(0xff3754DB)),
                                  onPressed: logic.students,
                                  child: const Text('Comenzar'),
                                ),
                              ),
                            ],
                          ),
                        ),  Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: const Color(0xffE4ECF7),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: const Offset(0, 5),
                                    blurRadius: 5)
                              ]),
                          child: Column(
                            children: [
                              const Text(
                                'Apoderados',
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'Cree un nuevo apoderado',
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 30),
                              Image.asset('assets/icons/people-fill.png',
                                  width: 210, height: 210),
                              const SizedBox(height: 30),
                              SizedBox(
                                height: 35,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color(0xff3754DB)),
                                  onPressed: logic.toProxies,
                                  child: const Text('Comenzar'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const  SizedBox(height: 20)
,                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
