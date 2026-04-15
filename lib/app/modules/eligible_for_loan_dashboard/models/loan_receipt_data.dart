class LoanReceiptData {
  const LoanReceiptData({
    required this.from,
    required this.to,
    required this.referenceNo,
    required this.dateTime,
    required this.amountSent,
    this.title = 'Thank you!',
    this.subtitle = 'Your payment has been sent\nsuccessfully',
    this.backButtonLabel = 'Back to Home',
  });

  final String from;
  final String to;
  final String referenceNo;
  final String dateTime;
  final double amountSent;
  final String title;
  final String subtitle;
  final String backButtonLabel;
}
