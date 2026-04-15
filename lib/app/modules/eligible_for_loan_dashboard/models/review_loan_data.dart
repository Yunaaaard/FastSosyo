class ReviewLoanData {
  const ReviewLoanData({
    required this.monthlyPayment,
    required this.orderedAmount,
    required this.interestRate,
    required this.repaymentTerm,
    required this.processingFee,
    required this.documentationCharges,
    required this.totalRepayment,
    required this.schedule,
  });

  final double monthlyPayment;
  final double orderedAmount;
  final String interestRate;
  final String repaymentTerm;
  final double processingFee;
  final double documentationCharges;
  final double totalRepayment;
  final List<ReviewRepaymentScheduleItem> schedule;
}

class ReviewRepaymentScheduleItem {
  const ReviewRepaymentScheduleItem({
    required this.installment,
    required this.title,
    required this.date,
    required this.amount,
  });

  final String installment;
  final String title;
  final String date;
  final double amount;
}
