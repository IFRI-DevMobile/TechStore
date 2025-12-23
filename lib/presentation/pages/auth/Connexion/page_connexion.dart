import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/navigation.dart';
import '/utils/custom_text_field.dart';
import 'connexion_controller.dart';

class PageConnexion extends StatelessWidget {
  const PageConnexion({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialiser le contrôleur
    final ConnexionController controller = Get.put(ConnexionController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "design/assets/NotreLogo.png",
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(height: 8),
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

                  const SizedBox(height: 12),

                  // Option "Se souvenir de moi"
                  Obx(() => Row(
                    children: [
                      Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.toggleRememberMe(),
                        activeColor: const Color.fromARGB(255, 37, 28, 217),
                      ),
                      const Text(
                        "Se souvenir de moi",
                        style: TextStyle(fontSize: 13),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.MDPFORGET);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          "Mot de passe oublié ?",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 37, 28, 217),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  )),

                  const SizedBox(height: 50),

                  // Bouton de connexion
                  Obx(() => SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value ? null : () => controller.login(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.isLoading.value
                            ? Colors.grey
                            : const Color.fromARGB(255, 37, 28, 217),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
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
                        "Se connecter",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )),

                  const SizedBox(height: 24),

                  // Lien vers l'inscription
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Créer un compte ?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.INSCRIPTION);
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(left: 4),
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          "S'inscrire",
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
      ),
    );
  }
}