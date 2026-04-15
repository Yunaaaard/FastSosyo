import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/models/review_loan_data.dart';

typedef ReviewLoanConfirmHandler = void Function(BuildContext context);

class ReviewLoanPage extends StatelessWidget {
  const ReviewLoanPage({
    super.key,
    required this.data,
    required this.onConfirm,
  });

  final ReviewLoanData data;
  final ReviewLoanConfirmHandler onConfirm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E2EE),
      appBar: _appBar(),
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
                    _buildRepaymentScheduleCard(context),
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
                  onPressed: () => onConfirm(context),
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

  AppBar _appBar() {
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
          _buildDetailRow('Ordered Amount', data.orderedAmount, currency: true),
          _buildDetailRow('Interest Rate', data.interestRate),
          _buildDetailRow('Repayment Term', data.repaymentTerm),
          _buildDetailRow('Processing Fee (2.5%)', data.processingFee,
              currency: true),
          _buildDetailRow('Documentation Charges', data.documentationCharges,
              currency: true),
          const SizedBox(height: 4),
          const Divider(color: Color(0xFFBFC3CA), thickness: 1),
          const SizedBox(height: 18),
          _buildCurrencyText(
            amount: data.totalRepayment,
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
          amount: data.monthlyPayment,
          amountColor: const Color(0xFF2E5DC5),
          amountFontSize: 22,
          weight: FontWeight.w700,
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    String label,
    dynamic value, {
    bool currency = false,
  }) {
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
                  amount: value as double,
                  amountColor: const Color(0xFF2E5DC5),
                  amountFontSize: 17,
                  weight: FontWeight.w700,
                )
              : Text(
                  value.toString(),
                  style: const TextStyle(
                    color: Color(0xFF2E5DC5),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildRepaymentScheduleCard(BuildContext context) {
    final int teaserCount =
        data.schedule.length >= 2 ? 2 : data.schedule.length;

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
          for (int i = 0; i < teaserCount; i++) ...[
            _buildScheduleRow(item: data.schedule[i]),
            if (i != teaserCount - 1) const SizedBox(height: 14),
          ],
          if (data.schedule.length > 2) ...[
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () => _showAllRepaymentDatesModal(context),
              child: Text(
                'View all ${data.schedule.length} Dates',
                style: const TextStyle(
                  color: Color(0xFF2E5DC5),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void _showAllRepaymentDatesModal(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext modalContext) {
        return Container(
          height: MediaQuery.of(modalContext).size.height * 0.72,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFD1D5DB),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Repayment Schedule (${data.schedule.length} Dates)',
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: ListView.separated(
                  itemCount: data.schedule.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 8);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: _buildScheduleRow(item: data.schedule[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildScheduleRow({required ReviewRepaymentScheduleItem item}) {
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
              item.installment,
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
                  item.title,
                  style: const TextStyle(
                    color: Color(0xFF6A6F76),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.date,
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
            amount: item.amount,
            amountColor: const Color(0xFF2E5DC5),
            amountFontSize: 18,
            weight: FontWeight.w700,
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyText({
    required double amount,
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
            text: _formatMoney(amount),
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

  String _formatMoney(double amount) {
    final String value = amount.toStringAsFixed(2);
    final List<String> parts = value.split('.');
    final String whole = parts[0].replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (Match match) => ',',
    );
    return '$whole.${parts[1]}';
  }
}
