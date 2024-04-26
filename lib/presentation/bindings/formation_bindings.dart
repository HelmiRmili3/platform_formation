import 'package:eplatfrom/data/datasources/remote_data_source.dart';
import 'package:eplatfrom/data/repositories/formation_repository_impl.dart';
import 'package:eplatfrom/domain/repositories/formation_repository.dart';
import 'package:eplatfrom/presentation/controllers/formation_controller.dart';
import 'package:get/get.dart';

import '../../domain/usecases/formateur/formation/add.dart';
import '../../domain/usecases/formateur/formation/delete.dart';
import '../../domain/usecases/formateur/formation/edit.dart';
import '../../domain/usecases/formateur/formation/fetch.dart';

class FormationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteDataSource>(() => RemoteDataSourceImpl());
    Get.lazyPut<FormationRepository>(
        () => FormationRepositoyImpl(remoteDataSource: Get.find()));
    Get.lazyPut(() => AddFormationUseCase(Get.find()));
    Get.lazyPut(() => FetchFormationsUseCase(Get.find()));
    Get.lazyPut(() => DeleteFormationUseCase(Get.find()));
    Get.lazyPut(() => EditFormationUseCase(Get.find()));
    Get.lazyPut<FormationController>(() => FormationController(
        addFormationUseCase: Get.find(),
        editFormationUseCase: Get.find(),
        deleteFormationUseCase: Get.find(),
        fetchFormationsUseCase: Get.find()));
  }
}
