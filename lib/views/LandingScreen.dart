import 'package:flutter/material.dart';

class Landingscreen extends StatefulWidget {
  const Landingscreen({super.key});

  @override
  State<Landingscreen> createState() => _LandingscreenState();
}

class _LandingscreenState extends State<Landingscreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;
  final String _title = 'FASTSOSYO';
  int _visibleLetters = 0;
  bool _logoVisible = false;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000), // Slower fade-in
    );
    _logoAnimation = CurvedAnimation(parent: _logoController, curve: Curves.easeIn);
    _logoController.forward();
    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _logoVisible = true;
        });
        _startLetterAnimation();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 7), () {
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/RegisterNumber');
        }
      });
    });
  }

  void _startLetterAnimation() async {
    for (int i = 1; i <= _title.length; i++) {
      await Future.delayed(const Duration(milliseconds: 300)); // Slower pop-up
      if (!mounted) return;
      setState(() {
        _visibleLetters = i;
      });
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo stays in a fixed position with a fixed height
            SizedBox(
              height: 180,
              child: Center(
                child: FadeTransition(
                  opacity: _logoAnimation,
                  child: Image.asset(
                    'assets/images/FastSosyo.png',
                    width: 240,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: _logoVisible
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_visibleLetters, (i) {
                        return TweenAnimationBuilder<double>(
                          key: ValueKey(i),
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.elasticOut,
                          builder: (context, scale, child) {
                            return Transform.scale(
                              scale: scale,
                              child: child,
                            );
                          },
                          child: Text(
                            _title[i],
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 32,
                              color: Color(0xFF0000BC),
                              letterSpacing: 6,
                            ),
                          ),
                        );
                      }),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}