import 'package:fast_sosyo/app/modules/success_eligibility/models/loan_success_content_model.dart';
import 'package:fast_sosyo/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:confetti/confetti.dart';
import 'package:get/get.dart';

class LoanSuccessfulPage extends StatefulWidget {
  const LoanSuccessfulPage({super.key, required this.userFullName});

  final String userFullName;

  @override
  State<LoanSuccessfulPage> createState() => _LoanSuccessfulPageState();
}

class _LoanSuccessfulPageState extends State<LoanSuccessfulPage> {
  static const LoanSuccessContentModel _content = LoanSuccessContentModel(
    title: "You're Eligible!",
    subtitle: "We reviewed your account and you're ready to grow",
    maximumLoanLimit: 25000,
    interestRateLabel: '1.59% /mo',
    paymentTermLabel: '12 Months',
    secureBankingTitle: 'Secure Banking',
    secureBankingDescription:
        'Funds are protected by the industry-leading encryption and deposited directly to your digital vault.',
    proceedButtonLabel: 'PROCEED',
  );

  late ConfettiController _confettiControllerLeft;
  late ConfettiController _confettiControllerRight;

  @override
  void initState() {
    super.initState();
    _confettiControllerLeft = ConfettiController(duration: const Duration(seconds: 2));
    _confettiControllerRight = ConfettiController(duration: const Duration(seconds: 2));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _confettiControllerLeft.play();
      _confettiControllerRight.play();
    });
  }

  @override
  void dispose() {
    _confettiControllerLeft.dispose();
    _confettiControllerRight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FF),
      body: SafeArea(
        child: Stack(
          children: [
            // Main content first (bottom layer)
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  SvgPicture.asset(
                    'assets/icons/loan-success-person-v2.svg',
                    height: 180,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    _content.title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      _content.subtitle,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black45,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
                    decoration: BoxDecoration(
                      color: Color(0xFF2563EB),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'MAXIMUM LOAN LIMIT',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 1.1,
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '\u20B1',
                                style: const TextStyle(
                                  fontFamily: 'Arial',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' ${_content.maximumLoanLimit.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Divider(color: Colors.white.withOpacity(0.4)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Interest Rate',
                                  style: TextStyle(color: Colors.white70, fontSize: 14),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  _content.interestRateLabel,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Payment Term',
                                  style: TextStyle(color: Colors.white70, fontSize: 14),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  _content.paymentTermLabel,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/secure-banking-icon.svg',
                          height: 32,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _content.secureBankingTitle,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                _content.secureBankingDescription,
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                      ),
                      onPressed: () {
                        Get.toNamed(
                          Routes.loanDetails,
                          arguments: widget.userFullName,
                        );
                      },
                      child: Text(
                        _content.proceedButtonLabel,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),

            // Confetti last (top layer — renders in front of everything)
            Align(
              alignment: Alignment.topLeft,
              child: ConfettiWidget(
                confettiController: _confettiControllerLeft,
                blastDirection: 0.8,
                emissionFrequency: 0.08,
                numberOfParticles: 12,
                maxBlastForce: 18,
                minBlastForce: 8,
                gravity: 0.25,
                colors: const [
                  Color(0xFF3B82F6),
                  Color(0xFF6366F1),
                  Color(0xFFF59E42),
                  Color(0xFF10B981),
                  Color(0xFFF43F5E),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: ConfettiWidget(
                confettiController: _confettiControllerRight,
                blastDirection: 2.4,
                emissionFrequency: 0.08,
                numberOfParticles: 12,
                maxBlastForce: 18,
                minBlastForce: 8,
                gravity: 0.25,
                colors: const [
                  Color(0xFF3B82F6),
                  Color(0xFF6366F1),
                  Color(0xFFF59E42),
                  Color(0xFF10B981),
                  Color(0xFFF43F5E),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
