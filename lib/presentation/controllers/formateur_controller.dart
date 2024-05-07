import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/usecases/formateur/add.dart';
import 'package:eplatfrom/domain/usecases/formateur/delete.dart';
import 'package:eplatfrom/domain/usecases/formateur/edit.dart';
import 'package:eplatfrom/domain/usecases/formateur/fetch.dart';
import 'package:eplatfrom/domain/usecases/get_user_usecase.dart';
import 'package:eplatfrom/presentation/screens/home/formateur/formateur_home_screen.dart';
import 'package:eplatfrom/utils/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class FormateurController extends GetxController {
  Rx<bool> isLeading = Rx(true);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final nameController = TextEditingController();
  final formateurController = TextEditingController();
  final descriptionController = TextEditingController();
  final totalHoursController = TextEditingController();

  final AddFormationUseCase addFormationUseCase;
  final EditFormationUseCase editFormationUseCase;
  final DeleteFormationUseCase deleteFormationUseCase;
  final FetchFormationsUseCase fetchFormationsUseCase;
  final GetUserUseCase getUserUseCase;

  Rx<User?> user = Rx<User?>(null);
  Rx<UserModel?> userData = Rx<UserModel?>(null);

  FormateurController({
    required this.addFormationUseCase,
    required this.editFormationUseCase,
    required this.deleteFormationUseCase,
    required this.fetchFormationsUseCase,
    required this.getUserUseCase,
  });

  Future<void> getUser() async {
    userData.value = await getUserUseCase(user.value!.uid);
  }

  Future<void> addFormation() async {
    final results = await addFormationUseCase(Params(
      Formation(
        id: const Uuid().v1(),
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        formateur: formateurController.text.trim(),
        seances: [],
        releaseDate: DateTime.now(),
        etudiants: [],
        totalHours: DateTime.now(),
      ),
    ));
    results.fold((failure) {
      Get.snackbar("Error", failure.message);
    }, (r) {
      Get.off(() => const FormateurHomeScreen());
      clear();
      Get.snackbar("Success", "Todo added successfully");
    });
  }

  Future<void> deleteFormation(String formationId) async {
    final results = await deleteFormationUseCase(Params(formationId));
    results.fold((failure) {
      Get.snackbar("Error", failure.message);
    }, (r) {
      Get.off(() => const FormateurHomeScreen());
      clear();
      Get.snackbar("Success", "Formation Deleted successfully");
    });
  }

  Future<void> editFormation(Formation formation) async {
    final results = await addFormationUseCase(Params(formation.copyWith(
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
    )));
    results.fold((failure) {
      Get.snackbar("Error", failure.message);
    }, (r) {
      Get.off(() => const FormateurHomeScreen());
      clear();
      Get.snackbar("Success", "Todo added successfully");
    });
  }

  void fetchFormations() {
    fetchFormationsUseCase().listen(
      (List<Formation> result) {
        _formations.assignAll(result);
      },
    );
  }

  final _formations = <Formation>[].obs;
  List<Formation> get formations => _formations;

  @override
  void onInit() {
    super.onInit();
    fetchFormations();
  }

  clear() {
    nameController.clear();
    formateurController.clear();
    descriptionController.clear();
  }
}
