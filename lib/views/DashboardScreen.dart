import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/brand_category.dart';
import '../models/dashboard_stats.dart';
import '../controllers/data_controller.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DataController dataController = DataController(
    brandCategories: const [
      // Placeholder data for testing hehe
      BrandCategory(
        brand: 'Nestle',
        image: 'assets/images/PlaceHolderCarousel.png',
        logo: 'assets/icons/SosyoLoanButtonIcon.svg',
        amount: '₱ 0.00',
        count: '0',
      ),
    ],
    dashboardStats: const DashboardStats(
      totalOrderedValue: '0.00',
      totalProducts: '0 SKU’s',
    ),
  );

  BrandCategory get currentBrand => dataController.brandCategories.first;
  DashboardStats get stats => dataController.dashboardStats;

  @override
  Widget build(BuildContext context) {
    final BrandCategory brand = currentBrand;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            // Header Image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  brand.image,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Stats Row (merged container with divider and Sosyo Loan button)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Total Ordered Value', style: TextStyle(fontSize: 13, color: Colors.black54)),
                                  SizedBox(height: 4),
                                  Text(
                                    stats.totalOrderedValue,
                                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 48,
                            color: Colors.black12,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Total Products', style: TextStyle(fontSize: 13, color: Colors.black54)),
                                  SizedBox(height: 4),
                                  Text(stats.totalProducts, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Sosyo Loan Card with SVG Icon
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Blue button — icon only
                      Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          color: const Color(0xFF275DCE),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFF1A3D8A),
                              blurRadius: 0,
                              spreadRadius: 0,
                              offset: Offset(3, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/SosyoLoanButtonIcon.svg',
                            height: 28,
                            width: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6), // spacing between button and label
                      // Label below the button
                      const Text(
                        'Sosyo Loan',
                        style: TextStyle(
                          color: Color(0xFF275DCE),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Brand Card (logo, ordered amount, product count only)
            buildBrandCard(brand),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF275DCE),
        unselectedItemColor: Colors.black38,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/HomeIcon.svg',
              height: 20,
              color: Colors.black38,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/HomeIcon.svg',
              height: 23,
              color: const Color(0xFF275DCE),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/LoanIcon.svg',
              height: 20,
              color: Colors.black38,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/LoanIcon.svg',
              height: 23,
              color: const Color(0xFF275DCE),
            ),
            label: 'Loans',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/HistoryIcon.svg',
              height: 20,
              color: Colors.black38,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/HistoryIcon.svg',
              height: 23,
              color: const Color(0xFF275DCE),
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/ProfileIcon.svg',
              height: 20,
              color: Colors.black38,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/ProfileIcon.svg',
              height: 23,
              color: const Color(0xFF275DCE),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget buildBrandCard(BrandCategory brand) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        height: 170,
        child: Stack(
          children: [
            // Background image
            Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                  image: AssetImage(brand.image),
                  fit: BoxFit.cover,
                ),
                boxShadow: const [
                  // Primary shadow — depth
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 16,
                    spreadRadius: 2,
                    offset: Offset(0, 6),
                  ),
                  // Secondary shadow — soft ambient glow
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 30,
                    spreadRadius: 4,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
            ),
            // Gradient overlay at bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.82),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 20,
              bottom: 16,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center, // center vertically
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildBrandLogo(brand.logo),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Labels and values grouped in rows, centered to the logo
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Ordered Amount',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            Text(
                              brand.amount,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Product Count',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            Text(
                              brand.count,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandLogo(String logoPath) {
    if (logoPath.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        logoPath,
        fit: BoxFit.contain,
      );
    } else {
      return Image.asset(
        logoPath,
        fit: BoxFit.contain,
      );
    }
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.0),
      elevation: 0.0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(
            'assets/icons/BurgerDropDown.svg',
            height: 13,
          ),
          const SizedBox(width: 18),
          const Text(
            'FASTSOSYO',
            style: TextStyle(
              color: Color(0xFF275DCE),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/SearchIcon.svg',
              height: 18,
            ),
            onPressed: () {
              // TODO: Implement search action
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/NotificationIcon.svg',
              height: 18,
            ),
            onPressed: () {
              // TODO: Implement notification action
            },
          ),
        ],
      ),
    );
  }
}