import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterNumberController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  static const String countryCode = '+63';

  final RxInt _refreshTrigger = 0.obs;

  RxInt get refreshTrigger => _refreshTrigger;

  bool get canSendCode => phoneController.text.trim().isNotEmpty;

  String get fullPhoneNumber => '$countryCode${phoneController.text.trim()}';

  @override
  void onInit() {
    super.onInit();
    phoneController.addListener(() => _refreshTrigger.value++);
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}