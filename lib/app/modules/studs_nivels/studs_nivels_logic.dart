import 'package:get/get.dart';
import 'package:notificaciones_unifront/app/data/models/nivel_model.dart';
import 'package:notificaciones_unifront/app/data/repositorys/db_repository.dart';
import 'package:notificaciones_unifront/app/data/services/auth_service.dart';
import 'package:notificaciones_unifront/app/routes/app_pages.dart';

class StudsNivelsLogic extends GetxController {
  final _dbRepository = Get.find<DbRepository>();
  NivelModel? _nivelModel;

  NivelModel? get nivelModel => _nivelModel;

  @override
  void onReady() {
    _getNiveles();
    super.onReady();
  }


  void _getNiveles() async {
    final token = await AuthService.to.getToken();
    if (token != null) {
      _nivelModel = await _dbRepository.getNiveles(token: token);
      update(['niveles']);
    } else {
      Get.rootDelegate.toNamed(Routes.login);
    }
  }

  void toStudsGrads(int idNivel) {
    Get.rootDelegate.toNamed(Routes.studsGrades(idNivel.toString()));
  }
}
