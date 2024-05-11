import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/data/models/seance.dart';
import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/usecases/formateur/add.dart';
import 'package:eplatfrom/domain/usecases/formateur/addseance.dart';
import 'package:eplatfrom/domain/usecases/formateur/delete.dart';
import 'package:eplatfrom/domain/usecases/formateur/edit.dart';
import 'package:eplatfrom/domain/usecases/formateur/fetch.dart';
import 'package:eplatfrom/domain/usecases/formateur/get_etudiants_of_formation.dart';
import 'package:eplatfrom/domain/usecases/formateur/get_seances.dart';
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
  final FetchEtudiantOfFormationUseCase fetchEtudiantOfFormationUseCase;
  final FetchFormationsUseCase fetchFormationsUseCase;
  final AddSeanceUserUseCase addSeanceUserUseCase;
  final FetchSeancessUseCase fetchSeancessUseCase;
  final GetUserUseCase getUserUseCase;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Rx<User?> user = Rx<User?>(null);
  Rx<UserModel?> data = Rx<UserModel?>(null);

  FormateurController({
    required this.fetchEtudiantOfFormationUseCase,
    required this.addFormationUseCase,
    required this.editFormationUseCase,
    required this.deleteFormationUseCase,
    required this.fetchFormationsUseCase,
    required this.addSeanceUserUseCase,
    required this.fetchSeancessUseCase,
    required this.getUserUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen((User? firebaseUser) {
      user.value = firebaseUser;
    });
    fetchFormations();
    // getUser();
  }

  final _formations = <Formation>[].obs;
  List<Formation> get formations => _formations;

  Future<void> addSeance(String formationId) async {
    Seance seance =
        Seance(date: selectedDate, time: selectedTime, salle: "A2", period: 1);
    await addSeanceUserUseCase(formationId, seance);
  }

  Future<void> addFormation() async {
    final results = await addFormationUseCase(Params(
      Formation(
        id: const Uuid().v1(),
        formateurId: user.value!.uid,
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

  void fetchFormations() async {
    fetchFormationsUseCase().listen((List<Formation> result) {
      List<Formation> userFormations = result
          .where((formation) => formation.formateurId == user.value!.uid)
          .toList();
      _formations.assignAll(userFormations);
    });
  }

  Future<List<Seance>> fetchSeances(String formationId) async {
    List<Seance> seancesList = await fetchSeancessUseCase(formationId);
    return seancesList;
  }

  Future<List<UserModel>> fetchEtudiantsList(String formationId) async {
    List<UserModel> list = await fetchEtudiantOfFormationUseCase(formationId);
    return list;
  }

  clear() {
    nameController.clear();
    formateurController.clear();
    descriptionController.clear();
  }
}
