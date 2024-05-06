import 'package:eplatfrom/domain/usecases/get_user_usecase.dart';
import 'package:eplatfrom/domain/usecases/signin_usecase.dart';
import 'package:eplatfrom/presentation/screens/auth/signin_screen.dart';
import 'package:eplatfrom/presentation/screens/home/admin/admin_home_screen.dart';
import 'package:eplatfrom/presentation/screens/home/etudiant/etudiant_home_screen.dart';
import 'package:eplatfrom/presentation/screens/home/formateur/formateur_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/enums.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GetUserUseCase getUserUseCase;
  //final formKey;
  Rx<User?> user = Rx<User?>(null);

  final SignInUseCase signInUseCase;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  SignInController({
    // required this.formKey,
    required this.signInUseCase,
    required this.getUserUseCase,
  });

  bool get isAuthenticated => user.value != null;

  Future<void> signIn() async {
    // if (formKey.currentState!.validate()) {
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
          getUserUseCase.repository.getUser(user.value!.uid).then((userModel) {
            clear();
            return Get.to(() => determineInitialRoute(userModel.role));
          });
        }
      });
    });

    /// }
  }

  void clear() {
    emailController.clear();
    passwordController.clear();
  }

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen((User? firebaseUser) {
      user.value = firebaseUser;
    });
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  Widget determineInitialRoute(Role role) {
    switch (role) {
      case Role.admin:
        return AdminHomeScreen();
      case Role.etudiant:
        return const EtudiantHomeScreen();
      case Role.formateur:
        return const FormateurHomeScreen();
      default:
        return SignInScreen();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
