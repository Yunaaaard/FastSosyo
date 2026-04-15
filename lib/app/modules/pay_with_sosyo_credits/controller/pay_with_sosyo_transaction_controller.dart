import 'package:flutter/material.dart';

class PayWithSosyoTransactionController {
  PayWithSosyoTransactionController()
      : amountController = TextEditingController(text: '0'),
        amountFocusNode = FocusNode();

  final TextEditingController amountController;
  final FocusNode amountFocusNode;

  int selectedTermMonths = 3;

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
  double get monthlyPayment => totalRepayment / selectedTermMonths;

  // First month payment (same as monthly for simplicity)
  double get topMonthly => monthlyPayment;

  // Summary monthly payment (same as monthly)
  double get summaryMonthly => monthlyPayment;

  void setSelectedTerm(int months) {
    selectedTermMonths = months;
  }

  void dispose() {
    amountController.dispose();
    amountFocusNode.dispose();
  }
}
