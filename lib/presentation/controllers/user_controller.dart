// import 'package:eplatfrom/data/models/user.dart';
// import 'package:eplatfrom/utils/enums.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';

// class UserController extends GetxController {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final GetUserUseCase getUserUseCase;

//   UserController({
//     required this.getUserUseCase,
//   });

//   Rx<Role?> role = Rx<Role?>(null);

//   @override
//   void onInit() {
//     super.onInit();
//     auth.authStateChanges().listen((User? firebaseUser) async {
//       if (firebaseUser != null) {
//         try {
//           UserModel userData = await getUserUseCase.call(firebaseUser.uid);
//           role.value = userData.role;
//         } catch (e) {
//           print("Error fetching user data: $e");
//         }
//       } else {
//         role.value = null;
//       }
//     });
//   }
// }
