import 'dart:developer';
import 'package:code_initial/presentation/pages/catalogue/catalogue_page.dart';
import 'package:code_initial/presentation/pages/catalogue/catalogue_controller.dart';
import 'package:code_initial/presentation/pages/profil/profil_page.dart';
import 'package:code_initial/presentation/pages/profil/profil_controller.dart';
import 'package:code_initial/presentation/pages/home/accueil_page.dart';
import 'package:code_initial/presentation/pages/home/accueil_controller.dart';
import 'package:code_initial/presentation/pages/cart/cart_page.dart';
import 'package:code_initial/presentation/pages/cart/cart_controller.dart';
import 'package:code_initial/presentation/pages/home/root_screen.dart';

// === Import pages ===
import 'presentation/pages/SplashScreen/page_splash.dart';
import 'presentation/pages/auth/Connexion/page_connexion.dart';
import 'presentation/pages/auth/Inscription/page_inscription.dart';
import 'package:code_initial/presentation/pages/auth/Inscription/inscription_controller.dart';
import 'package:code_initial/presentation/pages/register/register_page.dart';
import 'package:code_initial/presentation/pages/auth/code_verification/code_verification_page.dart';
import 'package:code_initial/presentation/pages/auth/mot_de_passe_oublie/mot_de_passe_oublie_page.dart';

// === Import Controllers ===
import 'package:code_initial/presentation/pages/auth/mot_de_passe_oublie/mot_de_passe_oublie_controller.dart';
import 'package:code_initial/presentation/pages/auth/code_verification/code_verification_controller.dart';
import 'package:get/get.dart';

class Routes {
  // ROUTES
  static const SPLASH = "/";
  static const HOME = "/home";
  static const CONNEXION = "/connexion";
  static const INSCRIPTION = "/inscription";
  static const OTPCODE = "/auth/code_verification";
  static const MDPFORGET = "/auth/mot_de_passe_oublie";
  static const CATALOGUE = '/catalogue';
  static const PROFIL = '/profil';
  static const CART = '/cart';

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
      binding: BindingsBuilder((){
        Get.lazyPut<InscriptionController>(() => InscriptionController());
      }),
    ),
    GetPage(
      name: Routes.MDPFORGET,
      page: () => MotDePasseOubliePage(),
      binding: MotDePasseOublieBinding(),
    ),
    GetPage(
      name: Routes.OTPCODE,
      page: () => CodeVerificationPage(),
      binding: CodeVerificationBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => AccueilPage(),
      binding: AccueilBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.CATALOGUE,
      page: () => const CataloguePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<CatalogueController>(() => CatalogueController());
      }),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.PROFIL,
      page: () => const ProfilPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProfilController>(() => ProfilController());
      }),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.CART,
      page: () => const CartPage(),
      binding: CartBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}

// Initialisation globale du CartController
class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartController(), permanent: true);
  }
}

