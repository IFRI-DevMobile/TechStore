import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CodeVerificationController extends GetxController {
  final TextEditingController pinController = TextEditingController();
  final RxString currentPin = ''.obs;
  final RxBool hasError = false.obs;
  final RxString email = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // Récupérer l'email passé en argument
    final arguments = Get.arguments;
    if (arguments != null && arguments['email'] != null) {
      email.value = arguments['email'];
    } else {
      email.value = "exemple@datnet.com"; // Valeur par défaut
    }

    pinController.addListener(_updatePin);
  }

  void _updatePin() {
    currentPin.value = pinController.text;
  }

  void verifyOtp() {
    if (currentPin.value.isEmpty) {
      Get.snackbar(
        "Champ vide",
        "Veuillez entrer le code reçu",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    // Vérification avec OTP fixe pour la démo
    if (currentPin.value == "123456") {
      hasError.value = false;
      Get.snackbar(
        "Succès",
        "Code correct ! Redirection...",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Ici, vous pouvez naviguer vers la page suivante (réinitialisation de mot de passe)
      // Get.offNamed('/reset-password', arguments: {'email': email.value});

      // Pour la démo, on reste sur la même page avec un message
      Future.delayed(const Duration(seconds: 2), () {
        Get.dialog(
          AlertDialog(
            title: const Text("Code validé"),
            content: Text("Le code a été validé pour l'email: ${email.value}"),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      });
    } else {
      hasError.value = true;
      Get.snackbar(
        "Erreur",
        "Code incorrect. Essayez '123456' pour la démo.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }
}

class CodeVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CodeVerificationController());
  }
}