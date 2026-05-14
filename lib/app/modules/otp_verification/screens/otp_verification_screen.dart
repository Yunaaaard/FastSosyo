import 'package:fast_sosyo/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({
    super.key,
    this.title = 'OTP Verification',
    this.recipientLabel = '+93 9453482113',
    this.continueLabel = 'Continue',
    this.onVerifyOtp,
    this.onVerified,
    this.onResend,
  });

  final String title;
  final String recipientLabel;
  final String continueLabel;
  final Future<bool> Function(String otp)? onVerifyOtp;
  final Future<void> Function(BuildContext context, String otp)? onVerified;
  final VoidCallback? onResend;

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final FocusNode _focusNode = FocusNode();
  bool _isVerifying = false;
  String? _errorText;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextField(
        controller: _controllers[index],
        focusNode: index == 0 ? _focusNode : null,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD6D6D6), width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD6D6D6), width: 1.5),
          ),
        ),
        onChanged: (value) {
          if (_errorText != null) {
            setState(() {
              _errorText = null;
            });
          }
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }

  String _readOtp() {
    return _controllers.map((TextEditingController c) => c.text.trim()).join();
  }

  Future<void> _submitOtp() async {
    if (_isVerifying) {
      return;
    }

    final String otp = _readOtp();
    if (otp.length != 6 || otp.contains(RegExp(r'[^0-9]'))) {
      setState(() {
        _errorText = 'Enter the 6-digit code to continue.';
      });
      return;
    }

    setState(() {
      _isVerifying = true;
      _errorText = null;
    });

    try {
      bool isValid = true;
      if (widget.onVerifyOtp != null) {
        isValid = await widget.onVerifyOtp!(otp);
      }

      if (!mounted) {
        return;
      }

      if (!isValid) {
        setState(() {
          _errorText = 'Invalid OTP. Please try again.';
        });
        return;
      }

      if (widget.onVerified != null) {
        await widget.onVerified!(context, otp);
      } else {
        Get.toNamed(Routes.dashboard);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.zero,
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        SvgPicture.asset(
                          'assets/images/OtpVerificationPerson.svg',
                          height: 220,
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Enter OTP sent to ',
                                  style: TextStyle(fontFamily: 'Poppins'),
                                ),
                                TextSpan(
                                  text: widget.recipientLabel,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF275DCE),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(6, (i) {
                            return Padding(
                              padding: EdgeInsets.only(right: i < 5 ? 12 : 0),
                              child: _buildOtpBox(i),
                            );
                          }),
                        ),
                        if (_errorText != null) ...[
                          const SizedBox(height: 14),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Text(
                              _errorText!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "You didn't receive any code? ",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                              GestureDetector(
                                onTap: widget.onResend,
                                child: const Text(
                                  'RESEND',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF275DCE),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF275DCE),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: _isVerifying ? null : _submitOtp,
                              child: _isVerifying
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      widget.continueLabel,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
