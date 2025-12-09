import 'dart:developer';
import 'package:code_initial/presentation/pages/register/register_page.dart';
import 'package:code_initial/presentation/pages/auth/code_verification/code_verification_page.dart';
import 'package:code_initial/presentation/pages/auth/code_verification/code_verification_controller.dart';
import 'package:code_initial/presentation/pages/auth/mot_de_passe_oublie/mot_de_passe_oublie_controller.dart';
import 'package:code_initial/presentation/pages/auth/mot_de_passe_oublie/mot_de_passe_oublie_page.dart';
import 'package:get/get.dart';

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterPage(),
    ),
    GetPage(
      name: Routes.OTPCODE,
      page: ()=>CodeVerificationPage(),
      binding:CodeVerificationBinding(),
    ),
    GetPage(
      name: Routes.MDPFORGET,
      page: ()=>MotDePasseOubliePage(),
      binding:MotDePasseOublieBinding(),
    ),
  ];
}


class Routes {
  static Future<String> get initialRoute async {

      return MDPFORGET;
  }

  static const String MAIN = "/";

  static const REGISTER = '/register';
  static const OTPCODE = "/auth/code_verification";
  static const MDPFORGET ="/auth/mot_de_passe_oublie";

}
