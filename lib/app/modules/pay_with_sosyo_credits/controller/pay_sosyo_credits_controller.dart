import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fast_sosyo/app/modules/pay_with_sosyo_credits/models/pay_sosyo_credits_flow_model.dart';

class PaySosyoCreditsController extends GetxController {
  PaySosyoCreditsController({PaySosyoCreditsFlowModel? initialModel}) {
    _model.value = initialModel ??
        const PaySosyoCreditsFlowModel(
          principal: '',
          distributor: '',
          salesmanName: '',
          receiptNumber: '',
          address: '',
        );
    salesmanNameController.text = _model.value.salesmanName;
    receiptNumberController.text = _model.value.receiptNumber;
    addressController.text = _model.value.address;
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController salesmanNameController = TextEditingController();
  final TextEditingController receiptNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final List<String> principalOptions = const [
    'Monde Nissin',
    'Nestle',
    'Shell',
    'Nutriasia',
    'CDO',
  ];

  final List<String> distributorOptions = const [
    'FDC',
    'Fast Sosyo',
    'FUI',
  ];

  final Rx<PaySosyoCreditsFlowModel> _model = Rx<PaySosyoCreditsFlowModel>(
    const PaySosyoCreditsFlowModel(
      principal: '',
      distributor: '',
      salesmanName: '',
      receiptNumber: '',
      address: '',
    ),
  );

  PaySosyoCreditsFlowModel get model => _model.value;
  Rx<PaySosyoCreditsFlowModel> get modelRx => _model;
  String get principal => _model.value.principal;
  String get distributor => _model.value.distributor;
  bool get canSubmit {
    return _model.value.principal.isNotEmpty &&
        _model.value.distributor.isNotEmpty &&
        salesmanNameController.text.trim().isNotEmpty &&
        receiptNumberController.text.trim().isNotEmpty &&
        addressController.text.trim().isNotEmpty;
  }

  void setPrincipal(String value) {
    _model.value = _model.value.copyWith(principal: value);
    _model.refresh();
  }

  void setDistributor(String value) {
    _model.value = _model.value.copyWith(distributor: value);
    _model.refresh();
  }

  void syncModelFromInputs() {
    _model.value = _model.value.copyWith(
      salesmanName: salesmanNameController.text.trim(),
      receiptNumber: receiptNumberController.text.trim(),
      address: addressController.text.trim(),
    );
    _model.refresh();
  }

  bool validate() {
    syncModelFromInputs();
    return formKey.currentState?.validate() ?? false;
  }

  @override
  void onClose() {
    salesmanNameController.dispose();
    receiptNumberController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
