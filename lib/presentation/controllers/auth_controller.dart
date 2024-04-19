import 'dart:io';

import 'package:eplatfrom/domain/usecases/get_user_usecase.dart';
import 'package:eplatfrom/presentation/screens/auth/signin_screen.dart';
import 'package:eplatfrom/presentation/screens/home/admin/admin_home_screen.dart';
import 'package:eplatfrom/presentation/screens/home/etudiant/etudiant_home_screen.dart';
import 'package:eplatfrom/presentation/screens/home/formateur/formateur_home_screen.dart';
import 'package:eplatfrom/utils/enums.dart';
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
  final GetUserUseCase getUserUseCase;

  Rx<User?> user = Rx<User?>(null);
  Rx<File?> selectedImage = Rx<File?>(null);

  void setSelectedImage(File? image) {
    selectedImage.value = image;
  }

  AuthController({
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.forgetPasswordUseCase,
    required this.signInUseCase,
    required this.getUserUseCase,
  });

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
      Get.off(() => const SignInScreen());
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
        _auth.authStateChanges().listen((User? firebaseUser) {
          user.value = firebaseUser;
          if (user.value != null) {
            getUserUseCase.repository
                .getUser(user.value!.uid)
                .then((userModel) {
              return Get.off(() => determineInitialRoute(userModel.role));
            });
          }
        });
      });
    }
  }

  Future<void> signUp() async {
    if (signupFormKey.currentState!.validate()) {
      File? selectedImageFile = selectedImage.value; // Extract the File object

      final results = await signUpUseCase(
          nameController.text.trim(),
          emailController.text.trim(),
          passwordController.text.trim(),
          selectedImageFile!);
      results.fold(
          (l) => Get.snackbar(
                "Error",
                l.message,
                backgroundColor: Colors.redAccent,
              ), (r) {
        if (isAuthenticated) {
          Get.off(() => const SignInScreen());
          clear();
          Get.snackbar("Success", "User Signup successfully");
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

  Widget determineInitialRoute(Role role) {
    switch (role) {
      case Role.admin:
        return const AdminHomeScreen();
      case Role.etudiant:
        return const EtudiantHomeScreen();
      case Role.formateur:
        return const FormateurHomeScreen();

      default:
        return const SignInScreen();
    }
  }
}
