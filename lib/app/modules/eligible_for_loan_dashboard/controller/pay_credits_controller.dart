import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/models/loan_order_card_model.dart';
import 'package:get/get.dart';

class PayCreditsController extends GetxController {
  PayCreditsController({required this.order});

  final LoanOrderCardModel order;

  final RxInt selectedTermMonths = 3.obs;

  static const Map<int, double> topMonthlyByTerm = <int, double>{
    3: 370.00,
    6: 328.50,
    12: 307.02,
  };

  static const Map<int, double> totalRepaymentByTerm = <int, double>{
    3: 1834.08,
    6: 1971.00,
    12: 2248.24,
  };

  static const Map<int, double> summaryMonthlyByTerm = <int, double>{
    3: 307.02,
    6: 328.50,
    12: 187.35,
  };

  double get topMonthly => topMonthlyByTerm[selectedTermMonths.value] ?? 0;

  double get totalRepayment => totalRepaymentByTerm[selectedTermMonths.value] ?? 0;

  double get summaryMonthly => summaryMonthlyByTerm[selectedTermMonths.value] ?? 0;

  void setSelectedTerm(int months) {
    selectedTermMonths.value = months;
  }

  double parseAmount(String value) {
    return double.tryParse(value.replaceAll(',', '')) ?? 0;
  }

  String formatTimeString(DateTime dateTime) {
    final String hour = dateTime.hour.toString().padLeft(2, '0');
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}