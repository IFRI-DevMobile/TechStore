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
import 'package:get/get.dart';

// === Import de tes propres pages ===
import 'presentation/pages/page_splash.dart';
import 'presentation/pages/page_connexion.dart';
import 'presentation/pages/page_inscription.dart';

// === Import de la page Register qui était déjà dans le dépôt ===
import 'presentation/pages/register/register_page.dart';

class Routes {
  // ROUTES
  static const splash = "/";
  static const connexion = "/connexion";
  static const inscription = "/inscription";
  static const register = "/register";

      return MDPFORGET;
  // ROUTE INITIALE
  static Future<String> get initialRoute async {
    // Tu peux mettre la logique que tu veux ici
    return splash;
  }
}

class Nav {
  static final routes = [

  static const REGISTER = '/register';
  static const OTPCODE = "/auth/code_verification";
  static const MDPFORGET ="/auth/mot_de_passe_oublie";
    // === Route Splash ===
    GetPage(
      name: Routes.splash,
      page: () => const PageSplash(),
    ),

    // === Route Connexion ===
    GetPage(
      name: Routes.connexion,
      page: () => const PageConnexion(),
    ),

    // === Route Inscription ===
    GetPage(
      name: Routes.inscription,
      page: () => const PageInscription(),
    ),

    // === Route REGISTER (déjà présente dans le dépôt) ===
    GetPage(
      name: Routes.register,
      page: () => RegisterPage(),
    ),
  ];
}
