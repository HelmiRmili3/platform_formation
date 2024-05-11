import 'package:eplatfrom/presentation/controllers/signin_controller.dart';
import 'package:eplatfrom/presentation/screens/auth/signup_screen.dart';
import 'package:eplatfrom/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends GetView<SignInController> {
  SignInScreen({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blueAccent, Colors.blue],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Welcome back!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: Validators.validateEmail,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: const TextStyle(color: Colors.white),
                        prefixIcon:
                            const Icon(Icons.email, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      controller: controller.emailController,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: Validators.validatePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(Icons.lock, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      style: const TextStyle(color: Colors.white),
                      controller: controller.passwordController,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          controller.signIn();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: controller.isloading.value
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Get.to(() => SignUpScreen());
                    },
                    child: const Text(
                      "Don't have an account? Sign up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
