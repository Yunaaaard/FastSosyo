import 'package:get/get.dart';
import '../controller/pay_sosyo_credits_controller.dart';
import '../controller/pay_with_sosyo_transaction_controller.dart';

class PaySosyoCreditsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaySosyoCreditsController>(() => PaySosyoCreditsController());
    Get.lazyPut<PayWithSosyoTransactionController>(
      () => PayWithSosyoTransactionController(),
    );
  }
}
