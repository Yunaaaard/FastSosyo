import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fast_sosyo/app/modules/success_eligibility/models/loan_breakdown_item_model.dart';
import 'package:fast_sosyo/app/modules/success_eligibility/models/loan_offer_model.dart';

class LoanDetailsController extends GetxController {
  LoanDetailsController({required this.userFullName});

  final String userFullName;

  final RxBool _contractSigned = false.obs;
  final Rx<String?> _generatedAgreementPath = Rx<String?>(null);

  final LoanOfferModel loanOffer = const LoanOfferModel(
    maximumLoanLimit: 25000,
    interestRateLabel: '1.59% /mo',
    paymentTermLabel: '12 Months',
  );

  final List<LoanBreakdownItemModel> breakdownItems =
      const <LoanBreakdownItemModel>[
    LoanBreakdownItemModel(
      label: 'Annual Interest Rate (APR)',
      value: '11.49%',
    ),
    LoanBreakdownItemModel(
      label: 'Processing Fee (2.5%)',
      value: '312.50',
      hasPeso: true,
    ),
    LoanBreakdownItemModel(
      label: 'Documentation Charges',
      value: '45.00',
      hasPeso: true,
    ),
    LoanBreakdownItemModel(
      label: 'Total Repayment',
      value: '26,574.08',
      hasPeso: true,
      isBold: true,
      valueColor: Color(0xFF2563EB),
    ),
  ];

  bool get contractSigned => _contractSigned.value;
  String? get generatedAgreementPath => _generatedAgreementPath.value;

  String get resolvedUserFullName {
    final String fullName = userFullName.trim();
    return fullName.isEmpty ? 'Customer Name' : fullName;
  }

  void setAgreementGenerated(String path) {
    _contractSigned.value = true;
    _generatedAgreementPath.value = path;
  }
}
