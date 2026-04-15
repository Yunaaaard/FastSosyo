import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/screen/repay_loan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/models/loan_balance_card_model.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/models/transaction_model.dart';

class PaymentPinnedPage extends StatefulWidget {
  const PaymentPinnedPage({
    required this.balance,
    super.key,
  });

  final LoanBalanceCardModel balance;

  @override
  State<PaymentPinnedPage> createState() => _PaymentPinnedPageState();
}

class _PaymentPinnedPageState extends State<PaymentPinnedPage> {
  late List<TransactionModel> transactions;

  @override
  void initState() {
    super.initState();
    transactions = TransactionModel.getSampleTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final double progress = widget.balance.fullyPaid <= 0
        ? 0
        : (widget.balance.firstInstallment / widget.balance.fullyPaid)
            .clamp(0.0, 1.0);
    final int progressPercent = (progress * 100).round();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: appBar(),
      bottomNavigationBar: Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    child: SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2F60C8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
        ),
        onPressed: () {
          // Navigate to payment screen
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RepayLoanScreen(),
              ),
            );
        },
        child: const Text(
          'Pay Balance',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Merged Card: Header Info + Total Repayment + Details
Container(
  margin: const EdgeInsets.all(20),
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: const [
      BoxShadow(
        color: Color.fromARGB(10, 0, 0, 0),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: Column(
    children: [
      // --- Header Info ---
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fast Sosyo ${widget.balance.brandName}',
                style: const TextStyle(
                  color: Color(0xFF8B8D91),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.balance.orderID,
                style: const TextStyle(
                  color: Color(0xFF8B8D91),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.balance.dateOrdered,
                style: const TextStyle(
                  color: Color(0xFF8B8D91),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.balance.timeString,
                style: const TextStyle(
                  color: Color(0xFF8B8D91),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 24),
      // --- Total Repayment ---
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Total Repayment',
            style: TextStyle(
              color: Color(0xFF70757D),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          _buildPesoText(
            amount: widget.balance.fullyPaid,
            color: const Color(0xFF2E5DC5),
            fontSize: 45,
            weight: FontWeight.w700,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Repayment Progress',
                style: TextStyle(
                  color: Color(0xFF70757D),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '$progressPercent%',
                style: const TextStyle(
                  color: Color(0xFF2E5DC5),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: progress,
              color: const Color(0xFF3D73D6),
              backgroundColor: const Color(0xFFD8E4F6),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPesoText(
                amount: widget.balance.firstInstallment,
                color: const Color(0xFF858A92),
                fontSize: 14,
                weight: FontWeight.w400,
              ),
              _buildPesoText(
                amount: widget.balance.fullyPaid,
                color: const Color(0xFF858A92),
                fontSize: 14,
                weight: FontWeight.w400,
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 24),
      // --- Details ---
      _buildDetailRow(
        'Ordered Amount',
        _buildPesoText(
          amount: widget.balance.balance,
          color: const Color(0xFF2E5DC5),
          fontSize: 15,
          weight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 16),
      _buildDetailRow(
        'Monthly Payment',
        _buildPesoText(
          amount: 307.02,
          color: const Color(0xFF2E5DC5),
          fontSize: 15,
          weight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 16),
      _buildDetailRow(
        'Interest Rate',
        const Text(
          '1.69%',
          style: TextStyle(
            color: Color(0xFF2E5DC5),
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      const SizedBox(height: 16),
      _buildDetailRow(
        'Repayment Term',
        const Text(
          '3 Months',
          style: TextStyle(
            color: Color(0xFF2E5DC5),
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      const SizedBox(height: 16),
      _buildDetailRow(
        'Processing Fee (2.5%)',
        _buildPesoText(
          amount: 250.00,
          color: const Color(0xFF2E5DC5),
          fontSize: 15,
          weight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 16),
      _buildDetailRow(
        'Documentation Charges',
        _buildPesoText(
          amount: 45.00,
          color: const Color(0xFF2E5DC5),
          fontSize: 15,
          weight: FontWeight.w700,
        ),
      ),
    ],
  ),
),
            // Recent Transactions Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: List.generate(
                      transactions.length,
                      (index) => _buildTransactionCard(transactions[index]),
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

  AppBar appBar() {
    return AppBar(
      backgroundColor: const Color(0xFFFFFFFF),
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Text(
        'Remaining Balance Summary',
        style: TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.w500,
          fontSize: 23,
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, Widget value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF70757D),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        value,
      ],
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

  Widget _buildTransactionCard(TransactionModel transaction) {
    final Color statusColor = transaction.transactionType == TransactionType.upcoming
        ? const Color(0xFFFF9800)
        : const Color(0xFF4CAF50);

    final Color iconBgColor =
        transaction.transactionType == TransactionType.upcoming
            ? const Color(0xFFFFF3E0)
            : const Color(0xFF275DCE).withAlpha(55);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
          // Icon
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
          // Title and Date
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
          // Amount and Status
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
}
