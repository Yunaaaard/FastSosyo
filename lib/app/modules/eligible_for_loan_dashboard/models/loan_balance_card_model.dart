class LoanBalanceCardModel {
  const LoanBalanceCardModel({
    required this.brandName,
    required this.dateOrdered,
    required this.timeString,
    required this.orderID,
    required this.firstInstallment,
    required this.fullyPaid,
    required this.balance,
  });

  final String brandName;
  final String dateOrdered;
  final String timeString;
  final String orderID;
  final double firstInstallment;
  final double fullyPaid;
  final double balance;
}
