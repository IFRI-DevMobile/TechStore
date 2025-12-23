import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:code_initial/domain/services/ApiService.dart';

class ProfilController extends GetxController {
  final ApiService _api = Get.find<ApiService>();
  final _storage = GetStorage();

  // Informations utilisateur (observables)
  final userName = ''.obs;
  final userEmail = ''.obs;
  final userAvatar = 'design/assets/Avatar1.png'.obs;
  final isLoading = true.obs;
  final errorMessage = ''.obs;

  // Informations utilisateur complètes
  var userData = <String, dynamic>{}.obs;

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
      'subtitle': 'Modifier vos informations personnelles',
      'route': '/personal-info',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    print('🚀 ProfilController initialisé');
    _loadUserProfile();
  }

  /// Charge le profil utilisateur depuis l'API
  Future<void> _loadUserProfile() async {
    try {
      isLoading(true);
      errorMessage.value = '';

      // Vérifier si un token existe
      final token = _storage.read('token');
      if (token == null) {
        Get.snackbar(
          "Erreur",
          "Vous devez vous connecter",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        Get.offAllNamed('/connexion');
        return;
      }

      // Appel API pour récupérer les informations utilisateur
      // Note: Vérifiez le bon endpoint avec votre backend
      final response = await _api.dio.get('auth/user');

      if (response.statusCode == 200) {
        // Stocker les données complètes
        userData.value = response.data;

        // Extraire les informations spécifiques
        if (response.data['user'] != null) {
          final user = response.data['user'];
          userName.value = user['name'] ?? 'Utilisateur';
          userEmail.value = user['email'] ?? '';

          // Si l'avatar est disponible depuis l'API
          if (user['avatar'] != null) {
            userAvatar.value = user['avatar'];
          }
        } else {
          // Si la réponse n'a pas de structure 'user'
          userName.value = response.data['name'] ?? 'Utilisateur';
          userEmail.value = response.data['email'] ?? '';
        }

        print('✅ Profil utilisateur chargé avec succès');
      }
    } on DioException catch (e) {
      // Gestion des erreurs
      String errorMsg = "Erreur lors du chargement du profil";

      if (e.response?.statusCode == 401) {
        errorMsg = "Session expirée. Veuillez vous reconnecter.";
        // Supprimer le token expiré
        await _storage.remove('token');
        Get.offAllNamed('/connexion');
      } else if (e.response?.data != null && e.response?.data['message'] != null) {
        errorMsg = e.response!.data['message'];
      }

      errorMessage.value = errorMsg;

      Get.snackbar(
        "Erreur",
        errorMsg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      errorMessage.value = "Une erreur inattendue s'est produite";
      print('❌ Erreur lors du chargement du profil: $e');
    } finally {
      isLoading(false);
    }
  }

  /// Rafraîchir les données utilisateur
  Future<void> refreshProfile() async {
    await _loadUserProfile();
  }

  /// Mettre à jour les informations utilisateur
  Future<void> updateProfile(Map<String, dynamic> data) async {
    try {
      isLoading(true);

      final response = await _api.dio.put('auth/user/update', data: data);

      if (response.statusCode == 200) {
        // Mettre à jour les données locales
        await _loadUserProfile();

        Get.snackbar(
          "Succès",
          "Profil mis à jour avec succès",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } on DioException catch (e) {
      String errorMsg = "Erreur lors de la mise à jour";

      if (e.response?.data != null && e.response?.data['message'] != null) {
        errorMsg = e.response!.data['message'];
      } else if (e.response?.data['errors'] != null) {
        errorMsg = "Veuillez corriger les erreurs de validation";
      }

      Get.snackbar(
        "Erreur",
        errorMsg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  /// Déconnexion
  Future<void> logout() async {
    try {
      isLoading(true);

      // Appel API pour déconnexion
      await _api.dio.post('auth/logout');

      // Supprimer les données locales
      await _storage.remove('token');
      await _storage.remove('user');

      // Réinitialiser les données utilisateur
      userName.value = '';
      userEmail.value = '';
      userData.value = {};

      Get.snackbar(
        "Déconnexion",
        "Vous avez été déconnecté avec succès",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );

      // Rediriger vers la page de connexion
      Get.offAllNamed('/connexion');
    } on DioException catch (e) {
      // Même en cas d'erreur, déconnecter localement
      await _storage.remove('token');
      await _storage.remove('user');

      Get.offAllNamed('/connexion');
    } finally {
      isLoading(false);
    }
  }

  /// Navigue vers une option du menu
  void navigateToOption(String route) {
    print('📍 Navigation vers : $route');
    // Get.toNamed(route); // Décommenter quand les routes seront créées
  }

  @override
  void onClose() {
    super.onClose();
  }
}