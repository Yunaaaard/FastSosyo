import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/controller/loan_order_controller.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/models/loan_balance_card_model.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/models/loan_order_card_model.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/models/transaction_model.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/widgets/loan_order_status_chip.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/screen/pay_with_credits.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/screen/remaining_balance_summary.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/services/loan_balance_service.dart';
import 'package:fast_sosyo/app/modules/pay_with_sosyo_credits/screens/pay_sosyo_credits.dart';

class OrderLoanScreen extends StatefulWidget {
  const OrderLoanScreen({super.key});

  @override
  State<OrderLoanScreen> createState() => _OrderLoanScreenState();
}

class _OrderLoanScreenState extends State<OrderLoanScreen> {
  late final LoanOrderController _controller;
  late final LoanBalanceService _balanceService;

  @override
  void initState() {
    super.initState();
    _controller = LoanOrderController();
    _balanceService = LoanBalanceService.instance;
    _balanceService.addListener(_onBalanceChanged);
  }

  @override
  void dispose() {
    _balanceService.removeListener(_onBalanceChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onBalanceChanged() {
    final int? requestedTab = _balanceService.consumeRequestedTopTab();
    if (requestedTab != null) {
      _controller.selectTopTab(requestedTab);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        final List<LoanBalanceCardModel> balances =
            _balanceService.confirmedBalances;
        final List<TransactionModel> recentTransactions =
            TransactionModel.getSampleTransactions();

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
                              child: SizedBox(
                                height: 60,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFFFFF),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) {
                                          return const PaySosyoCreditsScreen();
                                        },
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Pay with Sosyo Credits',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF6A3DE2),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
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
                      : balances.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/order-balance-icon.svg',
                                    width: 200,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(height: 24),
                                  const Text(
                                    'No Balance Available',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF9AA0A7),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 14, 20, 24),
                              children: [
                                for (final LoanBalanceCardModel balance
                                    in balances) ...[
                                  _buildBalanceCard(balance),
                                  const SizedBox(height: 14),
                                ],
                                const SizedBox(height: 2),
                                _buildRecentTransactionsHeader(),
                                const SizedBox(height: 16),
                                for (final TransactionModel transaction
                                    in recentTransactions) ...[
                                  _buildRecentTransactionCard(transaction),
                                ],
                              ],
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
                padding: const EdgeInsets.all(6),
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
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF8B5CF6),
                        Color(0xFF7C3AED),
                        Color(0xFF5B21B6),
                      ],
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(38, 91, 33, 182),
                        blurRadius: 14,
                        offset: Offset(0, 6),
                      ),
                    ],
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

  Widget _buildBalanceCard(LoanBalanceCardModel loan) {
    final double progress = loan.fullyPaid <= 0
        ? 0
        : (loan.firstInstallment / loan.fullyPaid).clamp(0.0, 1.0);
    final int progressPercent = (progress * 100).round();

    return Dismissible(
      key: ValueKey(loan.orderID),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444),
          borderRadius: BorderRadius.circular(24),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 28,
        ),
      ),
      onDismissed: (direction) {
        _balanceService.removeConfirmedLoan(loan.orderID);
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(20, 0, 0, 0),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loan.brandName,
                        style: const TextStyle(
                          color: Color(0xFF6D7077),
                          fontSize: 17,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        loan.orderID,
                        style: const TextStyle(
                          color: Color(0xFF6D7077),
                          fontSize: 17,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${loan.dateOrdered}\n${loan.timeString}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color(0xFF868A90),
                    fontSize: 17,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Text(
                  'Repayment Progress',
                  style: TextStyle(
                    color: Color(0xFF70757D),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  '$progressPercent%',
                  style: const TextStyle(
                    color: Color(0xFF2E5DC5),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                minHeight: 12,
                value: progress,
                color: const Color(0xFF3D73D6),
                backgroundColor: const Color(0xFFD8E4F6),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildPesoText(
                  amount: loan.firstInstallment,
                  color: const Color(0xFF858A92),
                  fontSize: 13,
                  weight: FontWeight.w500,
                ),
                const Spacer(),
                _buildPesoText(
                  amount: loan.fullyPaid,
                  color: const Color(0xFF858A92),
                  fontSize: 13,
                  weight: FontWeight.w500,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Balance',
                        style: TextStyle(
                          color: Color(0xFF2E3137),
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildPesoText(
                        amount: loan.balance,
                        color: const Color(0xFF6B3CE2),
                        fontSize: 24,
                        weight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return PaymentPinnedPage(balance: loan);
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: 170,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF8B5CF6),
                          Color(0xFF7C3AED),
                          Color(0xFF5B21B6),
                        ],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Pay Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPesoText({
    required double amount,
    required Color color,
    required double fontSize,
    required FontWeight weight,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '\u20B1 ',
            style: TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: weight,
              fontFamily: 'Arial',
            ),
          ),
          TextSpan(
            text: _formatAmount(amount),
            style: TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: weight,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(double amount) {
    final String value = amount.toStringAsFixed(2);
    final List<String> parts = value.split('.');
    final String whole = parts[0].replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (Match match) => ',',
    );
    return '$whole.${parts[1]}';
  }

  Widget _buildRecentTransactionsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'RECENT TRANSACTIONS',
          style: TextStyle(
            color: Color(0xFF9AA0A7),
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigate to all transactions
          },
          child: const Text(
            'VIEW ALL',
            style: TextStyle(
              color: Color(0xFF2E5DC5),
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentTransactionCard(TransactionModel transaction) {
    final Color statusColor =
        transaction.transactionType == TransactionType.upcoming
            ? const Color(0xFFFF9800)
            : const Color(0xFF4CAF50);

    final Color iconBgColor =
        transaction.transactionType == TransactionType.upcoming
            ? const Color(0xFFFFF3E0)
            : const Color(0xFFE8F0FD);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(8, 0, 0, 0),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(100),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              transaction.iconPath,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 108, 114, 124),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.date,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 108, 114, 124),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: '-\u20B1 ',
                      style: TextStyle(
                        color: Color(0xFF2E3137),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: _formatAmount(transaction.amount),
                      style: const TextStyle(
                        color: Color(0xFF2E3137),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                transaction.status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
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
