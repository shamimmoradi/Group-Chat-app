import 'package:get/get.dart';

import '../controllers/login_controller.dart';
// will init all the dependencies that we defined in it like Logincontroller
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}