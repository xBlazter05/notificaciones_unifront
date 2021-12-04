import 'package:get/get.dart';
import 'package:notificaciones_unifront/app/data/models/nivel_model.dart';
import 'package:notificaciones_unifront/app/data/models/sub_nivel_model.dart';
import 'package:notificaciones_unifront/app/data/repositorys/db_repository.dart';
import 'package:notificaciones_unifront/app/data/services/auth_service.dart';
import 'package:notificaciones_unifront/app/routes/app_pages.dart';

class StudsProxiesLogic extends GetxController {
  String idNivel;
  String idGrade;

  StudsProxiesLogic(this.idNivel, this.idGrade);
  final _dbRepository = Get.find<DbRepository>();
  Nivele? _nivele;
  SubNivele? _subNivele;

  Nivele? get nivele => _nivele;

  SubNivele? get subNivele => _subNivele;
@override
  void onReady() {
  _getSubNivel();
    super.onReady();
  }

  void _getSubNivel() async {
    final token = await AuthService.to.getToken();
    if (token != null) {
      _nivele = await _dbRepository.getNivel(token: token, idNivel: idNivel);
      _subNivele =
      await _dbRepository.getSubNivel(token: token, idSubNivel: idGrade);
    }else {
      Get.rootDelegate.toNamed(Routes.login);
    }
    update(['title']);
  }

  void toStudsProxiesAdd() {
    Get.rootDelegate
        .toNamed(Routes.studsProxiesAdd(idNivel, idGrade));
  }

  void toStudsProxiesEdit() {
    Get.rootDelegate
        .toNamed(Routes.studsProxiesEdit(idNivel, idGrade));
  }
}
