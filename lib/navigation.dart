import 'dart:developer';
import 'package:code_initial/presentation/pages/catalogue/catalogue_page.dart';
import 'package:code_initial/presentation/pages/catalogue/catalogue_controller.dart';
import 'package:code_initial/presentation/pages/profil/profil_page.dart';
import 'package:code_initial/presentation/pages/profil/profil_controller.dart';

// === Import pages ===
import 'presentation/pages/splashscreen/page_splash.dart';
import 'presentation/pages/Auth/CONNEXION/page_CONNEXION.dart';
import 'presentation/pages/Auth/INSCRIPTION/page_INSCRIPTION.dart';
import 'package:code_initial/presentation/pages/register/register_page.dart';
import 'package:code_initial/presentation/pages/auth/code_verification/code_verification_page.dart';
import 'package:code_initial/presentation/pages/auth/mot_de_passe_oublie/mot_de_passe_oublie_page.dart';

// === Import Controllers ===
import 'package:code_initial/presentation/pages/auth/mot_de_passe_oublie/mot_de_passe_oublie_controller.dart';
import 'package:get/get.dart';

class Routes {
  // ROUTES
  static const SPLASH = "/";
  static const CONNEXION = "/connexion";
  static const INSCRIPTION = "/inscription";
  static const REGISTER = '/register';
  static const OTPCODE = "/auth/code_verification";
  static const MDPFORGET = "/auth/mot_de_passe_oublie";
  static const CATALOGUE = '/catalogue';
  static const PROFIL = '/profil';

  // ROUTE INITIALE
  static Future<String> get initialRoute async {
    return SPLASH;
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const PageSplash(),
    ),
    GetPage(
      name: Routes.CONNEXION,
      page: () => const PageConnexion(),
    ),
    GetPage(
      name: Routes.INSCRIPTION,
      page: () => const PageInscription(),
    ),
    GetPage(
      name: Routes.MDPFORGET,
      page: () => MotDePasseOubliePage(),
      binding: MotDePasseOublieBinding(),
    ),
    GetPage(
      name: Routes.OTPCODE,
      page: () => CodeVerificationPage(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterPage(),
    ),
    GetPage(
      name: Routes.CATALOGUE,
      page: () => const CataloguePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<CatalogueController>(() => CatalogueController());
      }),
    ),
    GetPage(
      name: Routes.PROFIL,
      page: () => const ProfilPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProfilController>(() => ProfilController());
      }),
    ),
  ];
}

