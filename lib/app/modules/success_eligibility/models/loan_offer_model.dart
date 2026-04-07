class LoanOfferModel {
  const LoanOfferModel({
    required this.maximumLoanLimit,
    required this.interestRateLabel,
    required this.paymentTermLabel,
  });

  final double maximumLoanLimit;
  final String interestRateLabel;
  final String paymentTermLabel;
}
