import 'package:get/get.dart';
import 'package:notificaciones_unifront/app/data/models/nivel_model.dart';
import 'package:notificaciones_unifront/app/data/models/sub_nivel_model.dart';
import 'package:notificaciones_unifront/app/data/repositorys/db_repository.dart';
import 'package:notificaciones_unifront/app/data/services/auth_service.dart';
import 'package:notificaciones_unifront/app/routes/app_pages.dart';

class StudsGradesLogic extends GetxController {
  String idNivel;

  StudsGradesLogic(this.idNivel);

  final _dbRepository = Get.find<DbRepository>();

  SubNivelModel? _subNivelModel;
  Nivele? _nivele;

  SubNivelModel? get subNivelModel => _subNivelModel;

  Nivele? get nivele => _nivele;

  @override
  void onReady() {
    _getSubNiveles();
    _getNivel();
    super.onReady();
  }

  void _getNivel() async {
    final token = await AuthService.to.getToken();
    if (token != null) {
      _nivele = await _dbRepository.getNivel(token: token, idNivel: idNivel);
      update(['title']);
    } else {
      Get.rootDelegate.toNamed(Routes.login);
    }
  }

  void _getSubNiveles() async {
    final token = await AuthService.to.getToken();
    if (token != null) {
      _subNivelModel =
          await _dbRepository.getSubNiveles(token: token, idNivel: idNivel);
      update(['subniveles']);
    } else {
      Get.rootDelegate.toNamed(Routes.login);
    }
  }

  void toStudsProxies(int idGrade) {
    Get.rootDelegate.toNamed(Routes.studsProxies(idNivel, idGrade.toString()));
  }
}
