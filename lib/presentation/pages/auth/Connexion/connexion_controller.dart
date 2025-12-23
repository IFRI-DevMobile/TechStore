import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:code_initial/domain/services/ApiService.dart';

class ConnexionController extends GetxController {
  final ApiService _api = Get.find<ApiService>();
  final _storage = GetStorage();

  // Contrôleurs pour les champs de texte
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Variables réactives
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var rememberMe = false.obs;

  Future<void> login() async {
    try {
      // Validation des champs
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        Get.snackbar(
          "Erreur",
          "Veuillez remplir tous les champs",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Vérification du format email
      if (!isValidEmail(emailController.text)) {
        Get.snackbar(
          "Erreur",
          "Veuillez entrer un email valide",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      isLoading(true);

      // Appel API de connexion
      final response = await _api.dio.post('auth/login', data: {
        'email': emailController.text,
        'password': passwordController.text,
      });

      if (response.statusCode == 200) {
        String token = response.data['token'];

        // Stockage du token
        await _storage.write('token', token);

        // Optionnel: Stockage des informations utilisateur
        if (response.data['user'] != null) {
          await _storage.write('user', response.data['user']);
        }

        Get.snackbar(
          "Succès",
          "Connexion réussie !",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Redirection vers la page d'accueil
        Get.offAllNamed('/home');
      }
    } on DioException catch (e) {
      // Gestion des erreurs d'API
      String errorMsg = "Erreur lors de la connexion";

      if (e.response?.statusCode == 422) {
        // Erreur de validation Laravel
        if (e.response?.data['errors'] != null) {
          final errors = e.response!.data['errors'];

          // Vérifier les erreurs d'email
          if (errors['email'] != null && errors['email'].isNotEmpty) {
            String message = errors['email'][0];

            // Traduire le message d'erreur
            if (message.contains("The provided credentials are incorrect")) {
              errorMsg = "Email ou mot de passe incorrect";
            } else if (message.contains("The email field must be a valid email")) {
              errorMsg = "Veuillez entrer un email valide";
            } else {
              errorMsg = message;
            }
          } else if (errors['password'] != null && errors['password'].isNotEmpty) {
            errorMsg = errors['password'][0];
          }
        }
      } else if (e.response?.statusCode == 401) {
        errorMsg = "Email ou mot de passe incorrect";
      } else if (e.response?.data != null && e.response?.data['message'] != null) {
        errorMsg = e.response!.data['message'];
      }

      Get.snackbar(
        "Erreur",
        errorMsg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        "Erreur",
        "Une erreur inattendue s'est produite",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  // Méthode de validation d'email
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Méthode pour basculer la visibilité du mot de passe
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Méthode pour basculer "Se souvenir de moi"
  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  @override
  void onInit() {
    super.onInit();
    // Optionnel: Charger les informations sauvegardées si "Se souvenir de moi" était activé
    final savedEmail = _storage.read('saved_email');
    final savedPassword = _storage.read('saved_password');

    if (savedEmail != null) emailController.text = savedEmail;
    if (savedPassword != null) passwordController.text = savedPassword;
  }

  @override
  void onClose() {
    // Sauvegarder les informations si "Se souvenir de moi" est activé
    if (rememberMe.value) {
      _storage.write('saved_email', emailController.text);
      _storage.write('saved_password', passwordController.text);
    } else {
      _storage.remove('saved_email');
      _storage.remove('saved_password');
    }

    // Nettoyer les contrôleurs
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

class ConnexionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConnexionController());
  }
}