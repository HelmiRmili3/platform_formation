import 'package:eplatfrom/data/datasources/remote_data_source.dart';
import 'package:eplatfrom/data/repositories/etudiant_repository_impl.dart';
import 'package:eplatfrom/domain/repositories/etudiant_repository.dart';
import 'package:eplatfrom/domain/usecases/etudiant/etudiant_get_formations_use_case.dart';
import 'package:eplatfrom/domain/usecases/etudiant/etudiant_get_seance_use_case.dart';
import 'package:eplatfrom/domain/usecases/etudiant/etudiant_get_user_use_case.dart';
import 'package:eplatfrom/domain/usecases/etudiant/etudiant_isjoined_formation_use_case.dart';
import 'package:eplatfrom/domain/usecases/etudiant/etudiant_join_formation_usa_case.dart';
import 'package:eplatfrom/presentation/controllers/etudiant_controller.dart';
import 'package:get/get.dart';

class EtudiantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteDataSource>(() => RemoteDataSourceImpl());
    Get.lazyPut<EtudiantRepository>(
        () => EtudiantRepositoryImpl(remoteDataSource: Get.find()));

    Get.lazyPut(() => EtudiantGetUserUseCase(Get.find()));
    Get.lazyPut(() => EtudiantGetSeancesUseCase(Get.find()));
    Get.lazyPut(() => EtudiantGetFormationsUseCase(Get.find()));
    Get.lazyPut(() => EtudiantGetFormationsUseCase(Get.find()));
    Get.lazyPut(() => EtudiantJoinFormationUserUseCase(Get.find()));
    Get.lazyPut(() => EtudiantIsJoinFormationUserUseCase(Get.find()));

    Get.lazyPut<EtudiantController>(() => EtudiantController(
          etudiantIsJoinFormationUserUseCase: Get.find(),
          etudiantJoinFormationUserUseCase: Get.find(),
          etudiantGetFormationsUseCase: Get.find(),
          etudiantGetSeancesUseCase: Get.find(),
          etudiantGetUserUseCase: Get.find(),
          getUserUseCase: Get.find(),
        ));
  }
}
