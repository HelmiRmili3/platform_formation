import 'package:eplatfrom/presentation/bindings/admin_bindings.dart';
import 'package:eplatfrom/presentation/bindings/auth_bindings.dart';
import 'package:eplatfrom/presentation/bindings/etudiant_bindings.dart';
import 'package:eplatfrom/presentation/bindings/fomateur_bindings.dart';
import 'package:eplatfrom/presentation/bindings/signin_bindings.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    SignInBinding().dependencies();
    AuthBinding().dependencies();
    FormateurBinding().dependencies();
    AdminBinding().dependencies();
    EtudiantBinding().dependencies();
  }
}
