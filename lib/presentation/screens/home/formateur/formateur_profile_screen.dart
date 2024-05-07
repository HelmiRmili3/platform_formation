import 'package:eplatfrom/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormateurProfileScreen extends StatelessWidget {
  FormateurProfileScreen({Key? key}) : super(key: key);

  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Obx(() {
              //   if (controller.userData.value != null) {
              //     return Text(
              //       controller.user.value!.uid,
              //     );
              //   } else {
              //     return CircularProgressIndicator();
              //   }
              // }),
              ElevatedButton(
                onPressed: () => controller.signOut(),
                child: const Text("LogOut"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
