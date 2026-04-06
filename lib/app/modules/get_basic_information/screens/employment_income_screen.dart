import 'package:fast_sosyo/app/modules/get_basic_information/controller/employment_income_controller.dart';
import 'package:fast_sosyo/app/modules/get_basic_information/controller/basic_information_flow_controller.dart';
import 'package:fast_sosyo/app/modules/get_basic_information/screens/verification_process_screen.dart';
import 'package:flutter/material.dart';

class EmploymentIncomePage extends StatefulWidget {
  const EmploymentIncomePage({Key? key, this.flowController}) : super(key: key);

  final BasicInformationFlowController? flowController;

  @override
  State<EmploymentIncomePage> createState() => _EmploymentIncomePageState();
}

class _EmploymentIncomePageState extends State<EmploymentIncomePage> {
  late final BasicInformationFlowController _flowController;
  late final EmploymentIncomeController _controller;
  late final bool _ownsFlowController;

  void _onFormChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _ownsFlowController = widget.flowController == null;
    _flowController = widget.flowController ?? BasicInformationFlowController();
    _controller = _flowController.employmentIncomeController;

    _controller.sourceController.addListener(_onFormChanged);
    _controller.incomeController.addListener(_onFormChanged);
  }

  @override
  void dispose() {
    _controller.sourceController.removeListener(_onFormChanged);
    _controller.incomeController.removeListener(_onFormChanged);

    if (_ownsFlowController) {
      _flowController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAFF),
      appBar: _appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'Step 4 of 4',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color(0xFF222222),
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: 1.0,
                    backgroundColor: const Color(0xFFD6E4FF),
                    valueColor: AlwaysStoppedAnimation(Color(0xFF2563EB)),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Employment and Income',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 26,
                      color: Color(0xFF222222),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please provide your legal information as it appears on your government ID to help us verify your identity.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xFF8B8B8B),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildLabel('Source of Income', required: true),
                  _buildTextField(_controller.sourceController, 'Your business',
                      TextInputType.text,
                      required: true),
                  const SizedBox(height: 18),
                  _buildLabel('Monthly Income', required: true),
                  _buildTextField(
                      _controller.incomeController, ' ', TextInputType.number,
                      required: true),
                  const SizedBox(height: 18),
                  _buildLabel('Income Tax'),
                  _buildTextField(
                      _controller.taxController, ' ', TextInputType.text),
                  const SizedBox(height: 18),
                  _buildLabel('Employer Name'),
                  _buildTextField(_controller.employerController, 'Enter name',
                      TextInputType.text),
                  const SizedBox(height: 18),
                  _buildLabel('Years of Employment'),
                  _buildTextField(
                      _controller.yearsController, ' ', TextInputType.number),
                  const SizedBox(height: 24),
                  const Text(
                    'Your data is encrypted and only used for identity verification purposes.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color(0xFF8B8B8B),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: !_controller.canSubmit
                          ? null
                          : () {
                              if (!(_controller.formKey.currentState
                                      ?.validate() ??
                                  false)) {
                                return;
                              }

                              _controller.syncModelFromInputs();
                              _flowController.buildFlowModel();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const VerifyPerson(),
                                ),
                              );
                            },
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Basic Information',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildLabel(String text, {bool required = false}) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF222222),
          ),
        ),
        if (required)
          const Text(
            ' *',
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
      ],
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hint, TextInputType type,
      {bool required = false, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      maxLines: maxLines,
      validator: (value) {
        if (required && (value == null || value.isEmpty))
          return 'This field is required';
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            const TextStyle(color: Color(0xFFBDBDBD), fontFamily: 'Poppins'),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF2563EB)),
        ),
      ),
    );
  }
}
