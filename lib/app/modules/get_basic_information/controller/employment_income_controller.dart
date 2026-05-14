import 'package:fast_sosyo/app/modules/get_basic_information/models/employment_income_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmploymentIncomeController extends GetxController {
  EmploymentIncomeController({EmploymentIncomeModel? initialModel}) {
    _model.value = initialModel ??
        const EmploymentIncomeModel(
          sourceOfIncome: '',
          monthlyIncome: 0,
        );
    _sourceController.text = _model.value.sourceOfIncome;
    _incomeController.text =
        _model.value.monthlyIncome == 0 ? '' : _model.value.monthlyIncome.toString();
    _taxController.text = _model.value.incomeTax ?? '';
    _employerController.text = _model.value.employerName ?? '';
    _yearsController.text = _model.value.yearsOfEmployment?.toString() ?? '';
    _personalDataConsentAccepted.value = _model.value.personalDataConsentAccepted;
  }

  final formKey = GlobalKey<FormState>();

  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _taxController = TextEditingController();
  final TextEditingController _employerController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();

  final Rx<EmploymentIncomeModel> _model = Rx<EmploymentIncomeModel>(
    const EmploymentIncomeModel(
      sourceOfIncome: '',
      monthlyIncome: 0,
    ),
  );
  final RxBool _personalDataConsentAccepted = false.obs;
  // Trigger to notify UI when form fields change
  final RxInt _refreshTrigger = 0.obs;

  TextEditingController get sourceController => _sourceController;
  TextEditingController get incomeController => _incomeController;
  TextEditingController get taxController => _taxController;
  TextEditingController get employerController => _employerController;
  TextEditingController get yearsController => _yearsController;
  EmploymentIncomeModel get model => _model.value;
  bool get personalDataConsentAccepted => _personalDataConsentAccepted.value;
  RxInt get refreshTrigger => _refreshTrigger;
  bool get canSubmit {
    final bool hasSourceOfIncome = _sourceController.text.trim().isNotEmpty;
    final double? monthlyIncome =
        double.tryParse(_incomeController.text.replaceAll(',', '').trim());

    return hasSourceOfIncome &&
        monthlyIncome != null &&
        monthlyIncome > 0 &&
        _personalDataConsentAccepted.value;
  }

  void setPersonalDataConsentAccepted(bool value) {
    _personalDataConsentAccepted.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    _sourceController.addListener(() => _refreshTrigger.value++);
    _incomeController.addListener(() => _refreshTrigger.value++);
    _taxController.addListener(() => _refreshTrigger.value++);
    _employerController.addListener(() => _refreshTrigger.value++);
    _yearsController.addListener(() => _refreshTrigger.value++);
  }

  void syncModelFromInputs() {
    final String incomeText = _incomeController.text.replaceAll(',', '').trim();
    final String yearsText = _yearsController.text.trim();

    _model.value = _model.value.copyWith(
      sourceOfIncome: _sourceController.text.trim(),
      monthlyIncome: double.tryParse(incomeText) ?? 0,
      personalDataConsentAccepted: _personalDataConsentAccepted.value,
      incomeTax: _taxController.text.trim().isEmpty
          ? null
          : _taxController.text.trim(),
      employerName: _employerController.text.trim().isEmpty
          ? null
          : _employerController.text.trim(),
      yearsOfEmployment: int.tryParse(yearsText),
    );
    _model.refresh();
  }

  @override
  void onClose() {
    _sourceController.dispose();
    _incomeController.dispose();
    _taxController.dispose();
    _employerController.dispose();
    _yearsController.dispose();
    super.onClose();
  }
}
