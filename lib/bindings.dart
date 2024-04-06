
import 'package:get/get_instance/src/bindings_interface.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    //Get.lazyPut<TodoController>(() => TodoController(TodoRepositoryImpl()));
    // Add bindings for other controllers and repositories here
  }
}