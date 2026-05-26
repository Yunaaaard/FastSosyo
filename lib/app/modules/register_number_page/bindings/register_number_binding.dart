import 'package:get/get.dart';

import '../controller/register_number_controller.dart';

class RegisterNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterNumberController>(() => RegisterNumberController());
  }
}