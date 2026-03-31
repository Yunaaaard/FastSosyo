class DashboardStats {
  final String totalOrderedValue;
  final String totalProducts;

  const DashboardStats({
    required this.totalOrderedValue,
    required this.totalProducts,
  });

  factory DashboardStats.empty() {
    return const DashboardStats(
      totalOrderedValue: '0.00',
      totalProducts: '0',
    );
  }
}
