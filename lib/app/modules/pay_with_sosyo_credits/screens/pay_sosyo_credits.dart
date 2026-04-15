import 'package:fast_sosyo/app/modules/pay_with_sosyo_credits/screens/pay_with_sosyo_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fast_sosyo/app/modules/pay_with_sosyo_credits/controller/pay_sosyo_credits_controller.dart';

class PaySosyoCreditsScreen extends StatefulWidget {
  const PaySosyoCreditsScreen({super.key});

  @override
  State<PaySosyoCreditsScreen> createState() => _PaySosyoCreditsScreenState();
}

class _PaySosyoCreditsScreenState extends State<PaySosyoCreditsScreen> {
  late final PaySosyoCreditsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PaySosyoCreditsController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F6FF),
      appBar: appBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _controller.formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Step 1 of 2',
                        style: TextStyle(
                          color: Color(0xFF2B3138),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: const LinearProgressIndicator(
                          minHeight: 12,
                          value: 0.5,
                          backgroundColor: Colors.white,
                          color: Color(0xFF2F60C8),
                        ),
                      ),
                      const SizedBox(height: 34),
                      const Text(
                        'Add important details',
                        style: TextStyle(
                          color: Color(0xFF2B3138),
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          height: 1.05,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Please provide the required details to successfully\nprocess your order using sosyo loan.',
                        style: TextStyle(
                          color: Color(0xFF8A8F96),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 26),
                      _buildDropdownField(
                        label: 'Principal',
                        value: _controller.principal.isEmpty
                            ? null
                            : _controller.principal,
                        hintText: 'Select principal',
                        options: _controller.principalOptions,
                        onChanged: _controller.setPrincipal,
                        validator: (String? value) {
                          if ((value ?? '').isEmpty) {
                            return 'Principal is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      _buildDropdownField(
                        label: 'Distributor',
                        value: _controller.distributor.isEmpty
                            ? null
                            : _controller.distributor,
                        hintText: 'Select distributor',
                        options: _controller.distributorOptions,
                        onChanged: _controller.setDistributor,
                        validator: (String? value) {
                          if ((value ?? '').isEmpty) {
                            return 'Distributor is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      _buildTextField(
                        label: 'Salesman Name',
                        controller: _controller.salesmanNameController,
                        hintText: 'Enter salesman name',
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z\s.\-']"),
                          ),
                        ],
                        validator: (String? value) {
                          if ((value ?? '').trim().isEmpty) {
                            return 'Salesman name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      _buildTextField(
                        label: 'Receipt Number',
                        controller: _controller.receiptNumberController,
                        hintText: 'Enter receipt number',
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]'),
                          ),
                        ],
                        validator: (String? value) {
                          if ((value ?? '').trim().isEmpty) {
                            return 'Receipt number is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      _buildTextField(
                        label: 'Address',
                        controller: _controller.addressController,
                        hintText:
                            'Enter your full street address, apartment\nnumber, city, and state',
                        maxLines: 4,
                        keyboardType: TextInputType.streetAddress,
                        validator: (String? value) {
                          if ((value ?? '').trim().isEmpty) {
                            return 'Address is required';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(24, 0, 24, 15),
        child: SizedBox(
          height: 64,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F60C8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              elevation: 0,
            ),
            onPressed: () {
              if (!_controller.validate()) {
                return;
              }

              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return PayWithSosyoTransactionScreen(
                      importantDetails: _controller.model,
                    );
                  },
                ),
              );
            },
            child: const Text(
              'Proceed',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Pay with Sosyo Credits',
        style: TextStyle(
          color: Color(0xFF2B3138),
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required String hintText,
    required List<String> options,
    required ValueChanged<String> onChanged,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          isDense: true,
          alignment: AlignmentDirectional.centerStart,
          hint: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              hintText,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color(0xFF8A8F96),
                fontSize: 17,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          items: options.map((String status) {
            return DropdownMenuItem<String>(
              value: status,
              child: Text(
                status,
                style: const TextStyle(fontFamily: 'Poppins'),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              onChanged(newValue);
              setState(() {});
            }
          },
          validator: validator,
          decoration: InputDecoration(
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE53935)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE53935)),
            ),
            hintText: null,
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFFBDBDBD),
          ),
          dropdownColor: Colors.white,
          style: const TextStyle(
            color: Color(0xFF2B3138),
            fontSize: 17,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          inputFormatters: inputFormatters,
          style: const TextStyle(
            color: Color(0xFF2B3138),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          decoration: _fieldDecoration(hintText),
        ),
      ],
    );
  }

  Widget _buildLabel(String label) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(
              color: Color(0xFF2B3138),
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
          const TextSpan(
            text: ' *',
            style: TextStyle(
              color: Color(0xFFE53935),
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _fieldDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color(0xFF8A8F96),
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF2563EB)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE53935)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE53935)),
      ),
    );
  }
}
