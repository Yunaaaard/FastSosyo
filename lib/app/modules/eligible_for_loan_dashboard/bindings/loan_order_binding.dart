import 'package:get/get.dart';
import '../controller/loan_order_controller.dart';

class LoanOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoanOrderController>(() => LoanOrderController());
  }
}
