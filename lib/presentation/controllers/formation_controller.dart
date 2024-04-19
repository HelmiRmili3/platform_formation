import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/domain/usecases/formateur/formation/add.dart';
import 'package:eplatfrom/domain/usecases/formateur/formation/delete.dart';
import 'package:eplatfrom/domain/usecases/formateur/formation/edit.dart';
import 'package:eplatfrom/domain/usecases/formateur/formation/fetch.dart';
import 'package:eplatfrom/presentation/screens/home/formateur/formateur_home_screen.dart';
import 'package:eplatfrom/utils/usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class FormationController extends GetxController {
  final formKey = GlobalKey<FormState>();

  Rx<bool> isLeading = Rx(true);

  final nameController = TextEditingController();
  final formateurController = TextEditingController();
  final descriptionController = TextEditingController();
  final totalHoursController = TextEditingController();

  final AddFormationUseCase addFormationUseCase;
  final EditFormationUseCase editFormationUseCase;
  final DeleteFormationUseCase deleteFormationUseCase;
  final FetchFormationsUseCase fetchFormationsUseCase;

  FormationController({
    required this.addFormationUseCase,
    required this.editFormationUseCase,
    required this.deleteFormationUseCase,
    required this.fetchFormationsUseCase,
  });

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
      Get.offAll(() => const FormateurHomeScreen());
      clear();
      Get.snackbar("Success", "Todo added successfully");
    });
  }

  Rx<List<Formation>> formationsStream = Rx<List<Formation>>([]);

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

  void fetchFormations() {
    fetchFormationsUseCase(NoParams()).then((result) {
      result.fold(
        (failure) {
          Get.snackbar("Error", failure.message);
        },
        (stream) {
          formationsStream.bindStream(stream);
        },
      );
      isLeading.value = false;
    });
  }
}
