import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/domain/usecases/formateur/formation/add.dart';
import 'package:eplatfrom/domain/usecases/formateur/formation/delete.dart';
import 'package:eplatfrom/domain/usecases/formateur/formation/edit.dart';
import 'package:eplatfrom/domain/usecases/formateur/formation/fetch.dart';
import 'package:eplatfrom/utils/usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class FormationController extends GetxController {
  final formKey = GlobalKey<FormState>();

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
      //print(failure.message);
      Get.snackbar("Error", failure.message);
    }, (formation) {
      // clear form
      nameController.clear();
      descriptionController.clear();
      Get.snackbar("Success", "Todo added successfully");
    });
  }

  Future<void> deleteFormation(Formation formation) async {
    final results = await deleteFormationUseCase(Params(formation));
    results.fold((failure) {
      Get.snackbar("Error", failure.message);
    }, (formation) {
      Get.snackbar("Success", "Fomation Deleted successfully");
    });
  }

  // Stream of formations
  Rx<List<Formation>> formationsStream = Rx<List<Formation>>([]);

  @override
  void onInit() {
    super.onInit();
    // Fetch formations when the controller initializes
    fetchFormations();
  }

  void fetchFormations() {
    fetchFormationsUseCase(NoParams()).then((result) {
      result.fold(
        (failure) {
          // print(failure.message);
          Get.snackbar("Error", failure.message);
        },
        (stream) {
          // Listen to the stream and update formationsStream
          formationsStream.bindStream(stream);
        },
      );
    });
  }
}
