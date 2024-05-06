import 'package:eplatfrom/data/datasources/remote_data_source.dart';
import 'package:eplatfrom/data/repositories/etudiant_repository_impl.dart';
import 'package:eplatfrom/domain/repositories/etudiant_repository.dart';
import 'package:eplatfrom/domain/usecases/etudiant/etudiant_get_formations_use_case.dart';
import 'package:eplatfrom/domain/usecases/etudiant/etudiant_get_user_use_case.dart';
import 'package:eplatfrom/presentation/controllers/etudiant_controller.dart';
import 'package:get/get.dart';

class EtudiantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteDataSource>(() => RemoteDataSourceImpl());
    Get.lazyPut<EtudiantRepository>(
        () => EtudiantRepositoryImpl(remoteDataSource: Get.find()));

    Get.lazyPut(() => EtudiantGetUserUseCase(Get.find()));
    Get.lazyPut(() => EtudiantGetFormationsUseCase(Get.find()));

    Get.lazyPut<EtudiantController>(() => EtudiantController(
          etudiantGetFormationsUseCase: Get.find(),
          etudiantGetUserUseCase: Get.find(),
        ));
  }
}
