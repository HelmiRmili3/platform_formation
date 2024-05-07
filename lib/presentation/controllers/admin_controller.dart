import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/usecases/admin/admin_delete_user_use_case.dart';
import 'package:eplatfrom/domain/usecases/admin/admin_get_formations_use_case.dart';
import 'package:eplatfrom/domain/usecases/admin/admin_get_user_use_case.dart';
import 'package:eplatfrom/domain/usecases/admin/admin_get_users_use_case.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  final AdminGetUsersUseCase adminGetUsersUseCase;
  final AdminGetFormationsUseCase adminGetFormationsUseCase;
  final AdminGetUserUseCase adminGetUserUseCase;
  final AdminDeleteUserUseCase adminDeleteUserUseCase;
  AdminController({
    required this.adminGetUsersUseCase,
    required this.adminGetFormationsUseCase,
    required this.adminGetUserUseCase,
    required this.adminDeleteUserUseCase,
  });

  final _users = <UserModel>[].obs;
  List<UserModel> get users => _users;

  final _formations = <Formation>[].obs;
  List<Formation> get formations => _formations;

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

  @override
  void onInit() {
    super.onInit();
    fetchFormations();
    fetchUsers();
  }
}
