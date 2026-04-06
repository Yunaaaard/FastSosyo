import 'package:fast_sosyo/app/modules/get_basic_information/models/about_yourself_model.dart';
import 'package:flutter/material.dart';

class AboutYourselfController {
  AboutYourselfController({AboutYourselfModel? initialModel})
      : _model = initialModel ??
            const AboutYourselfModel(
              fullName: '',
              email: '',
              dateOfBirth: '',
              status: 'Single',
              gender: '',
              permanentAddress: '',
            ) {
    _nameController.text = _model.fullName;
    _emailController.text = _model.email;
    _dobController.text = _model.dateOfBirth;
    _addressController.text = _model.permanentAddress;
    _partnerController.text = _model.partnerName ?? '';
  }

  final formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _partnerController = TextEditingController();

  AboutYourselfModel _model;

  final List<String> statusOptions = const [
    'Single',
    'Married',
    'Divorced',
    'Widowed',
  ];

  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get dobController => _dobController;
  TextEditingController get addressController => _addressController;
  TextEditingController get partnerController => _partnerController;
  AboutYourselfModel get model => _model;
  String get status => _model.status;
  String get gender => _model.gender;
  bool get canSubmit {
    final bool hasFullName = _nameController.text.trim().isNotEmpty;
    final bool hasEmail = _emailController.text.trim().isNotEmpty;
    final bool hasDob = _dobController.text.trim().isNotEmpty;
    final bool hasAddress = _addressController.text.trim().isNotEmpty;
    final bool hasPartnerName =
        _model.status != 'Married' || _partnerController.text.trim().isNotEmpty;

    return hasFullName && hasEmail && hasDob && hasAddress && hasPartnerName;
  }

  void setStatus(String status) {
    _model = _model.copyWith(
      status: status,
      partnerName: status == 'Married' ? _partnerController.text.trim() : null,
    );

    if (status != 'Married') {
      _partnerController.clear();
    }
  }

  void setGender(String gender) {
    _model = _model.copyWith(gender: gender);
  }

  void setDateOfBirth(DateTime date) {
    final String formattedDate =
        '${date.month.toString().padLeft(2, '0')} / ${date.day.toString().padLeft(2, '0')} / ${date.year}';
    _dobController.text = formattedDate;
    _model = _model.copyWith(dateOfBirth: formattedDate);
  }

  void syncModelFromInputs() {
    _model = _model.copyWith(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      dateOfBirth: _dobController.text.trim(),
      permanentAddress: _addressController.text.trim(),
      partnerName:
          _model.status == 'Married' ? _partnerController.text.trim() : null,
    );
  }

  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _partnerController.dispose();
  }
}
