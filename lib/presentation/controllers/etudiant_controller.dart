import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/usecases/etudiant/etudiant_get_formations_use_case.dart';
import 'package:eplatfrom/domain/usecases/etudiant/etudiant_get_user_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../domain/usecases/get_user_usecase.dart';

class EtudiantController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final EtudiantGetFormationsUseCase etudiantGetFormationsUseCase;
  final EtudiantGetUserUseCase etudiantGetUserUseCase;
  final GetUserUseCase getUserUseCase;
  EtudiantController({
    required this.etudiantGetFormationsUseCase,
    required this.etudiantGetUserUseCase,
    required this.getUserUseCase,
  });

  final _formations = <Formation>[].obs;
  List<Formation> get formations => _formations;
  Rx<User?> user = Rx<User?>(null);

  Rx<UserModel?> data = Rx<UserModel?>(null);

  Future<void> getUser() async {
    if (user.value != null) {
      String userId = user.value!.uid;
      data.value = await getUserUseCase(userId);
    }
    update();
  }

  void fetchFormations() {
    etudiantGetFormationsUseCase().listen(
      (List<Formation> result) {
        _formations.assignAll(result);
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen((User? firebaseUser) {
      user.value = firebaseUser;
    });
    fetchFormations();
    getUser();
  }
}
