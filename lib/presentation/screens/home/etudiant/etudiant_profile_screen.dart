import 'package:eplatfrom/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EtudiantProfileScreen extends GetView<AuthController> {
  const EtudiantProfileScreen({super.key});

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
