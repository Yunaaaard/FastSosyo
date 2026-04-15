import 'package:flutter/material.dart';
import 'package:fast_sosyo/app/modules/pay_with_sosyo_credits/models/pay_sosyo_credits_flow_model.dart';

class PaySosyoCreditsController {
  PaySosyoCreditsController({PaySosyoCreditsFlowModel? initialModel})
      : _model = initialModel ??
            const PaySosyoCreditsFlowModel(
              principal: '',
              distributor: '',
              salesmanName: '',
              receiptNumber: '',
              address: '',
            ) {
    salesmanNameController.text = _model.salesmanName;
    receiptNumberController.text = _model.receiptNumber;
    addressController.text = _model.address;
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

  PaySosyoCreditsFlowModel _model;

  PaySosyoCreditsFlowModel get model => _model;
  String get principal => _model.principal;
  String get distributor => _model.distributor;
  bool get canSubmit {
    return _model.principal.isNotEmpty &&
        _model.distributor.isNotEmpty &&
        salesmanNameController.text.trim().isNotEmpty &&
        receiptNumberController.text.trim().isNotEmpty &&
        addressController.text.trim().isNotEmpty;
  }

  void setPrincipal(String value) {
    _model = _model.copyWith(principal: value);
  }

  void setDistributor(String value) {
    _model = _model.copyWith(distributor: value);
  }

  void syncModelFromInputs() {
    _model = _model.copyWith(
      salesmanName: salesmanNameController.text.trim(),
      receiptNumber: receiptNumberController.text.trim(),
      address: addressController.text.trim(),
    );
  }

  bool validate() {
    syncModelFromInputs();
    return formKey.currentState?.validate() ?? false;
  }

  void dispose() {
    salesmanNameController.dispose();
    receiptNumberController.dispose();
    addressController.dispose();
  }
}
