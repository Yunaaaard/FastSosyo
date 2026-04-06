import 'package:fast_sosyo/app/modules/get_basic_information/models/employment_income_model.dart';
import 'package:flutter/material.dart';

class EmploymentIncomeController {
  EmploymentIncomeController({EmploymentIncomeModel? initialModel})
      : _model = initialModel ??
            const EmploymentIncomeModel(
              sourceOfIncome: '',
              monthlyIncome: 0,
            ) {
    _sourceController.text = _model.sourceOfIncome;
    _incomeController.text =
        _model.monthlyIncome == 0 ? '' : _model.monthlyIncome.toString();
    _taxController.text = _model.incomeTax ?? '';
    _employerController.text = _model.employerName ?? '';
    _yearsController.text = _model.yearsOfEmployment?.toString() ?? '';
  }

  final formKey = GlobalKey<FormState>();

  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _taxController = TextEditingController();
  final TextEditingController _employerController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();

  EmploymentIncomeModel _model;

  TextEditingController get sourceController => _sourceController;
  TextEditingController get incomeController => _incomeController;
  TextEditingController get taxController => _taxController;
  TextEditingController get employerController => _employerController;
  TextEditingController get yearsController => _yearsController;
  EmploymentIncomeModel get model => _model;

  void syncModelFromInputs() {
    final String incomeText = _incomeController.text.replaceAll(',', '').trim();
    final String yearsText = _yearsController.text.trim();

    _model = _model.copyWith(
      sourceOfIncome: _sourceController.text.trim(),
      monthlyIncome: double.tryParse(incomeText) ?? 0,
      incomeTax: _taxController.text.trim().isEmpty
          ? null
          : _taxController.text.trim(),
      employerName: _employerController.text.trim().isEmpty
          ? null
          : _employerController.text.trim(),
      yearsOfEmployment: int.tryParse(yearsText),
    );
  }

  void dispose() {
    _sourceController.dispose();
    _incomeController.dispose();
    _taxController.dispose();
    _employerController.dispose();
    _yearsController.dispose();
  }
}
