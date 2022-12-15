import 'package:get/instance_manager.dart';
import 'package:grocery_list/src/home/controllers/home_controller.dart';

import 'src/core/auth/controllers/auth_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => AuthController());
  }
}
