// lib/controllers/forgot_password_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:code_initial/navigation.dart';
import 'dart:async'; // Pour simuler une requête réseau

class MotDePasseOublieController extends GetxController {
  // Contrôleur pour le champ de saisie d'e-mail
  final TextEditingController emailController = TextEditingController();

  // Variable réactive pour gérer l'état de chargement du bouton
  var isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  // Fonction appelée lorsque l'utilisateur appuie sur le bouton "Recevoir le code"
  Future<void> sendCode() async {
    final email = emailController.text;

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        "Erreur de saisie",
        "Veuillez entrer une adresse e-mail valide.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      // Remplacer cette partie par le véritable appel HTTP vers votre backend
      debugPrint("Appel API pour envoyer le code à $email");
      await Future.delayed(Duration(seconds: 2)); // Simule un délai réseau de 2 secondes
      // Si l'appel API réussit :
      Get.snackbar(
        "Succès",
        "Code envoyé à $email !",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.offNamed(
          Routes.OTPCODE,
          arguments: {'email': email}
      );

    } catch (e) {
      // Gérer les erreurs réseau ou backend
      Get.snackbar(
        "Erreur",
        "Une erreur est survenue lors de l'envoi.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false; // Arrête l'indicateur de chargement
    }
  }
}
class MotDePasseOublieBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>MotDePasseOublieController());
  }
}