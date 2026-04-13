import 'dart:typed_data';

import 'package:fast_sosyo/app/modules/eligible_for_loan/screen/order_loan_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fast_sosyo/app/modules/otp_verification/screens/otp_verification_screen.dart';
import 'package:fast_sosyo/app/modules/success_eligibility/constants/loan_agreement_content.dart';
import 'package:fast_sosyo/app/modules/success_eligibility/controller/loan_details_controller.dart';
import 'package:fast_sosyo/data/services/loan_agreement_service.dart';
import 'package:signature/signature.dart';

class LoanDetailsScreen extends StatefulWidget {
  const LoanDetailsScreen({super.key, required this.userFullName});

  final String userFullName;

  @override
  State<LoanDetailsScreen> createState() => _LoanDetailsScreenState();
}

class _LoanDetailsScreenState extends State<LoanDetailsScreen> {
  LoanDetailsController? _controller;
  final LoanAgreementService _agreementService = LoanAgreementService();

  LoanDetailsController get _controllerRef =>
      _controller ??= LoanDetailsController(userFullName: widget.userFullName);

  @override
  void initState() {
    super.initState();
    _controller ??= LoanDetailsController(userFullName: widget.userFullName);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoanDetailsController controller = _controllerRef;

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F9FF),
          appBar: appBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2563EB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'MAXIMUM LOAN LIMIT',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: '\u20B1',
                              style: TextStyle(
                                fontFamily: 'Arial',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' ${controller.loanOffer.maximumLoanLimit.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Divider(color: Colors.white.withOpacity(0.4)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Interest Rate',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 14),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                controller.loanOffer.interestRateLabel,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Payment Term',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 14),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                controller.loanOffer.paymentTermLabel,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'BREAKDOWN & FEES',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        child: Column(
                          children: [
                            for (int i = 0;
                                i < controller.breakdownItems.length;
                                i++) ...[
                              _buildBreakdownRow(
                                controller.breakdownItems[i].label,
                                controller.breakdownItems[i].value,
                                isBold: controller.breakdownItems[i].isBold,
                                hasPeso: controller.breakdownItems[i].hasPeso,
                                valueColor:
                                    controller.breakdownItems[i].valueColor,
                              ),
                              if (i == controller.breakdownItems.length - 2)
                                const Divider(
                                    height: 16, color: Color(0xFFF0F0F0))
                              else if (i !=
                                  controller.breakdownItems.length - 1)
                                const SizedBox(height: 16),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'DIGITAL CONTRACT',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton.icon(
                          onPressed: _openContractModal,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF2563EB)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          icon: const Icon(
                            Icons.description_outlined,
                            color: Color(0xFF2563EB),
                            size: 18,
                          ),
                          label: const Text(
                            'Review Contract',
                            style: TextStyle(
                              color: Color(0xFF2563EB),
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      if (controller.generatedAgreementPath != null) ...[
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0FDF4),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFBBF7D0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFDCFCE7),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      size: 15,
                                      color: Color(0xFF15803D),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Expanded(
                                    child: Text(
                                      'Agreement saved',
                                      style: TextStyle(
                                        color: Color(0xFF166534),
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDCFCE7),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: const Text(
                                      'Ready',
                                      style: TextStyle(
                                        color: Color(0xFF166534),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'File',
                                style: TextStyle(
                                  color: Color(0xFF166534),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _agreementService.extractFileName(
                                  controller.generatedAgreementPath!,
                                ),
                                style: const TextStyle(
                                  color: Color(0xFF14532D),
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Saved in ${_agreementService.extractDirectoryLabel(controller.generatedAgreementPath!)}',
                                style: const TextStyle(
                                  color: Color(0xFF166534),
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: controller.contractSigned
                          ? _openLoanOtpVerification
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        disabledBackgroundColor: const Color(0xFFCCCCCC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Proceed & Verify OTP',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'SECURE 256-BIT ENCRYPTED TRANSACTION',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black38,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar appBar() {
    return AppBar(
          backgroundColor: const Color(0xFFF6F9FF),
          elevation: 0,
          leading: const SizedBox.shrink(),
          centerTitle: true,
          title: const Text(
            'Loan Offer Details',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        );
  }

  Future<void> _openLoanOtpVerification() async {
    if (!mounted) {
      return;
    }

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext otpContext) {
          return OtpVerificationPage(
            title: 'Loan OTP Verification',
            recipientLabel: 'your registered mobile number',
            continueLabel: 'Verify & Continue',
            onVerifyOtp: (String otp) async {
              await Future<void>.delayed(const Duration(milliseconds: 500));
              return otp.length == 6;
            },
            onVerified: (BuildContext context, String otp) async {
              if (!mounted) {
                return;
              }

              await Navigator.of(context).pushReplacement(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return const OrderLoanScreen();
                  },
                ),
              );
            },
            onResend: () {
              if (!mounted) {
                return;
              }

              ScaffoldMessenger.of(otpContext).showSnackBar(
                const SnackBar(
                  content: Text('A new OTP has been sent.'),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBreakdownRow(
    String label,
    String value, {
    bool isBold = false,
    bool hasPeso = false,
    Color valueColor = Colors.black87,
  }) {
    final Widget valueWidget;
    if (hasPeso) {
      valueWidget = RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '\u20B1',
              style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
                fontSize: isBold ? 18 : 15,
                color: valueColor,
              ),
            ),
            TextSpan(
              text: ' $value',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
                fontSize: isBold ? 18 : 15,
                color: valueColor,
              ),
            ),
          ],
        ),
      );
    } else {
      valueWidget = Text(
        value,
        style: TextStyle(
          fontSize: isBold ? 18 : 15,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          color: valueColor,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black54,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 12),
        valueWidget,
      ],
    );
  }

  Future<void> _openContractModal() async {
    final LoanDetailsController controller = _controllerRef;
    final BuildContext screenContext = context;
    final SignatureController signatureController = SignatureController(
      penStrokeWidth: 2.5,
      penColor: Colors.black,
      exportBackgroundColor: Colors.transparent,
    );
    bool agreed = false;

    try {
      final String? generatedPath = await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext modalContext) {
          return DraggableScrollableSheet(
            initialChildSize: 0.93,
            minChildSize: 0.72,
            maxChildSize: 0.98,
            expand: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return StatefulBuilder(
                builder: (BuildContext context,
                    void Function(void Function()) setSheetState) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(28)),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                width: 54,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE5E7EB),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEFF6FF),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Icon(
                                    Icons.edit_document,
                                    color: Color(0xFF2563EB),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Digital Contract',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Review the agreement, sign below, and save your copy.',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 13,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFF8FAFC),
                                    Color(0xFFEFF6FF)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(16),
                                border:
                                    Border.all(color: const Color(0xFFDCE7F5)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    LoanAgreementContent.previewTitle,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    LoanAgreementContent.bodyText,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      height: 1.5,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Name: ${controller.resolvedUserFullName}',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2563EB),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Row(
                              children: [
                                Icon(Icons.draw_outlined,
                                    size: 18, color: Color(0xFF2563EB)),
                                SizedBox(width: 8),
                                Text(
                                  'Sign here with your finger',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 190,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border:
                                    Border.all(color: const Color(0xFFCBD5E1)),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                      child: Signature(
                                        controller: signatureController,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFF8FAFC),
                                      borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(16),
                                      ),
                                    ),
                                    child: const Text(
                                      'Draw your signature above',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  signatureController.clear();
                                  setSheetState(() {});
                                },
                                icon:
                                    const Icon(Icons.delete_outline, size: 18),
                                label: const Text('Clear'),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: const Color(0xFFDCE7F5)),
                              ),
                              child: CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                                activeColor: const Color(0xFF2563EB),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                value: agreed,
                                onChanged: (bool? value) {
                                  setSheetState(() {
                                    agreed = value ?? false;
                                  });
                                },
                                title: const Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontFamily: 'Poppins',
                                      color: Colors.black87,
                                    ),
                                    children: [
                                      TextSpan(text: 'I agree to the '),
                                      TextSpan(
                                        text: 'Loan Agreement Terms',
                                        style: TextStyle(
                                          color: Color(0xFF2563EB),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' and consent to sign this agreement.',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            ValueListenableBuilder<List<Point>>(
                              valueListenable: signatureController,
                              builder: (
                                BuildContext context,
                                List<Point> _signaturePoints,
                                Widget? child,
                              ) {
                                final bool canSubmit =
                                    agreed && signatureController.isNotEmpty;
                                return SizedBox(
                                  width: double.infinity,
                                  height: 52,
                                  child: ElevatedButton(
                                    onPressed: canSubmit
                                        ? () async {
                                            final Uint8List? signatureBytes =
                                                await signatureController
                                                    .toPngBytes();
                                            if (signatureBytes == null) return;

                                            final String savedPath =
                                                await _agreementService
                                                    .generateAndSaveAgreementPdf(
                                              signatureBytes: signatureBytes,
                                              fullName: controller
                                                  .resolvedUserFullName,
                                            );

                                            String finalPath = savedPath;
                                            if (!_agreementService
                                                .isAndroidDownloadsPath(
                                                    savedPath)) {
                                              final String? downloadedPath =
                                                  await _agreementService
                                                      .saveAgreementToAndroidDownloads(
                                                          savedPath);
                                              if (downloadedPath != null &&
                                                  downloadedPath.isNotEmpty) {
                                                finalPath = downloadedPath;
                                              }
                                            }

                                            controller.setAgreementGenerated(
                                                finalPath);

                                            Navigator.of(
                                              modalContext,
                                              rootNavigator: true,
                                            ).pop<String>(finalPath);
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF2563EB),
                                      disabledBackgroundColor:
                                          const Color(0xFFCBD5E1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    child: const Text(
                                      'Sign & Generate PDF',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      );

      if (!mounted || generatedPath == null) {
        return;
      }

      await Future<void>.delayed(const Duration(milliseconds: 250));

      if (!mounted) {
        return;
      }

      final String resolvedPath = generatedPath;
      final bool inDownloads =
          _agreementService.isAndroidDownloadsPath(resolvedPath);

      await showDialog<void>(
        context: screenContext,
        useRootNavigator: true,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              'Agreement saved',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            content: Text(
              'File: ${_agreementService.extractFileName(resolvedPath)}',
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      if (!mounted) return;

      ScaffoldMessenger.of(screenContext).showSnackBar(
        SnackBar(
          content: Text(
            inDownloads
                ? 'Agreement saved to Downloads.'
                : 'Agreement saved to app storage. Use Save to Downloads button below.',
          ),
        ),
      );
    } finally {
      signatureController.dispose();
    }
  }
}
