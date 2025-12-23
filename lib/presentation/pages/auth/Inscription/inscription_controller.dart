import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:code_initial/domain/services/ApiService.dart';

class InscriptionController extends GetxController {
  final ApiService _api = Get.find<ApiService>();
  final _storage = GetStorage();
  var isLoading = false.obs;

  // Contrôleurs pour les champs de texte
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Variables pour la visibilité des mots de passe
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  Future<void> register() async {
    try {
      if (passwordController.text != confirmPasswordController.text) {
        Get.snackbar(
          "Erreur",
          "Les mots de passe ne correspondent pas",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (nameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty) {
        Get.snackbar(
          "Erreur",
          "Veuillez remplir tous les champs",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      isLoading(true);

      final response = await _api.dio.post('auth/register', data: {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'password_confirmation': confirmPasswordController.text,
      });

      if (response.statusCode == 201 || response.statusCode == 200) {
        String token = response.data['token'];

        // Stockage du token pour les prochaines requêtes
        await _storage.write('token', token);

        Get.snackbar(
          "Succès",
          "Compte créé avec succès !",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed('/home'); // Redirection vers l'accueil
      }
    } on DioException catch (e) {
      // Gestion des erreurs de validation Laravel (ex: email déjà pris)
      String errorMsg = "Erreur lors de l'inscription";
      if (e.response?.data != null && e.response?.data['message'] != null) {
        errorMsg = e.response!.data['message'];
      } else if (e.response?.data != null && e.response?.data['errors'] != null) {
        // Si Laravel retourne des erreurs de validation
        final errors = e.response!.data['errors'];
        if (errors['email'] != null) {
          errorMsg = errors['email'][0];
        } else if (errors['password'] != null) {
          errorMsg = errors['password'][0];
        }
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

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}