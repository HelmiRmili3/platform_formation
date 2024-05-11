import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/data/models/seance.dart';
import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/usecases/etudiant/etudiant_get_formations_use_case.dart';
import 'package:eplatfrom/domain/usecases/etudiant/etudiant_get_seance_use_case.dart';
import 'package:eplatfrom/domain/usecases/etudiant/etudiant_get_user_use_case.dart';
import 'package:eplatfrom/domain/usecases/etudiant/etudiant_isjoined_formation_use_case.dart';
import 'package:eplatfrom/domain/usecases/etudiant/etudiant_join_formation_usa_case.dart';
import 'package:eplatfrom/presentation/screens/home/etudiant/etudiant_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/usecases/get_user_usecase.dart';

class EtudiantController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final EtudiantGetFormationsUseCase etudiantGetFormationsUseCase;
  final EtudiantGetUserUseCase etudiantGetUserUseCase;
  final EtudiantGetSeancesUseCase etudiantGetSeancesUseCase;
  final EtudiantJoinFormationUserUseCase etudiantJoinFormationUserUseCase;
  final EtudiantIsJoinFormationUserUseCase etudiantIsJoinFormationUserUseCase;
  final GetUserUseCase getUserUseCase;
  EtudiantController({
    required this.etudiantGetFormationsUseCase,
    required this.etudiantGetSeancesUseCase,
    required this.etudiantGetUserUseCase,
    required this.etudiantJoinFormationUserUseCase,
    required this.etudiantIsJoinFormationUserUseCase,
    required this.getUserUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen((User? firebaseUser) {
      user.value = firebaseUser;
    });
    fetchFormations();
    getUser();
  }

  final _formations = <Formation>[].obs;
  List<Formation> get formations => _formations;

  final _seances = <Seance>[].obs;
  RxList<Seance> get seances => _seances;

  Rx<User?> user = Rx<User?>(null);
  Rx<UserModel?> data = Rx<UserModel?>(null);
  RxBool isJoined = false.obs;

  Future<void> getUser() async {
    if (user.value != null) {
      String userId = user.value!.uid;
      data.value = await getUserUseCase(userId);
    }
  }

  Future<void> isJoin(String formationId) async {
    UserModel userdata = await getUserUseCase(user.value!.uid);
    debugPrint(userdata.toString());
    isJoined.value =
        await etudiantIsJoinFormationUserUseCase(formationId, userdata.id);
    debugPrint(isJoined.value.toString());
  }

  Future<void> joinFormation(String formationId) async {
    UserModel userdata = await getUserUseCase(user.value!.uid);
    await etudiantJoinFormationUserUseCase(formationId, userdata);
    Get.to(() => const EtudiantHomeScreen());
  }

  Future<void> getSeances(String formationId) async {
    final result = await etudiantGetSeancesUseCase(formationId);
    _seances.assignAll(result);
  }

  void fetchFormations() {
    etudiantGetFormationsUseCase().listen(
      (List<Formation> result) {
        _formations.assignAll(result);
      },
    );
  }
}
