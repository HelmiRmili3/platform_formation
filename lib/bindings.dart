import 'package:eplatfrom/presentation/bindings/auth_bindings.dart';
import 'package:eplatfrom/presentation/bindings/formation_bindings.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    FormationBinding().dependencies();
    AuthBinding().dependencies();
  }
}
