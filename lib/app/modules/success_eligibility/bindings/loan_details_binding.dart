import 'package:get/get.dart';
import '../controller/loan_details_controller.dart';

class LoanDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoanDetailsController>(
      () => LoanDetailsController(
        userFullName: (Get.arguments as String?) ?? '',
      ),
    );
  }
}
