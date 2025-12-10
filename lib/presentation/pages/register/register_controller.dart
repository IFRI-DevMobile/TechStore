import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {

  RegisterController();

  final fullnameController = TextEditingController();


  /// === VALIDATIONS === ///
  String? validateEmail(String? value) {
    if (!GetUtils.isEmail(value!)) {
      return "Email invalide";
    }
    return null;
  }


  /// === ACTIONS === ///
  Future<void> signUp() async {

  }

}

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}
