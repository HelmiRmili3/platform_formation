import 'package:eplatfrom/data/datasources/remote_data_source.dart';
import 'package:eplatfrom/data/repositories/formateur_repository_impl.dart';
import 'package:eplatfrom/domain/repositories/formateur_repository.dart';
import 'package:eplatfrom/domain/usecases/get_user_usecase.dart';
import 'package:eplatfrom/presentation/controllers/formateur_controller.dart';
import 'package:get/get.dart';

import '../../domain/usecases/formateur/add.dart';
import '../../domain/usecases/formateur/delete.dart';
import '../../domain/usecases/formateur/edit.dart';
import '../../domain/usecases/formateur/fetch.dart';

class FormateurBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteDataSource>(() => RemoteDataSourceImpl());
    Get.lazyPut<FormateurRepository>(
        () => FormateurRepositoyImpl(remoteDataSource: Get.find()));
    Get.lazyPut(() => AddFormationUseCase(Get.find()));
    Get.lazyPut(() => FetchFormationsUseCase(Get.find()));
    Get.lazyPut(() => DeleteFormationUseCase(Get.find()));
    Get.lazyPut(() => EditFormationUseCase(Get.find()));
    Get.lazyPut(() => GetUserUseCase(Get.find()));

    Get.lazyPut<FormateurController>(() => FormateurController(
          addFormationUseCase: Get.find(),
          editFormationUseCase: Get.find(),
          deleteFormationUseCase: Get.find(),
          fetchFormationsUseCase: Get.find(),
          getUserUseCase: Get.find(),
        ));
  }
}
