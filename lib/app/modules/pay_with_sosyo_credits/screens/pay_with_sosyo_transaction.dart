import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/models/loan_balance_card_model.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/models/loan_receipt_data.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/models/review_loan_data.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/screen/loan_receipt.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/screen/review_your_loan.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/services/loan_balance_service.dart';
import 'package:fast_sosyo/app/modules/pay_with_sosyo_credits/controller/pay_with_sosyo_transaction_controller.dart';
import 'package:fast_sosyo/app/modules/pay_with_sosyo_credits/models/pay_sosyo_credits_flow_model.dart';
import 'package:fast_sosyo/app/routes/app_routes.dart';
import 'package:get/get.dart';

// ─── Currency Formatter ───────────────────────────────────────────────────────
// Strips non-digits, removes leading zeros, inserts commas every 3 digits.
// Maximum: 9,999,999.99
class _CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.isEmpty) {
      return newValue.copyWith(
        text: '',
        selection: const TextSelection.collapsed(offset: 0),
      );
    }

    // Strip leading zeros (e.g. "0123" → "123")
    final String stripped = digits.replaceFirst(RegExp(r'^0+(?=\d)'), '');
    final String cleanNum = stripped.isEmpty ? '0' : stripped;

    // Cap at maximum amount (9999999 pesos, no cents limit for simplicity)
    final double numValue = double.tryParse(cleanNum) ?? 0;
    final String cappedNum = numValue > 9999999 ? '9999999' : cleanNum;

    final String formatted = _insertCommas(cappedNum);

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _insertCommas(String digits) {
    final StringBuffer buf = StringBuffer();
    int count = 0;
    for (int i = digits.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) buf.write(',');
      buf.write(digits[i]);
      count++;
    }
    return buf.toString().split('').reversed.join('');
  }
}

// ─── Screen ──────────────────────────────────────────────────────────────────

