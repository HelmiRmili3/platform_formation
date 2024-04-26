import 'package:eplatfrom/presentation/bindings/auth_bindings.dart';
import 'package:eplatfrom/presentation/bindings/formation_bindings.dart';
import 'package:eplatfrom/presentation/bindings/signin_bindings.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
   // UserBinding().dependencies;
    SignInBinding().dependencies();
    AuthBinding().dependencies();
    FormationBinding().dependencies();
  }
}
