import 'package:eplatfrom/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormateurProfileScreen extends GetView<AuthController> {
  const FormateurProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => controller.signOut(),
        child: const Text("LogOut"),
      ),
    );
  }
}
