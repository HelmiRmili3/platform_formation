import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/domain/usecases/etudiant/etudiant_get_formations_use_case.dart';
import 'package:eplatfrom/domain/usecases/etudiant/etudiant_get_user_use_case.dart';
import 'package:get/get.dart';

class EtudiantController extends GetxController {
  final EtudiantGetFormationsUseCase etudiantGetFormationsUseCase;
  final EtudiantGetUserUseCase etudiantGetUserUseCase;

  EtudiantController({
    required this.etudiantGetFormationsUseCase,
    required this.etudiantGetUserUseCase,
  });

  final _formations = <Formation>[].obs;
  List<Formation> get formations => _formations;

  @override
  void onInit() {
    super.onInit();
    fetchFormations();
  }

  void fetchFormations() {
    etudiantGetFormationsUseCase().listen(
      (List<Formation> result) {
        _formations.assignAll(result);
      },
    );
  }
}
