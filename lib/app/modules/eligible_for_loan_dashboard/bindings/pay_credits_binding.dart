import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/controller/pay_credits_controller.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/models/loan_order_card_model.dart';
import 'package:get/get.dart';

class PayCreditsBinding extends Bindings {
  @override
  void dependencies() {
    final dynamic args = Get.arguments;
    final LoanOrderCardModel order = args is LoanOrderCardModel
        ? args
        : const LoanOrderCardModel(
            brandName: '',
            brandLogo: '',
            status: '',
            orderedAmount: '0',
            productCount: 0,
            dateOrdered: '',
            orderId: '',
          );

    Get.lazyPut<PayCreditsController>(() => PayCreditsController(order: order));
  }
}