class PayWithSosyoTransactionScreen
    extends GetView<PayWithSosyoTransactionController> {
  const PayWithSosyoTransactionScreen({
    super.key,
    required this.importantDetails,
  });

  final PaySosyoCreditsFlowModel importantDetails;

  LoanBalanceService get _balanceService => LoanBalanceService.instance;

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
                padding: const EdgeInsets.all(23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Step 2 of 2',
                      style: TextStyle(
                        color: Color(0xFF2B3138),
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: const LinearProgressIndicator(
                        minHeight: 16,
                        value: 1,
                        backgroundColor: Colors.white,
                        color: Color(0xFF2F60C8),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _buildOrderAmountCard(),
                    const SizedBox(height: 18),
                    const Text(
                      'REPAYMENT TERM',
                      style: TextStyle(
                        color: Color(0xFF627087),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
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
                    Obx(() => _buildMonthlyDateCard()),
                    const SizedBox(height: 14),
                    Obx(() => _buildMonthlyPaymentCard(controller.topMonthly)),
                    const SizedBox(height: 16),
                    const Text(
                      'PAYMENT SUMMARY',
                      style: TextStyle(
                        color: Color(0xFF627087),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(
                      () => _buildSummaryCard(
                        controller.totalRepayment,
                        controller.summaryMonthly,
                      ),
                    ),
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
                    if (!controller.hasValidOrderedAmount) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Input order amount is required.',
                            ),
                          ),
                        );
                      return;
                    }

                    final double orderedAmount = controller.orderedAmount;
                    final double calculatedProcessingFee =
                        controller.processingFee;
                    final double calculatedTotalRepayment =
                        controller.totalRepayment;
                    final List<ReviewRepaymentScheduleItem> schedule =
                        _buildRepaymentScheduleItems();

                    Get.to(() => ReviewLoanPage(
                          data: ReviewLoanData(
                            monthlyPayment: controller.summaryMonthly,
                            orderedAmount: orderedAmount,
                            interestRate: '1.69%',
                            repaymentTerm:
                                '${controller.selectedTermMonths.value} Months',
                            processingFee: calculatedProcessingFee,
                            documentationCharges: 45.00,
                            totalRepayment: calculatedTotalRepayment,
                            schedule: schedule,
                          ),
                          onConfirm: (BuildContext context) {
                            final DateTime now = DateTime.now();
                            final String referenceNo = _generateOrderId();

                            _balanceService.addConfirmedLoan(
                              LoanBalanceCardModel(
                                brandName:
                                    '${importantDetails.distributor.trim()} ${importantDetails.principal.trim()}',
                                dateOrdered:
                                    DateFormat('MMM dd, yyyy').format(now),
                                timeString: DateFormat('hh:mm a').format(now),
                                orderID: referenceNo,
                                firstInstallment: controller.topMonthly,
                                fullyPaid: controller.totalRepayment,
                                balance: controller.totalRepayment,
                              ),
                            );

                                Get.to(() => LoanReceiptPage(
                                  data: LoanReceiptData(
                                    from: importantDetails.salesmanName
                                        .trim(),
                                    to: 'Fast Sosyo ${importantDetails.distributor.trim()}',
                                    referenceNo: referenceNo,
                                    dateTime: DateFormat(
                                      'MMM dd, yyyy | hh:mm a',
                                    ).format(now),
                                    amountSent: orderedAmount,
                                  ),
                                  onBackToHome: (BuildContext context) {
                                    Get.offAllNamed(Routes.orderLoan);
                                  },
                                ));
                          },
                        ));
                  },
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
        'Pay with Sosyo Credits',
        style: TextStyle(
          color: Color(0xFF111827),
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ─── Improved Order Amount Card ─────────────────────────────────────────────

  Widget _buildOrderAmountCard() {
    return GestureDetector(
      // Tap anywhere on the card to focus the hidden field
      onTap: () => controller.amountFocusNode.requestFocus(),
      child: Obx(() => AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
            decoration: BoxDecoration(
              color: const Color(0xFF3F78D8),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: controller.isFocused.value
                    ? Colors.white.withOpacity(0.6)
                    : Colors.transparent,
                width: 2,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(20, 20, 39, 69),
                  blurRadius: 16,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'INPUT ORDER AMOUNT',
                      style: TextStyle(
                        color: Color(0xFFE8F0FF),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: controller.isFocused.value
                        ? const Color(0xFF5585D4)
                        : const Color(0xFF6A96DB),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // ── Visible display row ──
                      LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return SizedBox(
                            width: constraints.maxWidth - 20,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    '₱ ',
                                    style: TextStyle(
                                      color: Color(0xFFF2F7FF),
                                      fontSize: 46,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Arial',
                                      height: 1,
                                    ),
                                  ),
                                  Obx(() => Text(
                                        controller.displayText.value,
                                        style: const TextStyle(
                                          color: Color(0xFFF2F7FF),
                                          fontSize: 46,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Poppins',
                                          height: 1,
                                        ),
                                      )),
                                  if (controller.isFocused.value) _BlinkingCursor(),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      // ── Invisible TextField captures input ──
                      Opacity(
                        opacity: 0,
                        child: TextField(
                          controller: controller.amountController,
                          focusNode: controller.amountFocusNode,
                          keyboardType: TextInputType.number,
                          inputFormatters: [_CurrencyInputFormatter()],
                          style: const TextStyle(fontSize: 1),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isCollapsed: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  // ─── Rest of the widgets (unchanged) ────────────────────────────────────────

  Widget _buildTermChip(int months) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setSelectedTerm(months),
        child: Obx(() {
          final bool selected = controller.selectedTermMonths.value == months;
          return Container(
            height: 70,
            decoration: BoxDecoration(
              color: selected ? const Color(0xFF3F78D8) : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$months',
                  style: TextStyle(
                    color: selected ? Colors.white : const Color(0xFF111827),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'MONTHS',
                  style: TextStyle(
                    color: selected ? Colors.white : const Color(0xFF6B7280),
                    letterSpacing: 1.2,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }),
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
                  fontSize: 16,
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
            child: Text(
              'Day 15 of the month (${controller.selectedTermMonths.value} installments)',
              style: const TextStyle(
                color: Color(0xFF4B5563),
                fontSize: 16,
                fontWeight: FontWeight.w700,
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
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                _buildPesoText(
                  amount: monthlyPayment,
                  color: const Color(0xFF3F78D8),
                  fontSize: 15,
                  weight: FontWeight.w700,
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
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          const Text(
            'Total Repayment',
            style: TextStyle(
              color: Color(0xFF44484F),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          _buildPesoText(
            amount: totalRepayment,
            color: const Color(0xFF2E3137),
            fontSize: 30,
            weight: FontWeight.w700,
          ),
          const SizedBox(height: 18),
          const Divider(color: Color(0xFFCACDD2), thickness: 1.2),
          const SizedBox(height: 16),
          _buildSummaryRow(
            'Ordered Amount',
            _buildPesoText(
              amount: controller.orderedAmount,
              color: const Color(0xFF2E3137),
              fontSize: 18,
              weight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            'Interest Rate (1.69%)',
            _buildPesoText(
              amount: controller.interestFee,
              color: const Color(0xFF2E3137),
              fontSize: 18,
              weight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            'Repayment Term',
            Text(
              '${controller.selectedTermMonths.value} Months',
              style: const TextStyle(
                color: Color(0xFF2E3137),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            'Processing Fee (2.5%)',
            _buildPesoText(
              amount: controller.processingFee,
              color: const Color(0xFF2E3137),
              fontSize: 18,
              weight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            'Documentation Charges',
            _buildPesoText(
              amount: 45.00,
              color: const Color(0xFF2E3137),
              fontSize: 18,
              weight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFFCACDD2), thickness: 1.2),
          const SizedBox(height: 14),
          _buildSummaryRow(
            'Monthly Payment',
            _buildPesoText(
              amount: controller.monthlyPayment,
              color: const Color(0xFF2E3137),
              fontSize: 21,
              weight: FontWeight.w700,
            ),
            isStrongLabel: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, Widget value,
      {bool isStrongLabel = false}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: const Color(0xFF8A8E95),
              fontSize: 17,
              fontWeight: isStrongLabel ? FontWeight.w700 : FontWeight.w500,
            ),
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
            text: '₱ ',
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

  String _generateOrderId() {
    final int randomDigits = 1000 + (DateTime.now().microsecond % 9000);
    return 'AL-00$randomDigits';
  }

  List<ReviewRepaymentScheduleItem> _buildRepaymentScheduleItems() {
    final int term = controller.selectedTermMonths.value;
    final double total = controller.totalRepayment;
    final double monthly = controller.monthlyPayment;
    final DateFormat formatter = DateFormat('MMMM dd, yyyy');

    final List<ReviewRepaymentScheduleItem> schedule =
        <ReviewRepaymentScheduleItem>[];
    double allocated = 0;

    for (int i = 1; i <= term; i++) {
      final DateTime dueDate = DateTime(
        DateTime.now().year,
        DateTime.now().month + (i - 1),
        15,
      );

      final bool isLast = i == term;
      final double amount =
          isLast ? (total - allocated) : _roundToCents(monthly);
      allocated += amount;

      schedule.add(
        ReviewRepaymentScheduleItem(
          installment: '$i',
          title: '${_ordinal(i)} Installment',
          date: formatter.format(dueDate),
          amount: _roundToCents(amount),
        ),
      );
    }

    return schedule;
  }

  String _ordinal(int number) {
    if (number % 100 >= 11 && number % 100 <= 13) {
      return '${number}th';
    }
    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }

  double _roundToCents(double value) {
    return (value * 100).roundToDouble() / 100;
  }
}

// ─── Blinking Cursor Widget ───────────────────────────────────────────────────

class _BlinkingCursor extends StatefulWidget {
  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 530),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _ctrl,
      child: Container(
        width: 2.5,
        height: 46,
        margin: const EdgeInsets.only(left: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

// ─── Icon Helper ─────────────────────────────────────────────────────────────

class _InfoIconSvg extends StatelessWidget {
  const _InfoIconSvg({required this.svgPath});

  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFDDECFC),
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(svgPath, width: 23, height: 23),
    );
  }
}
