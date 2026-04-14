import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan/screen/loan_receipt.dart';

class ReviewLoanPage extends StatelessWidget {
  const ReviewLoanPage({super.key});

  static const String _orderedAmount = '1,574.08';
  static const String _interestRate = '1.69%';
  static const String _repaymentTerm = '3 Months';
  static const String _processingFee = '250.00';
  static const String _documentationCharges = '45.00';
  static const String _monthlyPayment = '307.02';
  static const String _totalRepayment = '1,834.08';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E2EE),
      appBar: appBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    _buildLoanSummaryCard(),
                    const SizedBox(height: 20),
                    _buildRepaymentScheduleCard(),
                    const SizedBox(height: 20),
                    _buildDisclaimerBlock(),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const LoanReceiptPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFF2F60C8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Confirm and Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 44 / 2,
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
        'Review Your Loan',
        style: TextStyle(
          color: Color(0xFF111827),
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDisclaimerBlock() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Color(0xFF6B7280),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text(
            'i',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'By clicking "Confirm & Continue", you agree to the GLoan Terms of Service and authorize the automatic debit of repayments on the specified due dates.',
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 13,
              height: 1.3,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoanSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildTopSummaryRow(),
          const SizedBox(height: 18),
          const Divider(color: Color(0xFFBFC3CA), thickness: 1),
          const SizedBox(height: 4),
          _buildDetailRow('Ordered Amount', _orderedAmount, currency: true),
          _buildDetailRow('Interest Rate', _interestRate),
          _buildDetailRow('Repayment Term', _repaymentTerm, highlight: true),
          _buildDetailRow('Processing Fee (2.5%)', _processingFee,
              currency: true),
          _buildDetailRow('Documentation Charges', _documentationCharges,
              currency: true),
          const SizedBox(height: 4),
          const Divider(color: Color(0xFFBFC3CA), thickness: 1),
          const SizedBox(height: 18),
          _buildCurrencyText(
            amount: _totalRepayment,
            amountColor: const Color(0xFF2E5DC5),
            amountFontSize: 35,
            weight: FontWeight.w700,
          ),
          const SizedBox(height: 6),
          const Text(
            'Total Repayment',
            style: TextStyle(
              color: Color(0xFF676C74),
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSummaryRow() {
    return Row(
      children: [
        const Text(
          'Monthly Payment',
          style: TextStyle(
            color: Color(0xFF2E5DC5),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        _buildCurrencyText(
          amount: _monthlyPayment,
          amountColor: const Color(0xFF2E5DC5),
          amountFontSize: 22,
          weight: FontWeight.w700,
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool currency = false,
    bool highlight = false,
  }) {
    final Color valueColor = const Color(0xFF2E5DC5);
    final FontWeight valueWeight = FontWeight.w700;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF8A8E95),
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          currency
              ? _buildCurrencyText(
                  amount: value,
                  amountColor: const Color(0xFF2E5DC5),
                  amountFontSize: 17,
                  weight: FontWeight.w700,
                )
              : Text(
                  value,
                  style: TextStyle(
                    color: valueColor,
                    fontSize: 17,
                    fontWeight: valueWeight,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildRepaymentScheduleCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFddecfc),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/monthly-payment-date-icon.svg',
                  width: 23,
                  height: 23,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'REPAYMENT SCHEDULE',
                style: TextStyle(
                  color: Color(0xFF5D6269),
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _buildScheduleRow(
            installment: '1',
            title: 'First Installment',
            date: 'April 15, 2026',
            amount: '1,370.00',
          ),
          const SizedBox(height: 14),
          _buildScheduleRow(
            installment: '2',
            title: 'Second Installment',
            date: 'May 15, 2026',
            amount: '1,370.00',
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildScheduleRow({
    required String installment,
    required String title,
    required String date,
    required String amount,
  }) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFddecfc),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                installment,
                style: const TextStyle(
                  color: Color(0xFF2E5DC5),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF6A6F76),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(
                      color: Color(0xFF8B8F95),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            _buildCurrencyText(
              amount: amount,
              amountColor: const Color(0xFF2E5DC5),
              amountFontSize: 18,
              weight: FontWeight.w700,
            ),
          ],
        ));
  }

  Widget _buildCurrencyText({
    required String amount,
    required Color amountColor,
    required double amountFontSize,
    required FontWeight weight,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '\u20B1 ',
            style: TextStyle(
              color: amountColor,
              fontSize: amountFontSize,
              fontWeight: weight,
              fontFamily: 'Arial',
            ),
          ),
          TextSpan(
            text: amount,
            style: TextStyle(
              color: amountColor,
              fontSize: amountFontSize,
              fontWeight: weight,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
