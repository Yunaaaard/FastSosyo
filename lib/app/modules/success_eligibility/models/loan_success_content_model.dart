class LoanSuccessContentModel {
  const LoanSuccessContentModel({
    required this.title,
    required this.subtitle,
    required this.maximumLoanLimit,
    required this.interestRateLabel,
    required this.paymentTermLabel,
    required this.secureBankingTitle,
    required this.secureBankingDescription,
    required this.proceedButtonLabel,
  });

  final String title;
  final String subtitle;
  final double maximumLoanLimit;
  final String interestRateLabel;
  final String paymentTermLabel;
  final String secureBankingTitle;
  final String secureBankingDescription;
  final String proceedButtonLabel;
}
