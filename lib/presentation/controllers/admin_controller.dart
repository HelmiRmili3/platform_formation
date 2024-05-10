import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/usecases/admin/admin_delete_user_use_case.dart';
import 'package:eplatfrom/domain/usecases/admin/admin_get_formations_use_case.dart';
import 'package:eplatfrom/domain/usecases/admin/admin_get_user_use_case.dart';
import 'package:eplatfrom/domain/usecases/admin/admin_get_users_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/usecases/get_user_usecase.dart';

class AdminController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final AdminGetUsersUseCase adminGetUsersUseCase;
  final AdminGetFormationsUseCase adminGetFormationsUseCase;
  final AdminGetUserUseCase adminGetUserUseCase;
  final AdminDeleteUserUseCase adminDeleteUserUseCase;
  final GetUserUseCase getUserUseCase;
  AdminController({
    required this.adminGetUsersUseCase,
    required this.adminGetFormationsUseCase,
    required this.adminGetUserUseCase,
    required this.adminDeleteUserUseCase,
    required this.getUserUseCase,
  });

  final _users = <UserModel>[].obs;
  List<UserModel> get users => _users;

  final _formations = <Formation>[].obs;
  List<Formation> get formations => _formations;

  Rx<User?> user = Rx<User?>(null);
  Rx<UserModel?> data = Rx<UserModel?>(null);

  void fetchUsers() {
    adminGetUsersUseCase().listen((List<UserModel> result) {
      _users.assignAll(result);
      debugPrint(result.toString());
    });
  }

  void fetchFormations() {
    adminGetFormationsUseCase().listen((List<Formation> result) {
      _formations.assignAll(result);
      debugPrint(result.toString());
    });
  }

  Future<void> deleteUser(String userId) async =>
      adminDeleteUserUseCase(userId);

  Future<void> getUser() async {
    if (user.value != null) {
      String userId = user.value!.uid;
      data.value = await getUserUseCase(userId);
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen((User? firebaseUser) {
      user.value = firebaseUser;
      // debugPrint("#######################${userData.value!.email}");
    });
    fetchFormations();
    fetchUsers();
    getUser();
  }
}
