import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'mot_de_passe_oublie_controller.dart';

class MotDePasseOubliePage extends GetView<MotDePasseOublieController> {
  const MotDePasseOubliePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              SvgPicture.asset(
                'design/NotreLogo.svg',
                width: 80,
                height: 80,
              ),
              const SizedBox(height: 40),
              Text(
                "Récupération de votre compte",
                style: TextStyle(fontSize: 24, 
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "Veuillez entrer votre e-mail. Un code vous sera envoyé à cette adresse.",
                style: TextStyle(fontSize: 15,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,),

                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'example@datnet.com',
                  prefixIcon: Icon(Icons.mail_outline, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey[100],
                  filled: true,
                ),
              ),
              const SizedBox(height: 40),
              Obx(
                    () => SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed:
                    controller.isLoading.value ? null : controller.sendCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5B5FFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      'Recevoir le code',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}