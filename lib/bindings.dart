import 'package:eplatfrom/presentation/controllers/formation_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(FormationController(
        addFormationUseCase: Get.find(),
        editFormationUseCase: Get.find(),
        deleteFormationUseCase: Get.find(),
        fetchFormationsUseCase: Get.find()));
  }
}
