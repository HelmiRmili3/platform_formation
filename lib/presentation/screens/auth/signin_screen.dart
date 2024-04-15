import 'package:eplatfrom/presentation/screens/auth/signup_screen.dart';
import 'package:eplatfrom/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class SignInScreen extends GetView<AuthController> {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: controller.signinFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 100),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: Validators.validateEmail,
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: controller.emailController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: Validators.validatePassword,
                    decoration: const InputDecoration(
                      labelText: "Password",
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: controller.passwordController,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => controller.signIn(),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.off(() => const SignUpScreen()),
                    child: const Text(
                      "You don't have account ! signup",
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
