import 'package:get/get.dart';

class ProfilController extends GetxController {
  // Informations utilisateur
  final userName = 'Jean Amidou El-Adj'.obs;
  final userEmail = 'amidou1000@gmail.com'.obs;
  final userAvatar = 'design/assets/Avatar1.png'.obs;

  // Options du menu
  final List<Map<String, dynamic>> menuOptions = [
    {
      'icon': 'package',
      'title': 'Mes commandes',
      'subtitle': 'Consultez l\'historique de vos commandes',
      'route': '/orders',
    },
    {
      'icon': 'settings',
      'title': 'Préférences',
      'subtitle': 'Personnalisez votre interface',
      'route': '/preferences',
    },
    {
      'icon': 'person',
      'title': 'Informations Personnelles',
      'subtitle': 'Modifier vos informations personnelle',
      'route': '/personal-info',
    },
  ];

  /// Navigue vers une option du menu
  void navigateToOption(String route) {
    print('📍 Navigation vers : $route');
    // Get.toNamed(route); // Décommenter quand les routes seront créées
  }

  /// Déconnexion
  void logout() {
    print('👋 Déconnexion...');
    Get.offAllNamed('/register'); // Retour à la page d'inscription
  }

  @override
  void onInit() {
    super.onInit();
    print('🚀 ProfilController initialisé');
  }
}
