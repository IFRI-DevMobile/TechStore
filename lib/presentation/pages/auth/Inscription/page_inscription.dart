import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/navigation.dart';
import '/utils/custom_text_field.dart';
import 'inscription_controller.dart';

class PageInscription extends GetView<InscriptionController> {
  const PageInscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Image.asset(
                  "design/assets/NotreLogo.png",
                  width: 100,
                  height: 100,
                ),
                const Text(
                  "TechStore",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 48),

                // Nom complet
                CustomTextField(
                  controller: controller.nameController,
                  hintText: "Nom complet",
                  prefixIcon: Icons.person_outline,
                ),
                const SizedBox(height: 16),

                // E-mail
                CustomTextField(
                  controller: controller.emailController,
                  hintText: "E-mail",
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                // Mot de passe
                Obx(() => CustomTextField(
                  controller: controller.passwordController,
                  hintText: "Mot de passe",
                  prefixIcon: Icons.lock_outline,
                  obscureText: !controller.isPasswordVisible.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 20,
                    ),
                    onPressed: () => controller.togglePasswordVisibility(),
                  ),
                )),
                const SizedBox(height: 16),

                // Confirmer le mot de passe
                Obx(() => CustomTextField(
                  controller: controller.confirmPasswordController,
                  hintText: "Confirmer le mot de passe",
                  prefixIcon: Icons.lock_outline,
                  obscureText: !controller.isConfirmPasswordVisible.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isConfirmPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 20,
                    ),
                    onPressed: () => controller.toggleConfirmPasswordVisibility(),
                  ),
                )),

                const SizedBox(height: 24),
                Obx(() => SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value ? null : () => controller.register(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.isLoading.value
                          ? Colors.grey
                          : const Color.fromARGB(255, 37, 28, 217),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                        : const Text(
                      "S'inscrire",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Vous avez déjà un compte ?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.CONNEXION);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(left: 4),
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        "Se connecter",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 37, 28, 217),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}