import 'dart:async';
import 'package:fast_sosyo/app/modules/check_eligibility/check_eligibility_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/brand_category.dart';
import '../models/dashboard_stats.dart';
import '../controllers/dashboard_controller.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}


class _DashboardPageState extends State<DashboardPage> {
  final DataController dataController = DataController(
    brandCategories: const [
      // Sample data for brand categories
      BrandCategory(
        brand: 'Nestle',
        image: 'assets/images/z.png',
        logo: 'assets/images/nestle-sample-logo.png',
        amount: '₱ 3,000.00',
        count: '12',
      ),
      BrandCategory(
        brand: 'Coffee',
        image: 'assets/images/x.png',
        logo: 'assets/images/monde-sample-logo.png',
        amount: '₱ 8,540.75',
        count: '37',
      ),
      BrandCategory(
        brand: 'Milk',
        image: 'assets/images/z.png',
        logo: 'assets/images/nestle-sample-logo.png',
        amount: '₱ 1,240.00',
        count: '9',
      ),
      BrandCategory(
        brand: 'Snacks',
        image: 'assets/images/meow_ad.png',
        logo: 'assets/images/nestle-sample-logo.png',
        amount: '₱ 12,430.20',
        count: '54',
      ),
      BrandCategory(
        brand: 'Beverages',
        image: 'assets/images/x.png',
        logo: 'assets/images/monde-sample-logo.png',
        amount: '₱ 6,980.10',
        count: '28',
      ),
      BrandCategory(
        brand: 'Essentials',
        image: 'assets/images/z.png',
        logo: 'assets/images/nestle-sample-logo.png',
        amount: '₱ 2,150.50',
        count: '14',
      ),
    ],
    dashboardStats: const DashboardStats(
      totalOrderedValue: '0.00',
      totalProducts: '0 SKU’s',
    ),
  );

  // Advertisement images for carousel (separate from brand categories)
  final List<String> _adImages = [
    'assets/images/x.png',
    'assets/images/y.png',
    'assets/images/z.png',
    // Add more ad images as needed
  ];

  final PageController _pageController = PageController(viewportFraction: 1.0);
  int _currentPage = 0;
  late final DashboardStats stats;
  late final List<BrandCategory> brandCategories;
  late final Timer _carouselTimer;

  @override
  void initState() {
    super.initState();
    brandCategories = dataController.brandCategories;
    stats = dataController.dashboardStats;
    _carouselTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_adImages.length <= 1) return;
      int nextPage = (_currentPage + 1) % _adImages.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _carouselTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 75),
            // Advertisement Carousel inside Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 160,
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
                child: Stack(
                  children: [
                    // Carousel
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: SizedBox(
                        height: 160,
                        width: double.infinity,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: _adImages.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            final imagePath = _adImages[index];
                            return Image.asset(
                              imagePath,
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    // Carousel indicators (overlayed at bottom center)
                    if (_adImages.length > 1)
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(_adImages.length, (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              width: _currentPage == index ? 18 : 7,
                              height: 7,
                              decoration: BoxDecoration(
                                color: _currentPage == index ? const Color(0xFF275DCE) : Colors.black26,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            );
                          }),
                        ),
                      ),
                  ],
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
                                  _pesoText(
                                    stats.totalOrderedValue,
                                    amountStyle: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                    ),
                                    symbolStyle: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                              padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Total Products', style: TextStyle(fontSize: 13, color: Colors.black54)),
                                  SizedBox(height: 4),
                                  Text(stats.totalProducts, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Sosyo Loan Card with SVG Icon (Clickable)
                  StatefulBuilder(
                    builder: (context, setLocalState) {
                      bool isPressed = false;
                      return Listener(
                        onPointerDown: (_) => setLocalState(() => isPressed = true),
                        onPointerUp: (_) => setLocalState(() => isPressed = false),
                        onPointerCancel: (_) => setLocalState(() => isPressed = false),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          splashColor: const Color(0xFF1A3D8A).withOpacity(0.2),
                          highlightColor: const Color(0xFF1A3D8A).withOpacity(0.1),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const CheckEligibilityPage(),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Blue button — icon only
                              Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF275DCE),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: isPressed
                                      ? []
                                      : const [
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
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // Title header for brand categories
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'BRAND CATEGORIES',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF64748B),
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 3),
            // Brand cards list for scroll testing
            ...dataController.brandCategories.map(buildBrandCard),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: navigationBar(),
    );
  }

  BottomNavigationBar navigationBar() {
    return BottomNavigationBar(
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
    );
  }

  Widget buildBrandCard(BrandCategory brand) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        height: 170,
        child: Stack(
          children: [
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
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 16,
                    spreadRadius: 2,
                    offset: Offset(0, 6),
                  ),
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 30,
                    spreadRadius: 4,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.38),
                      Colors.black.withOpacity(0.55),
                      Colors.black.withOpacity(0.92),
                    ],
                    stops: const [0.0, 0.4, 0.5, 1.0],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 20,
              bottom: 16,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _buildBrandLogo(brand.logo),
                    ),
                  ),
                  const SizedBox(width: 12),
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
                            _pesoText(
                              brand.amount,
                              amountStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                              ),
                              symbolStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
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

  String _cleanPesoValue(String value) {
    final String clean = value.trim().replaceAll('₱', '').trim();
    return clean;
  }

  Widget _pesoText(
    String value, {
    required TextStyle amountStyle,
    required TextStyle symbolStyle,
  }) {
    final String clean = _cleanPesoValue(value);
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: '₱ ', style: symbolStyle),
          TextSpan(text: clean, style: amountStyle),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
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
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/SearchIcon.svg',
              height: 22,
            ),
            onPressed: () {
              // TODO: Implement search action
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/NotificationIcon.svg',
              height: 22,
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