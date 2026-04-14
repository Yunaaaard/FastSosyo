class LoanOrderCardModel {
  const LoanOrderCardModel({
    required this.brandName,
    required this.brandLogo,
    required this.status,
    required this.orderedAmount,
    required this.productCount,
    required this.dateOrdered,
    required this.orderId,
  });

  final String brandName;
  final String brandLogo;
  final String status;
  final String orderedAmount;
  final int productCount;
  final String dateOrdered;
  final String orderId;
}
