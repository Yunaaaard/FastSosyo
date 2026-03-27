import '../models/brand_category.dart';
import '../models/dashboard_stats.dart';

class DataController {
  List<BrandCategory> brandCategories;
  DashboardStats dashboardStats;

  DataController({
    List<BrandCategory>? brandCategories,
    DashboardStats? dashboardStats,
  })  : brandCategories = brandCategories ?? [BrandCategory.empty()],
        dashboardStats = dashboardStats ?? DashboardStats.empty();

  void setBrandCategories(List<BrandCategory> categories) {
    brandCategories = categories.isEmpty ? [BrandCategory.empty()] : categories;
  }

  void setDashboardStats(DashboardStats stats) {
    dashboardStats = stats;
  }

  void resetAll() {
    brandCategories = [BrandCategory.empty()];
    dashboardStats = DashboardStats.empty();
  }
}
