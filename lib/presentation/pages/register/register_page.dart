import 'package:code_initial/presentation/pages/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends GetView<RegisterController> {
  @override
  final RegisterController controller =
      Get.put(RegisterController());

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        backgroundColor: Colors.red,
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Test app", style: TextStyle(color: Colors.white),),
        // centerTitle: false,

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
        child: ListView(
          children: [
            Text("data", style: TextStyle(fontSize: 30, color: Colors.green),),
            Text("data", style: TextStyle(fontSize: 30, color: Colors.amberAccent),),
            Text("data", style: TextStyle(fontSize: 30, color: Colors.yellow),),
            Text("data", style: TextStyle(fontSize: 30, color: Colors.red),),
            Text("data", style: TextStyle(fontSize: 30, color: Colors.green),),
            Text("data", style: TextStyle(fontSize: 30, color: Colors.green),),
            Text("data", style: TextStyle(fontSize: 30, color: Colors.amberAccent),),
            Text("data", style: TextStyle(fontSize: 30, color: Colors.yellow),),
            Text("data", style: TextStyle(fontSize: 30, color: Colors.red),),
            Text("data", style: TextStyle(fontSize: 30, color: Colors.green),),
            Text("data", style: TextStyle(fontSize: 30, color: Colors.green),),
            Text("data", style: TextStyle(fontSize: 30, color: Colors.amberAccent),),
            Text("data", style: TextStyle(fontSize: 30, color: Colors.yellow),),
            Text("data", style: TextStyle(fontSize: 30, color: Colors.red),),
            Text("data", style: TextStyle(fontSize: 30, color: Colors.green),),
          ],
        ),
      ),
    );
  }
}
