import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import '../../success_eligibility/screens/loan_success_screen.dart';

class VerifyPerson extends StatefulWidget {
  const VerifyPerson({super.key, required this.userFullName});

  final String userFullName;

  @override
  State<VerifyPerson> createState() => _VerifyPersonState();
}

class _VerifyPersonState extends State<VerifyPerson>
    with SingleTickerProviderStateMixin {  // ← required for AnimationController vsync
  int _seconds = 5;
  Timer? _timer;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 1) {
        timer.cancel();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoanSuccessfulPage(
              userFullName: widget.userFullName,
            ),
          ),
        );
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                final scale = 1 + 0.08 * (_animationController.value - 0.5).abs();
                final rotation = 0.08 * (_animationController.value - 0.5);
                return Transform.rotate(
                  angle: rotation,
                  child: Transform.scale(
                    scale: scale,
                    child: child,
                  ),
                );
              },
              child: SvgPicture.asset(
                'assets/icons/verify-person-icon.svg',
                height: 220,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Verifying your Account',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'Your information is currently being reviewed.\nPlease wait while we complete the verification process.',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black45,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}