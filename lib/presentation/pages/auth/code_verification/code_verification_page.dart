import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'code_verification_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CodeVerificationPage extends GetView<CodeVerificationController> {
  @override

  final CodeVerificationController controller = Get.put(CodeVerificationController());

  CodeVerificationPage({super.key});
  @override
  Widget build(BuildContext context){
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Colors.redAccent, width: 3),
      ),
    );
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('design/NotreLogo.svg',
              width: 80,
              height: 80,),
            SizedBox(height: 20),
            Text(
              "Vérifiez votre compte",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Entrez le code à 6 chiffres envoyé à votre adresse e-mail.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 40),
            Obx(() {
              return Pinput(
                controller: controller.pinController,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                errorPinTheme: errorPinTheme, // Assurez-vous que ce thème est défini
                onChanged: (value) {
                  debugPrint("$value");
                  if (controller.hasError.value) {
                    controller.hasError.value = false;
                  }
                },
                errorText: controller.hasError.value ? "Code error" : null,
                // isError: controller.hasError.value, // Retirez cette ligne si elle cause une erreur
                onCompleted: (pin) {
                  controller.verifyOtp();
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
              );
            }),
            SizedBox(
              width: 350,
              child:Obx(() {
              if (controller.hasError.value) {
                return const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Code error",

                    style: TextStyle(color: Colors.red, fontSize: 14, ),
                  ),
                );
              }
              return Container();
            }),
            ),


            SizedBox(height: 20,),
            TextButton(
              onPressed: (){
                controller.verifyOtp();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12)
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              child: const Text('Envoyé',
              style: TextStyle(
                fontSize: 20
              ),),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}