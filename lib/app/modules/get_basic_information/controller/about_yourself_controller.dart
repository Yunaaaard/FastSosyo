import 'package:fast_sosyo/app/modules/get_basic_information/models/about_yourself_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutYourselfController extends GetxController {
  AboutYourselfController({AboutYourselfModel? initialModel}) {
    _model.value = initialModel ??
        const AboutYourselfModel(
          fullName: '',
          email: '',
          dateOfBirth: '',
          status: 'Single',
          gender: '',
          permanentAddress: '',
        );

    _nameController.text = _model.value.fullName;
    _emailController.text = _model.value.email;
    _dobController.text = _model.value.dateOfBirth;
    _addressController.text = _model.value.permanentAddress;
    _partnerController.text = _model.value.partnerName ?? '';
  }

  final formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _partnerController = TextEditingController();

  final Rx<AboutYourselfModel> _model = Rx<AboutYourselfModel>(
    const AboutYourselfModel(
      fullName: '',
      email: '',
      dateOfBirth: '',
      status: 'Single',
      gender: '',
      permanentAddress: '',
    ),
  );

  // lightweight trigger used by views to rebuild when text fields change
  final RxInt _refreshTrigger = 0.obs;

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
  AboutYourselfModel get model => _model.value;
  String get status => _model.value.status;
  String get gender => _model.value.gender;
  RxInt get refreshTrigger => _refreshTrigger;

  bool get canSubmit {
    final bool hasFullName = _nameController.text.trim().isNotEmpty;
    final bool hasEmail = _emailController.text.trim().isNotEmpty;
    final bool hasDob = _dobController.text.trim().isNotEmpty;
    final bool hasAddress = _addressController.text.trim().isNotEmpty;
    final bool hasPartnerName =
        _model.value.status != 'Married' || _partnerController.text.trim().isNotEmpty;

    return hasFullName && hasEmail && hasDob && hasAddress && hasPartnerName;
  }

  void setStatus(String status) {
    _model.value = _model.value.copyWith(
      status: status,
      partnerName: status == 'Married' ? _partnerController.text.trim() : null,
    );
    _model.refresh();

    if (status != 'Married') {
      _partnerController.clear();
    }
  }

  void setGender(String gender) {
    _model.value = _model.value.copyWith(gender: gender);
    _model.refresh();
  }

  void setDateOfBirth(DateTime date) {
    final String formattedDate =
        '${date.month.toString().padLeft(2, '0')} / ${date.day.toString().padLeft(2, '0')} / ${date.year}';
    _dobController.text = formattedDate;
    _model.value = _model.value.copyWith(dateOfBirth: formattedDate);
    _model.refresh();
  }

  void syncModelFromInputs() {
    _model.value = _model.value.copyWith(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      dateOfBirth: _dobController.text.trim(),
      permanentAddress: _addressController.text.trim(),
      partnerName:
          _model.value.status == 'Married' ? _partnerController.text.trim() : null,
    );
    _model.refresh();
  }

  @override
  void onInit() {
    super.onInit();
    _nameController.addListener(() => _refreshTrigger.value++);
    _emailController.addListener(() => _refreshTrigger.value++);
    _dobController.addListener(() => _refreshTrigger.value++);
    _addressController.addListener(() => _refreshTrigger.value++);
    _partnerController.addListener(() => _refreshTrigger.value++);
  }

  @override
  void onClose() {
    _nameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _partnerController.dispose();
    super.onClose();
  }
}
