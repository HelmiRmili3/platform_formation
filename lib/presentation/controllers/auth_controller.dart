import 'package:eplatfrom/presentation/screens/auth/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/usecases/forget_password_usecase.dart';
import '../../domain/usecases/signin_usecase.dart';
import '../../domain/usecases/signout_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final signinFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  final forgetPasswordFormKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  Rx<User?> user = Rx<User?>(null);

  AuthController({
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.forgetPasswordUseCase,
    required this.signInUseCase,
  });

  // Check if user is authenticated
  bool get isAuthenticated => user.value != null;

  Future<void> signOut() async {
    final results = await signOutUseCase();
    results.fold(
        (l) => Get.snackbar(
              "Error",
              l.message,
              backgroundColor: Colors.redAccent,
            ), (r) {
      Get.snackbar("Success", "User SignOut successfully");
      clear();
    });
  }

  Future<void> signIn() async {
    if (signinFormKey.currentState!.validate()) {
      final results = await signInUseCase(
          emailController.text.trim(), passwordController.text.trim());
      results.fold(
          (l) => Get.snackbar(
                "Error",
                l.message,
                backgroundColor: Colors.redAccent,
              ), (r) {
        if (isAuthenticated) {
          Get.snackbar("Success", "User SignIn successfully");
          clear();
        } else {
          Get.snackbar(
            "Error",
            "user not authenticated",
            backgroundColor: Colors.redAccent,
          );
        }
      });
    }
  }

  Future<void> signUp() async {
    if (signupFormKey.currentState!.validate()) {
      final results = await signUpUseCase(
          emailController.text.trim(), passwordController.text.trim());
      results.fold(
          (l) => Get.snackbar(
                "Error",
                l.message,
                backgroundColor: Colors.redAccent,
              ), (r) {
        if (isAuthenticated) {
          Get.snackbar("Success", "User Signup successfully");
          clear();
          Get.to(() => const SignInScreen());
        } else {
          Get.snackbar(
            "Error",
            "user not authenticated",
            backgroundColor: Colors.redAccent,
          );
        }
      });
    }
  }

  Future<void> forgetPassword() async {
    if (forgetPasswordFormKey.currentState!.validate()) {
      final results = await forgetPasswordUseCase(emailController.text.trim());
      results.fold(
          (l) => Get.snackbar(
                "Error",
                l.message,
                backgroundColor: Colors.redAccent,
              ),
          (r) => Get.snackbar("Success", "Email sended successfully"));
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Listen to authentication state changes
    _auth.authStateChanges().listen((User? firebaseUser) {
      user.value = firebaseUser;
    });
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void clear() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
  }
}
