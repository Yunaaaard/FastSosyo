import 'package:get/get.dart';
import '../models/brand_category.dart';
import '../models/dashboard_stats.dart';

class DataController extends GetxController {
  final Rx<List<BrandCategory>> _brandCategories = Rx<List<BrandCategory>>([]);
  final Rx<DashboardStats> _dashboardStats = Rx<DashboardStats>(
    DashboardStats.empty(),
  );

  List<BrandCategory> get brandCategories => _brandCategories.value;
  DashboardStats get dashboardStats => _dashboardStats.value;

  DataController({
    List<BrandCategory>? brandCategories,
    DashboardStats? dashboardStats,
  }) {
    _brandCategories.value = brandCategories ?? _defaultBrandCategories;
    _dashboardStats.value = dashboardStats ?? _defaultDashboardStats;
  }

  static const List<BrandCategory> _defaultBrandCategories = [
    BrandCategory(
      brand: 'Nestle',
      image: 'assets/images/z.png',
      logo: 'assets/images/nestle-sample-logo.png',
      amount: '\u20B1 3,000.00',
      count: '12',
    ),
    BrandCategory(
      brand: 'Coffee',
      image: 'assets/images/x.png',
      logo: 'assets/images/monde-sample-logo.png',
      amount: '\u20B1 8,540.75',
      count: '37',
    ),
    BrandCategory(
      brand: 'Milk',
      image: 'assets/images/z.png',
      logo: 'assets/images/nestle-sample-logo.png',
      amount: '\u20B1 1,240.00',
      count: '9',
    ),
    BrandCategory(
      brand: 'Snacks',
      image: 'assets/images/meow_ad.png',
      logo: 'assets/images/nestle-sample-logo.png',
      amount: '\u20B1 12,430.20',
      count: '54',
    ),
    BrandCategory(
      brand: 'Beverages',
      image: 'assets/images/x.png',
      logo: 'assets/images/monde-sample-logo.png',
      amount: '\u20B1 6,980.10',
      count: '28',
    ),
    BrandCategory(
      brand: 'Essentials',
      image: 'assets/images/z.png',
      logo: 'assets/images/nestle-sample-logo.png',
      amount: '\u20B1 2,150.50',
      count: '14',
    ),
  ];

  static const DashboardStats _defaultDashboardStats = DashboardStats(
    totalOrderedValue: '0.00',
    totalProducts: '0 SKU\u2019s',
  );

  void setBrandCategories(List<BrandCategory> categories) {
    _brandCategories.value =
        categories.isEmpty ? [BrandCategory.empty()] : categories;
    _brandCategories.refresh();
  }

  void setDashboardStats(DashboardStats stats) {
    _dashboardStats.value = stats;
    _dashboardStats.refresh();
  }

  void resetAll() {
    _brandCategories.value = [BrandCategory.empty()];
    _dashboardStats.value = DashboardStats.empty();
    _brandCategories.refresh();
    _dashboardStats.refresh();
  }
}
