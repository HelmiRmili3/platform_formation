import 'package:eplatfrom/presentation/controllers/auth_controller.dart';
// import 'package:eplatfrom/presentation/controllers/etudiant_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EtudiantProfileScreen extends StatelessWidget {
  EtudiantProfileScreen({super.key});

  final AuthController controller = Get.find<AuthController>();

  // final EtudiantController econtroller = Get.find<EtudiantController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: controller.data.value?.image != null
                    ? NetworkImage(controller.data.value!.image)
                        as ImageProvider<Object>
                    : const NetworkImage(
                        "https://cdn1.iconfinder.com/data/icons/user-pictures/101/malecostume-512.png"),
              ),
              const SizedBox(height: 20),
              Text(
                controller.data.value?.name ?? 'Name not available',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                controller.data.value?.email ?? 'Email not available',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => controller.signOut(),
                child: const Text("Log Out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
