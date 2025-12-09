import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/navigation.dart';  // ajuste éventuellement le chemin


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
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Image.asset(
              "design/assets/NotreLogo.png",
              width: 90,
              height: 90,
            ),
            const SizedBox(height: 10),
            const Text("TechStore",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),

            // E-mail
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                hintText: "E-mail",
                filled: true,
                fillColor: Colors.grey.shade200, // assombrit légèrement
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Mot de passe
            TextField(
              obscureText: !_passwordVisible, // masque le mot de passe
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                hintText: "Mot de passe",
                filled: true,
                fillColor: Colors.grey.shade200, // assombrit légèrement
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text("Mot de passe oublié ?"),
              ),
            ),

            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text("Se connecter",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Créer un compte ?"),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.inscription);
                  },
                  child: const Text("S'inscrire"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

