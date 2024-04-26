import 'package:eplatfrom/data/datasources/remote_data_source.dart';
import 'package:eplatfrom/data/repositories/auth_repository_impl.dart';
import 'package:eplatfrom/domain/repositories/auth_repository.dart';
import 'package:eplatfrom/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../../domain/usecases/forget_password_usecase.dart';
import '../../domain/usecases/signout_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteDataSource>(() => RemoteDataSourceImpl());

    Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(remoteDataSource: Get.find()));

    Get.lazyPut(() => SignUpUseCase(Get.find()));
    Get.lazyPut(() => SignOutUseCase(Get.find()));
    Get.lazyPut(() => ForgetPasswordUseCase(Get.find()));

    Get.lazyPut<AuthController>(() => AuthController(
          signUpUseCase: Get.find(),
          signOutUseCase: Get.find(),
          forgetPasswordUseCase: Get.find(),
        ));
  }
}
