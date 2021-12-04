part of 'app_pages.dart';

abstract class Routes {
  static const login = _Paths.login;

  static String loginThen(String afterSuccessFullLogin) =>
      '$login?then=${Uri.encodeQueryComponent(afterSuccessFullLogin)}';

  static const home = _Paths.home;
  static const inicio = home + _Paths.inicio;
  static const notifNivels = home + _Paths.notifNivels;

  static String notifGrades(String idNivel) => '$home/notifGrades/$idNivel';

  static String notifSend(String idNivel, String idGrade) =>
      '$home/notifSend/$idNivel/$idGrade';
  static const studsNivels = home + _Paths.studsNivels;

  static String studsGrades(String idNivel) => '$home/studsGrades/$idNivel';

  static String studsProxies(String idNivel, String idGrade) =>
      '$home/studsProxies/$idNivel/$idGrade';

  static String studsProxiesAdd(
          String idNivel, String idGrade) =>
      '$home/studsProxiesAdd/$idNivel/$idGrade';

  static String studsProxiesEdit(
          String idNivel, String idGrade) =>
      '$home/studsProxiesEdit/$idNivel/$idGrade';
  static const proxies = home + _Paths.proxies;
}

abstract class _Paths {
  static const login = '/login';
  static const home = '/home';
  static const inicio = '/inicio';
  static const notifNivels = '/notifNivels';
  static const notifGrades = '/notifGrades/:idNivel';
  static const notifSend = '/notifSend/:idNivel/:idGrade';
  static const studsNivels = '/studsNivels';
  static const studsGrades = '/studsGrades/:idNivel';
  static const studsProxies = '/studsProxies/:idNivel/:idGrade';
  static const studsProxiesAdd = '/studsProxiesAdd/:idNivel/:idGrade';
  static const studsProxiesEdit = '/studsProxiesEdit/:idNivel/:idGrade';
  static const proxies = '/proxies';
}
