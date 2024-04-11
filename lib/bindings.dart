import 'package:eplatfrom/presentation/bindings/formation_bindings.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Bindings for formations feature
    FormationBinding().dependencies();
    
    // Bindings for other feature
    
  }
}
