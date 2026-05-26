import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fast_sosyo/app/routes/app_routes.dart';

class OtpVerificationController extends GetxController {
  OtpVerificationController() {
    controllers = List.generate(6, (_) => TextEditingController());
    focusNode = FocusNode();
  }

  late final List<TextEditingController> controllers;
  late final FocusNode focusNode;

  final RxBool isVerifying = false.obs;
  final RxnString errorText = RxnString();

  String readOtp() => controllers.map((c) => c.text.trim()).join();

  void clearError() {
    if (errorText.value != null) {
      errorText.value = null;
    }
  }

  void onChanged(int index, String value) {
    clearError();
    if (value.isNotEmpty && index < controllers.length - 1) {
      focusNode.nextFocus();
    } else if (value.isEmpty && index > 0) {
      focusNode.previousFocus();
    }
  }

  Future<void> submitOtp({
    required BuildContext context,
    required Future<bool> Function(String otp)? onVerifyOtp,
    required Future<void> Function(BuildContext context, String otp)? onVerified,
  }) async {
    if (isVerifying.value) {
      return;
    }

    final String otp = readOtp();
    if (otp.length != 6 || otp.contains(RegExp(r'[^0-9]'))) {
      errorText.value = 'Enter the 6-digit code to continue.';
      return;
    }

    isVerifying.value = true;
    errorText.value = null;

    try {
      bool isValid = true;
      if (onVerifyOtp != null) {
        isValid = await onVerifyOtp(otp);
      }

      if (!isValid) {
        errorText.value = 'Invalid OTP. Please try again.';
        return;
      }

      if (onVerified != null) {
        await onVerified(context, otp);
      } else {
        Get.toNamed(Routes.dashboard);
      }
    } finally {
      isVerifying.value = false;
    }
  }

  @override
  void onClose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    focusNode.dispose();
    super.onClose();
  }
}