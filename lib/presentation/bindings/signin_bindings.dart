import 'package:eplatfrom/data/datasources/remote_data_source.dart';
import 'package:eplatfrom/data/repositories/signin_repository_impl.dart';
import 'package:eplatfrom/domain/repositories/signin_repository.dart';
import 'package:eplatfrom/domain/usecases/get_user_usecase.dart';
import 'package:eplatfrom/domain/usecases/signin_usecase.dart';
import 'package:eplatfrom/presentation/controllers/signin_controller.dart';
import 'package:get/get.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteDataSource>(() => RemoteDataSourceImpl());
    Get.lazyPut<SignInRepository>(
        () => SignInRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut<SignInUseCase>(() => SignInUseCase(Get.find()));
    Get.lazyPut<GetUserUseCase>(() => GetUserUseCase(Get.find()));
    
    Get.lazyPut<SignInController>(() => SignInController(
          signInUseCase: Get.find(),
          getUserUseCase: Get.find(),
        ));
  }
}
