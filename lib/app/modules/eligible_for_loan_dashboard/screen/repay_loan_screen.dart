import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fast_sosyo/app/routes/app_routes.dart';

class RepayLoanScreen extends StatelessWidget {
  const RepayLoanScreen({super.key});

  static const Color _pageTop = Color(0xFFEAF2FF);
  static const Color _pageBottom = Color(0xFFF3F8FF);
  static const Color _primaryBlue = Color(0xFF2F60C8);
  static const Color _titleColor = Color(0xFF31363D);
  static const Color _subTitleColor = Color(0xFF959AA2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBottom,
      appBar: appBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _pageTop,
              _pageBottom,
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double horizontalPadding = constraints.maxWidth * 0.055;
              final double cardWidth = constraints.maxWidth - (horizontalPadding * 2);

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: Column(
                        children: [
                          const SizedBox(height: 58),
                          const Text(
                            'Hello, Daven Reez',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _titleColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              height: 1.05,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Scan this qr code to repay your loan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _subTitleColor,
                              fontWeight: FontWeight.w400,
                              height: 1.1,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 44),
                          _ReceiptCard(width: cardWidth),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      0,
                      horizontalPadding,
                      16,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryBlue,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Get.offAllNamed(Routes.orderLoan);
                        },
                        child: const Text(
                          'Back to Home',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Text(
        'Repay Loan',
        style: TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.w600,
          fontSize: 23,
        ),
      ),
    );
  }
}

class _ReceiptCard extends StatelessWidget {
  const _ReceiptCard({required this.width});

  final double width;

  static const Color _amountBlue = Color(0xFF2E5DC8);
  static const Color _amountLabel = Color(0xFF666B72);

  @override
  Widget build(BuildContext context) {
    final double cardWidth = width.clamp(280.0, double.infinity);
    final double cardHeight = cardWidth * (478 / 320);
    final double scale = (cardWidth / 320).clamp(0.88, 1.08).toDouble();

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(18, 35, 63, 121),
            blurRadius: 28,
            offset: Offset(0, 12),
          ),
        ],
        borderRadius: BorderRadius.circular(28),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned.fill(
              child: Image.asset(
                'assets/images/repay-loan-receipt.png',
                fit: BoxFit.fill,
              ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              30 * scale,
              50 * scale,
              30 * scale,
              20 * scale,
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Center(
                    child: Image.asset(
                      'assets/images/FAST-SOSYO-QR.png',
                      width: 250 * scale,
                      height: 250 * scale,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Amount Due',
                        style: TextStyle(
                          color: _amountLabel,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: '\u20B1 ',
                              style: TextStyle(
                                color: _amountBlue,
                                fontSize: 44,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Arial',
                                height: 1.0,
                              ),
                            ),
                            TextSpan(
                              text: _formatAmount(1374.08),
                              style: const TextStyle(
                                color: _amountBlue,
                                fontSize: 42,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                                height: 1.0,
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
}
