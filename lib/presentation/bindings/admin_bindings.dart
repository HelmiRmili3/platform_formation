import 'package:eplatfrom/data/datasources/remote_data_source.dart';
import 'package:eplatfrom/data/repositories/admin_repository_impl.dart';
import 'package:eplatfrom/domain/repositories/admin_repository.dart';
import 'package:eplatfrom/domain/usecases/admin/admin_delete_user_use_case.dart';
import 'package:eplatfrom/domain/usecases/admin/admin_get_formation_archive.dart';
import 'package:eplatfrom/domain/usecases/admin/admin_get_formations_use_case.dart';
import 'package:eplatfrom/domain/usecases/admin/admin_get_user_use_case.dart';
import 'package:eplatfrom/domain/usecases/admin/admin_get_users_use_case.dart';
import 'package:eplatfrom/domain/usecases/get_user_usecase.dart';
import 'package:eplatfrom/presentation/controllers/admin_controller.dart';
import 'package:get/get.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteDataSource>(() => RemoteDataSourceImpl());
    Get.lazyPut<AdminRepository>(
        () => AdminRepositoryImpl(remoteDataSource: Get.find()));

    Get.lazyPut(() => AdminGetUsersUseCase(Get.find()));
    Get.lazyPut(() => AdminGetFormationsUseCase(Get.find()));
    Get.lazyPut(() => AdminGetUserUseCase(Get.find()));
    Get.lazyPut(() => AdminDeleteUserUseCase(Get.find()));
    Get.lazyPut(() => GetUserUseCase(Get.find()));
    Get.lazyPut(() => AdminGetFormationsArchiveUseCase(Get.find()));

    Get.lazyPut<AdminController>(
      () => AdminController(
        adminGetUsersUseCase: Get.find(),
        adminGetFormationsUseCase: Get.find(),
        adminGetUserUseCase: Get.find(),
        adminDeleteUserUseCase: Get.find(),
        getUserUseCase: Get.find(),
        adminGetFormationsArchiveUseCase: Get.find(),
      ),
    );
  }
}
