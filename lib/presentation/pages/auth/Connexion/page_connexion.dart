import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/navigation.dart';
import '/utils/custom_text_field.dart';


class PageConnexion extends StatefulWidget {
  const PageConnexion({super.key});

  @override
  State<PageConnexion> createState() => _PageConnexionState();
}

class _PageConnexionState extends State<PageConnexion> {
  bool _passwordVisible = false; // mot de passe caché par défaut

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

              // E-mail
              const CustomTextField(
                hintText: "E-mail",
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Mot de passe
              CustomTextField(
                hintText: "Mot de passe",
                prefixIcon: Icons.lock_outline,
                obscureText: !_passwordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),

              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
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
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar('Succès', 'Connexion réussie !');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 37, 28, 217),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Se connecter",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

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
    );
  }
}

