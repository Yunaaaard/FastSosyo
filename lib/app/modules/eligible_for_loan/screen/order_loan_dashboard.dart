import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan/controller/loan_order_controller.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan/models/loan_order_card_model.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan/widgets/loan_order_status_chip.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan/screen/pay_with_credits.dart';

class OrderLoanScreen extends StatefulWidget {
  const OrderLoanScreen({super.key});

  @override
  State<OrderLoanScreen> createState() => _OrderLoanScreenState();
}

class _OrderLoanScreenState extends State<OrderLoanScreen> {
  late final LoanOrderController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LoanOrderController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          backgroundColor: const Color(0xFFFFFFFF),
          appBar: appBar(context),
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2F60C8),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'REMAINING SOSYO CREDITS',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFE3EBFA),
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '\u20B1 ',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontFamily: 'Arial',
                                ),
                              ),
                              TextSpan(
                                text: '25,000.00',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Pay with Sosyo Credits',
                                  style: TextStyle(
                                    color: Color(0xFF6A3DE2),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Center(
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  child: SvgPicture.asset(
                                    'assets/icons/loan-order-button-icon.svg',
                                    width: 12,
                                    height: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _controller.selectTopTab(0);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _controller.selectedTopTab == 0
                                      ? const Color(0xFF2F60C8)
                                      : Colors.white,
                                  border: const Border(
                                    right: BorderSide(
                                      color: Color(0xFF2F60C8),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'FAST SOSYO ORDERS',
                                  style: TextStyle(
                                    color: _controller.selectedTopTab == 0
                                        ? Colors.white
                                        : const Color(0xFF5F646B),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _controller.selectTopTab(1);
                              },
                              child: Container(
                                color: _controller.selectedTopTab == 1
                                    ? const Color(0xFF2F60C8)
                                    : Colors.white,
                                alignment: Alignment.center,
                                child: Text(
                                  'FAST SOSYO BALANCE',
                                  style: TextStyle(
                                    color: _controller.selectedTopTab == 1
                                        ? Colors.white
                                        : const Color(0xFF5F646B),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _controller.isOrdersTabSelected
                      ? ListView(
                          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
                          children: [
                            for (final LoanOrderCardModel order
                                in _controller.sampleOrders) ...[
                              _buildOrderCard(order),
                              const SizedBox(height: 14),
                            ],
                          ],
                        )
                      : Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/loan-orders-icon.svg',
                                width: 250,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'No Orders Available',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF9AA0A7),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: navigationBar(),
        );
      },
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFFFFFF),
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Text(
        'SOSYO LOAN',
        style: TextStyle(
          color: Color(0xFF2B5FC2),
          fontWeight: FontWeight.w700,
          fontSize: 46 / 2,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildOrderCard(LoanOrderCardModel order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE3E6EB),
          width: 1.2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(26, 0, 0, 0),
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE1E4E8)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(18, 0, 0, 0),
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    order.brandLogo,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.brandName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF8B8D91),
                      ),
                    ),
                    const SizedBox(height: 8),
                    LoanOrderStatusChip(status: order.status),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return PayCreditsPage(order: order);
                      },
                    ),
                  );
                },
                child: Container(
                  width: 145,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7D3CEB), Color(0xFF6A31DF)],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Use Credits',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Ordered Amount',
                          style: TextStyle(
                            color: Color(0xFF8E9298),
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: '\u20B1 ',
                                style: TextStyle(
                                  color: Color(0xFF2E5DC5),
                                  fontSize: 41 / 2,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Arial',
                                ),
                              ),
                              TextSpan(
                                text: order.orderedAmount,
                                style: const TextStyle(
                                  color: Color(0xFF2E5DC5),
                                  fontSize: 41 / 2,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  color: const Color(0xFFCFD2D8),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Product Count',
                          style: TextStyle(
                            color: Color(0xFF8E9298),
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${order.productCount} SKU\'s',
                          style: const TextStyle(
                            color: Color(0xFF2E5DC5),
                            fontSize: 41 / 2,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Text(
                  order.dateOrdered,
                  style: const TextStyle(
                    color: Color(0xFF8E9298),
                    fontSize: 24 / 2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                order.orderId,
                style: const TextStyle(
                  color: Color(0xFF8E9298),
                  fontSize: 24 / 2,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
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
}
