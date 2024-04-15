import 'package:eplatfrom/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<AuthController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Center(
            child: ElevatedButton(
              onPressed: () => controller.signOut(),
              child: const Text("LogOut"),
            ),
          ),
      ),
    );
  }
}
