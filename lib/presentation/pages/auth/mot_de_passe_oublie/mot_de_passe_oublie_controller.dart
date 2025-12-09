import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:code_initial/navigation.dart';

class MotDePasseOublieController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> sendCode() async {
    final email = emailController.text.trim();

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
      // Simulation d'appel API
      await Future.delayed(const Duration(seconds: 2));

      Get.snackbar(
        "Succès",
        "Code envoyé à $email !",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigation vers la page OTP avec l'email en paramètre
      Get.toNamed(
        Routes.OTPCODE,
        arguments: {'email': email},
      );
    } catch (e) {
      Get.snackbar(
        "Erreur",
        "Une erreur est survenue lors de l'envoi.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

class MotDePasseOublieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MotDePasseOublieController());
  }
}