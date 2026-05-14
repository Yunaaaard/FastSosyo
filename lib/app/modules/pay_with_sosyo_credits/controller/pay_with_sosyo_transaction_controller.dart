import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayWithSosyoTransactionController extends GetxController {
  PayWithSosyoTransactionController() {
    amountController = TextEditingController(text: '0');
    amountFocusNode = FocusNode();
  }

  // Reactive UI fields
  final RxString displayText = '0'.obs;
  final RxBool isFocused = false.obs;
  bool _listenersAttached = false;

  @override
  void onInit() {
    super.onInit();
    attachListeners();
  }

  void attachListeners() {
    if (_listenersAttached) {
      return;
    }
    _listenersAttached = true;

    amountFocusNode.addListener(() {
      if (amountFocusNode.hasFocus && amountController.text == '0') {
        amountController.clear();
      }
      if (!amountFocusNode.hasFocus && amountController.text.isEmpty) {
        amountController.text = '0';
      }
      isFocused.value = amountFocusNode.hasFocus;
    });

    amountController.addListener(() {
      displayText.value = amountController.text.isEmpty ? '0' : amountController.text;
    });
  }

  late final TextEditingController amountController;
  late final FocusNode amountFocusNode;

  final RxInt selectedTermMonths = 3.obs;

  // Static constants for calculations
  static const double interestRatePercent = 1.69;
  static const double processingFeePercent = 2.5;
  static const double documentationCharges = 45.0;

  double get orderedAmount =>
      double.tryParse(amountController.text.replaceAll(',', '')) ?? 0;

  bool get hasValidOrderedAmount => orderedAmount > 0;

  // Calculate interest on ordered amount
  double get interestFee => (orderedAmount * interestRatePercent) / 100;

  // Calculate processing fee (2.5% of ordered amount)
  double get processingFee => (orderedAmount * processingFeePercent) / 100;

  // Calculate total repayment = ordered amount + interest + processing fee + documentation
  double get totalRepayment =>
      orderedAmount + interestFee + processingFee + documentationCharges;

  // Calculate monthly payment = total repayment / number of months
  double get monthlyPayment => totalRepayment / selectedTermMonths.value;

  // First month payment (same as monthly for simplicity)
  double get topMonthly => monthlyPayment;

  // Summary monthly payment (same as monthly)
  double get summaryMonthly => monthlyPayment;

  void setSelectedTerm(int months) {
    selectedTermMonths.value = months;
  }

  @override
  void onClose() {
    amountController.dispose();
    amountFocusNode.dispose();
    super.onClose();
  }
}
