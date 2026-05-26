
import 'package:fast_sosyo/app/routes/app_routes.dart';
import 'package:fast_sosyo/app/modules/register_number_page/controller/register_number_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterNumberPage extends StatelessWidget {
  const RegisterNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterNumberController controller = Get.find<RegisterNumberController>();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
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
                        // SVG Illustration
                        SvgPicture.asset(
                          'assets/images/RegisterNumberPerson.svg',
                          height: 180,
                        ),
                        const SizedBox(height: 70),
                        // Title
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            'Enter your Registered Number',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Subtitle
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            'We will send you the 6-digit verification code',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Country code picker and phone input
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Row(
                            children: [
                              // Country code picker placeholder
                              Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey.shade300, width: 1.5),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  children: [
                                    // Flag
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: SvgPicture.asset(
                                        'assets/icons/ph.svg',
                                        width: 28,
                                        height: 20,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => const SizedBox(width: 28, height: 20),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(RegisterNumberController.countryCode, style: const TextStyle(fontSize: 16)),
                                    const Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Phone number input
                              Expanded(
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.grey.shade300, width: 1.5),
                                  ),
                                  child: TextField(
                                    controller: controller.phoneController,
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        const Spacer(),
                        // Terms and privacy policy (moved above button)
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            'By entering the Lending app, you have agreed to the terms and privacy policy.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        // Send Code button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                          child: Obx(() {
                            controller.refreshTrigger.value;
                            return SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF275DCE),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: controller.canSendCode
                                    ? () {
                                        Get.toNamed(
                                          Routes.otpVerification,
                                          arguments: controller.fullPhoneNumber,
                                        );
                                      }
                                    : null,
                                child: const Text(
                                  'Send Code',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
                                ),
                              ),
                            );
                          }),
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
