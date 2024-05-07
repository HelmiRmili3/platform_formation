import 'dart:io';

import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/usecases/get_user_usecase.dart';
import 'package:eplatfrom/presentation/screens/auth/signin_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/usecases/forget_password_usecase.dart';
import '../../domain/usecases/signout_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final GetUserUseCase getUserUseCase;
  Rx<User?> user = Rx<User?>(null);
  Rx<File?> selectedImage = Rx<File?>(null);

  final userData = Rx<UserModel?>(null);

  void setSelectedImage(File? image) {
    selectedImage.value = image;
  }

  AuthController({
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.forgetPasswordUseCase,
    required this.getUserUseCase,
  });

  bool get isAuthenticated => user.value != null;

  Future<void> getUser() async {
    userData.value = await getUserUseCase(user.value!.uid);
  }

  Future<void> signOut() async {
    final results = await signOutUseCase();
    results.fold(
      (l) => Get.snackbar(
        "Error",
        l.message,
        backgroundColor: Colors.redAccent,
      ),
      (r) {
        Get.snackbar("Success", "User SignOut successfully");
        Get.to(() => SignInScreen());
      },
    );
  }

  Future<void> signUp() async {
    // if (signUpFormKey.currentState!.validate()) {
    // GET THE IMAGE FROM RX<FILE?> TO FILE?
    File? selectedImageFile = selectedImage.value;

    final results = await signUpUseCase(
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
      selectedImageFile!,
    );
    results.fold(
      (l) => Get.snackbar(
        "Error",
        l.message,
        backgroundColor: Colors.redAccent,
      ),
      (r) {
        if (isAuthenticated) {
          Get.snackbar("Success", "User Signup successfully");
        } else {
          Get.snackbar(
            "Error",
            "User not authenticated",
            backgroundColor: Colors.redAccent,
          );
        }
      },
    );
    //  }
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
