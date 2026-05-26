import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/controller/scan_success_controller.dart';
import 'package:fast_sosyo/app/routes/app_routes.dart';

class ScanSuccessPage extends GetView<ScanSuccessController> {
  const ScanSuccessPage({Key? key}) : super(key: key);

  static const Color _primaryBlue = Color(0xFF2E5DC8);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/scan_bg.png',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double width = constraints.maxWidth;
                final double horizontal = width * 0.06;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontal),
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            child: _ReceiptCard(controller: controller),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () => Get.offAllNamed(Routes.orderLoan),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _primaryBlue,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              elevation: 0,
                            ),
                            child: Text('Back to Home', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ReceiptCard extends StatelessWidget {
  const _ReceiptCard({required this.controller});

  final ScanSuccessController controller;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double cardWidth = (constraints.maxWidth * 0.96).clamp(320.0, 520.0);
      final double cardHeight = cardWidth * (600 / 320);
      final double scale = (cardWidth / 320).clamp(0.95, 1.32).toDouble();

      return Center(
        child: SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              SvgPicture.asset(
                'assets/icons/Succes_reciept_template.svg',
                width: cardWidth,
                height: cardHeight,
                fit: BoxFit.fill,
              ),
              Positioned(
                top: 44 * scale,
                left: 18 * scale,
                right: 18 * scale,
                child: Column(
                  children: [
                    Text(
                      'Payment Successful',
                      style: TextStyle(
                        color: const Color(0xFF171B22),
                        fontSize: 25 * scale,
                        fontWeight: FontWeight.w700,
                        height: 1.0,
                      ),
                    ),
                    SizedBox(height: 8 * scale),
                    Text(
                      'Show this qr code to the salesman to verify your payment.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF8A8D91),
                        fontSize: 13 * scale,
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 22 * scale),
                    SizedBox(
                      width: 180 * scale,
                      height: 180 * scale,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8 * scale),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFE5E7EB),
                                width: 1.5 * scale,
                              ),
                            ),
                            child: QrImageView(data: controller.qrData, size: 164 * scale),
                          ),
                          Container(
                            width: 44 * scale,
                            height: 44 * scale,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF2E5DC8),
                              border: Border.all(color: Colors.white, width: 3 * scale),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x33000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 24 * scale,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 354 * scale,
                left: 20 * scale,
                right: 20 * scale,
                bottom: 24 * scale,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          _ReceiptInfoRow(label: 'Loan ID:', value: controller.loanId, scale: scale),
                          SizedBox(height: 10 * scale),
                          _ReceiptInfoRow(label: 'Principal:', value: controller.principalTitle, scale: scale),
                          SizedBox(height: 10 * scale),
                          _ReceiptInfoRow(label: 'Applied:', value: controller.formattedAppliedDate, scale: scale),
                          SizedBox(height: 10 * scale),
                          _ReceiptInfoRow(label: 'Due Date:', value: controller.formattedDueDate, scale: scale),
                          SizedBox(height: 10 * scale),
                          _ReceiptInfoRow(label: 'Ref No:', value: controller.displayReferenceNo, scale: scale),
                          SizedBox(height: 12 * scale),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          'Amount Due',
                          style: TextStyle(
                            color: const Color(0xFF8F9398),
                            fontSize: 15 * scale,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 4 * scale),
                        SizedBox(
                          width: double.infinity,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '\u20B1 ',
                                    style: TextStyle(
                                      color: ScanSuccessPage._primaryBlue,
                                      fontSize: 32 * scale,
                                      fontWeight: FontWeight.w700,
                                      height: 1.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: controller.formatMoney(controller.amountDueFromQr),
                                    style: TextStyle(
                                      color: ScanSuccessPage._primaryBlue,
                                      fontSize: 28 * scale,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      height: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
      );
    });
  }
}



class _ReceiptInfoRow extends StatelessWidget {
  const _ReceiptInfoRow({required this.label, required this.value, required this.scale});

  final String label;
  final String value;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 90 * scale,
          child: Text(
            label,
            style: TextStyle(
              color: const Color(0xFF8A8D91),
              fontSize: 17 * scale,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: const Color(0xFF5F646A),
              fontSize: 17 * scale,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}


