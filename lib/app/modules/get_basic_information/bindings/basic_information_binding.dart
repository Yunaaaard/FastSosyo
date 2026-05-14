import 'package:get/get.dart';
import '../controller/basic_information_flow_controller.dart';

class BasicInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BasicInformationFlowController>(
      () => BasicInformationFlowController(),
    );
  }
}
