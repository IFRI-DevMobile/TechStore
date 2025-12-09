// lib/controllers/code_verification_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CodeVerificationController extends GetxController {
  final pinController = TextEditingController();
  var currentPin = ''.obs;
  var hasError = false.obs;
  var email = ''.obs; // Variable pour stocker l'email reçu

  @override
  void onInit() {
    super.onInit();

    // Récupérer l'email passé en argument
    final arguments = Get.arguments;
    if (arguments != null && arguments['email'] != null) {
      email.value = arguments['email'];
      debugPrint("Email reçu pour vérification: ${email.value}");
    }

    pinController.addListener(_updatePin);
  }

  void _updatePin() {
    currentPin.value = pinController.text;
  }

  void verifyOtp() {
    if (currentPin.value == "123456") { // Code fixe pour la démo
      hasError.value = false;
      Get.snackbar("Succès", "Code PIN correct !");

      // Ici vous pourriez naviguer vers la page de réinitialisation du mot de passe
      // Get.offNamed(Routes.RESET_PASSWORD, arguments: {'email': email.value});

    } else {
      hasError.value = true;
      Get.snackbar("Erreur", "Code PIN incorrect.");
    }
  }

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }
}