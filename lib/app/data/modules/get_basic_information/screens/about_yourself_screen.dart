import 'package:fast_sosyo/app/data/modules/get_basic_information/screens/employment_income_screen.dart';
import 'package:flutter/material.dart';

class AboutYourselfPage extends StatefulWidget {
  const AboutYourselfPage({Key? key}) : super(key: key);

  @override
  State<AboutYourselfPage> createState() => _AboutYourselfPageState();
}

class _AboutYourselfPageState extends State<AboutYourselfPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _partnerController = TextEditingController();

  String _status = 'Single';
  String _gender = '';
  final List<String> _statusOptions = ['Single', 'Married', 'Divorced', 'Widowed'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _partnerController.dispose();
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
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'Step 3 of 4',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color(0xFF222222),
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: 0.75,
                    backgroundColor: const Color(0xFFD6E4FF),
                    valueColor: AlwaysStoppedAnimation(Color(0xFF2563EB)),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Tell us about yourself',
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
                  _buildLabel('Full Name', required: true),
                  _buildTextField(_nameController, ' ', TextInputType.name),
                  const SizedBox(height: 18),
                  _buildLabel('Email Address', required: true),
                  _buildTextField(_emailController, 'example@email.com', TextInputType.emailAddress),
                  const SizedBox(height: 18),
                  _buildLabel('Date of Birth', required: true),
                  _buildDateField(context),
                  const SizedBox(height: 18),
                  _buildLabel('Status', required: true),
                  _buildStatusDropdown(),
                  if (_status == 'Married') ...[
                    const SizedBox(height: 18),
                    _buildLabel('Partner Name', required: true),
                    _buildTextField(_partnerController, 'Enter partner name', TextInputType.name),
                  ],
                  const SizedBox(height: 18),
                  _buildLabel('Gender'),
                  _buildGenderSelector(),
                  const SizedBox(height: 18),
                  _buildLabel('Permanent Address', required: true),
                  _buildTextField(_addressController, 'Enter your full street address, apartment number, city, and state', TextInputType.streetAddress, maxLines: 3),
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
                      onPressed: () {
                        // if (_formKey.currentState!.validate()) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const EmploymentIncomePage(),
                              ),
                            );
                        // }
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

  Widget _buildTextField(TextEditingController controller, String hint, TextInputType type, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      maxLines: maxLines,
      validator: (value) {
        if (hint == 'John Doe' && (value == null || value.isEmpty)) return 'Full Name is required';
        if (hint == 'johndoe@gmail.com' && (value == null || value.isEmpty)) return 'Email is required';
        if (hint == 'Enter your full street address, apartment number, city, and state' && (value == null || value.isEmpty)) return 'Address is required';
        if (hint == 'Enter partner name' && _status == 'Married' && (value == null || value.isEmpty)) return 'Partner Name is required';
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFBDBDBD), fontFamily: 'Poppins'),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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

  Widget _buildDateField(BuildContext context) {
    return TextFormField(
      controller: _dobController,
      readOnly: true,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Date of Birth is required';
        return null;
      },
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime(2000, 1, 1),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          _dobController.text = "${picked.month.toString().padLeft(2, '0')} / ${picked.day.toString().padLeft(2, '0')} / ${picked.year}";
        }
      },
      decoration: InputDecoration(
        hintText: 'mm  / dd  / yyyy',
        hintStyle: const TextStyle(color: Color(0xFFBDBDBD), fontFamily: 'Poppins'),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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
        suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFFBDBDBD)),
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButtonFormField<String>(
      value: _status,
      items: _statusOptions.map((status) {
        return DropdownMenuItem<String>(
          value: status,
          child: Text(status, style: const TextStyle(fontFamily: 'Poppins')),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _status = value!;
        });
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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

  Widget _buildGenderSelector() {
    return Row(
      children: [
        _buildGenderButton('Male'),
        const SizedBox(width: 12),
        _buildGenderButton('Female'),
        const SizedBox(width: 12),
        _buildGenderButton('Other'),
      ],
    );
  }

  Widget _buildGenderButton(String gender) {
    final bool selected = _gender == gender;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _gender = gender;
          });
        },
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? const Color(0xFF2563EB) : const Color(0xFFBDBDBD),
              width: selected ? 2 : 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            gender,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: selected ? const Color(0xFF2563EB) : const Color(0xFF222222),
            ),
          ),
        ),
      ),
    );
  }
}
