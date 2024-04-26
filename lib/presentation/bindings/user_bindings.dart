// import 'package:eplatfrom/data/datasources/remote_data_source.dart';
// import 'package:eplatfrom/data/repositories/user_repository_impl.dart';
// import 'package:eplatfrom/domain/repositories/user_repository.dart';
// import 'package:eplatfrom/domain/usecases/get_user_usecase.dart';
// import 'package:eplatfrom/presentation/controllers/user_controller.dart';
// import 'package:get/get.dart';

// class UserBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<RemoteDataSource>(() => RemoteDataSourceImpl());
//     Get.lazyPut<UserRepository>(
//         () => UserRepositoryImpl(remoteDataSource: Get.find()));
//     Get.lazyPut(() => GetUserUseCase(Get.find()));
//     Get.lazyPut(() => UserController(
//           getUserUseCase: Get.find(),
//         ));
//   }
// }

