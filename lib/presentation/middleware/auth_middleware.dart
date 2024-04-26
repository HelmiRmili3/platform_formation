
import 'package:eplatfrom/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMiddleware extends GetMiddleware {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  RouteSettings redirect(String? route) {
    _redirectToRolePage(Role.admin);
    return const RouteSettings(name: "/");
  }

  Future<void> _redirectToRolePage(Role role) async {
    switch (role) {
      case Role.admin:
        return Get.off('/admin');
      case Role.etudiant:
        return Get.off('/etudiant');
      case Role.formateur:
        return Get.off('/formateur');
    }
  }
}
