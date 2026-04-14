import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan/models/loan_order_card_model.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan/screen/review_your_loan.dart';

class PayCreditsPage extends StatefulWidget {
  const PayCreditsPage({super.key, required this.order});

  final LoanOrderCardModel order;

  @override
  State<PayCreditsPage> createState() => _PayCreditsPageState();
}

class _PayCreditsPageState extends State<PayCreditsPage> {
  int _selectedTermMonths = 3;

  static const Map<int, double> _topMonthlyByTerm = <int, double>{
    3: 370.00,
    6: 328.50,
    12: 307.02,
  };

  static const Map<int, double> _totalRepaymentByTerm = <int, double>{
    3: 1834.08,
    6: 1971.00,
    12: 2248.24,
  };

  static const Map<int, double> _summaryMonthlyByTerm = <int, double>{
    3: 307.02,
    6: 328.50,
    12: 187.35,
  };

  @override
  Widget build(BuildContext context) {
    final double topMonthly = _topMonthlyByTerm[_selectedTermMonths] ?? 0;
    final double totalRepayment =
        _totalRepaymentByTerm[_selectedTermMonths] ?? 0;
    final double summaryMonthly =
        _summaryMonthlyByTerm[_selectedTermMonths] ?? 0;

    return Scaffold(
      backgroundColor: const Color(0xFFD9E2EE),
      appBar: appBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOrderInfoCard(),
                    const SizedBox(height: 18),
                    const Text(
                      'REPAYMENT TERM',
                      style: TextStyle(
                        color: Color(0xFF627087),
                        letterSpacing: 1.1,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildTermChip(3),
                        const SizedBox(width: 10),
                        _buildTermChip(6),
                        const SizedBox(width: 10),
                        _buildTermChip(12),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _buildMonthlyDateCard(),
                    const SizedBox(height: 14),
                    _buildMonthlyPaymentCard(topMonthly),
                    const SizedBox(height: 22),
                    const Text(
                      'PAYMENT SUMMARY',
                      style: TextStyle(
                        color: Color(0xFF627087),
                        letterSpacing: 1.1,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSummaryCard(totalRepayment, summaryMonthly),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              child: SizedBox(
                width: double.infinity,
                height: 62,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F60C8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const ReviewLoanPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Pay with Sosyo Credits',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: const Color(0xFFD9E2EE),
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Pay with Sosyo Credits',
        style: TextStyle(
          color: Color(0xFF111827),
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildOrderInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.asset(widget.order.brandLogo, fit: BoxFit.contain),
              ),
              const SizedBox(width: 14),
              Expanded(child: Container()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ordered Amount',
                    style: TextStyle(
                      color: Color(0xFF8A8E95),
                      fontSize: 17,
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
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Arial',
                          ),
                        ),
                        TextSpan(
                          text: widget.order.orderedAmount,
                          style: const TextStyle(
                            color: Color(0xFF2E5DC5),
                            fontSize: 33,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Product Count',
                        style: TextStyle(
                          color: Color(0xFF8A8E95),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.order.productCount} SKU\'s',
                        style: const TextStyle(
                          color: Color(0xFF5B6068),
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: 1, color: const Color(0xFFC7CAD0)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Date Ordered',
                          style: TextStyle(
                            color: Color(0xFF8A8E95),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.order.dateOrdered,
                          style: const TextStyle(
                            color: Color(0xFF5B6068),
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermChip(int months) {
    final bool selected = _selectedTermMonths == months;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTermMonths = months;
          });
        },
        child: Container(
          height: 65,
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF3F78D8) : const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(17),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$months',
                style: TextStyle(
                  color: selected ? Colors.white : const Color(0xFF111827),
                  fontSize: 40 / 2,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'MONTHS',
                style: TextStyle(
                  color: selected ? Colors.white : const Color(0xFF6B7280),
                  letterSpacing: 1.2,
                  fontSize: 16 / 2 * 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthlyDateCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _InfoIconSvg(
                  svgPath: 'assets/icons/monthly-payment-date-icon.svg'),
              const SizedBox(width: 12),
              const Text(
                'Monthly Payment Date',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFDDECFC),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Day 15 of the month',
              style: TextStyle(
                color: Color(0xFF4B5563),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyPaymentCard(double monthlyPayment) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          _InfoIconSvg(svgPath: 'assets/icons/monthly-payment-icon.svg'),
          const SizedBox(width: 23),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Monthly Payment',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: '\u20B1 ',
                        style: TextStyle(
                          color: Color(0xFF3F78D8),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Arial',
                        ),
                      ),
                      TextSpan(
                        text: monthlyPayment.toStringAsFixed(2),
                        style: const TextStyle(
                          color: Color(0xFF3F78D8),
                          fontSize: 20,
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
        ],
      ),
    );
  }

  Widget _buildSummaryCard(double totalRepayment, double summaryMonthly) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            'Total Repayment',
            style: TextStyle(
              color: Color(0xFF3F444B),
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: '\u20B1 ',
                  style: TextStyle(
                    color: Color(0xFF30353C),
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Arial',
                  ),
                ),
                TextSpan(
                  text: totalRepayment.toStringAsFixed(2),
                  style: const TextStyle(
                    color: Color(0xFF30353C),
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: Color(0xFFC3C7CD), thickness: 1),
          const SizedBox(height: 10),
          _buildSummaryRow(
            'Ordered Amount',
            widget.order.orderedAmount,
            isCurrency: true,
          ),
          _buildSummaryRow('Interest Rate', '1.69%'),
          _buildSummaryRow('Repayment Term', '$_selectedTermMonths Months'),
          _buildSummaryRow(
            'Processing Fee (2.5%)',
            '250.00',
            isCurrency: true,
          ),
          _buildSummaryRow(
            'Documentation Charges',
            '45.00',
            isCurrency: true,
          ),
          const SizedBox(height: 8),
          const Divider(
            color: Color(0xFFC3C7CD),
            thickness: 1,
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            'Monthly Payment',
            summaryMonthly.toStringAsFixed(2),
            bold: true,
            isCurrency: true,
            labelColor: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool bold = false,
    bool isCurrency = false,
    Color labelColor = const Color(0xFF8A8E95),
  }) {
    final TextStyle labelStyle = TextStyle(
      color: labelColor,
      fontSize: 16,
      fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
    );
    final TextStyle valueStyle = TextStyle(
      color: const Color(0xFF30353C),
      fontSize: 17,
      fontWeight: FontWeight.w600,
    );

    Widget valueWidget;
    if (isCurrency) {
      valueWidget = RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: '\u20B1 ',
              style: TextStyle(
                color: Color(0xFF30353C),
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Arial',
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(
                color: Color(0xFF30353C),
                fontSize: 17,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      );
    } else {
      valueWidget = Text(value, style: valueStyle);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: Row(
        children: [
          Expanded(child: Text(label, style: labelStyle)),
          valueWidget,
        ],
      ),
    );
  }
}

class _InfoIconSvg extends StatelessWidget {
  const _InfoIconSvg({required this.svgPath});

  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFCFE0F7),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          svgPath,
          width: 25,
          height: 25,
        ),
      ),
    );
  }
}
