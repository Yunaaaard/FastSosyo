import 'package:fast_sosyo/app/modules/otp_verification/controller/otp_verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({
    super.key,
    this.title = 'OTP Verification',
    this.recipientLabel = '+93 9453482113',
    this.continueLabel = 'Continue',
    this.onVerifyOtp,
    this.onVerified,
    this.onResend,
  });

  final String title;
  final String recipientLabel;
  final String continueLabel;
  final Future<bool> Function(String otp)? onVerifyOtp;
  final Future<void> Function(BuildContext context, String otp)? onVerified;
  final VoidCallback? onResend;

  @override
  Widget build(BuildContext context) {
    final OtpVerificationController controller =
        Get.find<OtpVerificationController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.zero,
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        SvgPicture.asset(
                          'assets/images/OtpVerificationPerson.svg',
                          height: 220,
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                            child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Enter OTP sent to ',
                                  style: TextStyle(fontFamily: 'Poppins'),
                                ),
                                TextSpan(
                                  text: recipientLabel,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF275DCE),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(6, (i) {
                            return Padding(
                              padding: EdgeInsets.only(right: i < 5 ? 12 : 0),
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: TextField(
                                  controller: controller.controllers[i],
                                  focusNode: i == 0 ? controller.focusNode : null,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Color(0xFFD6D6D6), width: 1.5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Color(0xFFD6D6D6), width: 1.5),
                                    ),
                                  ),
                                  onChanged: (value) => controller.onChanged(i, value),
                                ),
                              ),
                            );
                          }),
                        ),
                        Obx(() {
                          final String? error = controller.errorText.value;
                          if (error == null) {
                            return const SizedBox.shrink();
                          }
                          return Column(
                            children: [
                              const SizedBox(height: 14),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: Text(
                                  error,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "You didn't receive any code? ",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                              GestureDetector(
                                onTap: onResend,
                                child: const Text(
                                  'RESEND',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF275DCE),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                          child: Obx(() => SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF275DCE),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  onPressed: controller.isVerifying.value
                                      ? null
                                      : () {
                                          controller.submitOtp(
                                            context: context,
                                            onVerifyOtp: onVerifyOtp,
                                            onVerified: onVerified,
                                          );
                                        },
                                  child: controller.isVerifying.value
                                      ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          continueLabel,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
