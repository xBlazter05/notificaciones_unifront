import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_logic.dart';

class LoginPage extends StatelessWidget {
  final logic = Get.find<LoginLogic>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Row(
          children: [
            Container(
              color: const Color(0xff1E4280),
              width: size.width * 0.4,
              height: size.height,
              child: Stack(
                children: [
                  Positioned(
                      top: size.height * 0.2,
                      right: 80,
                      left: 80,
                      child: Image.asset('assets/images/logo.png')),
                  Positioned(
                      top: size.height * 0.60,
                      right: 80,
                      left: 80,
                      child: RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                                text: 'Sistema de notificaciones\n\n',
                                style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                'Sistema para la creación y envío de notificaciones',
                                style: TextStyle(fontSize: 18, color: Colors.white)),
                          ]))),
                  Positioned(
                      left: 20,
                      bottom: 10,
                      child: Container(
                        width: 133,
                        height: 133,
                        decoration: const BoxDecoration(
                            color: Color(0xffF4C300), shape: BoxShape.circle),
                      )),
                  Positioned(
                      right: 30,
                      bottom: -40,
                      child: Container(
                        width: 196,
                        height: 196,
                        decoration: const BoxDecoration(
                            color: Color(0xffF4C300), shape: BoxShape.circle),
                      )),
                ],
              ),
            ),
            SizedBox(
              width: size.width * 0.6,
              height: size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Form(
                    key: logic.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '¡Bienvenido(a)!',
                          style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          '¡Creemos notificaciones!',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 50),
                        const Text(
                          'Usuario',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: logic.correoCtrl,
                          validator: (value) => logic.validateEmail(value),
                          decoration: InputDecoration(
                            hintText: 'Ingrese su usuario',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6)),
                          ),
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          'Contraseña',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          controller: logic.passwordCtrl,
                          validator: (value) => logic.isNotEmpty(value),
                          decoration: InputDecoration(
                            hintText: 'Ingrese su contraseña',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6)),
                          ),
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xff4C6FFF),
                                    padding: const EdgeInsets.all(10)),
                                onPressed: logic.toHome,
                                child: const Text(
                                  'Ingresar',
                                  style: TextStyle(fontSize: 16),
                                )))
                      ],
                    )),
              ),
            ),
          ],
        ));
  }
}
