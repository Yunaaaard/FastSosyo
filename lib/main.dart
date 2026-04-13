import 'package:fast_sosyo/app/modules/eligible_for_loan/screen/review_your_loan.dart';
import 'package:fast_sosyo/app/modules/landing_page/landing_screen.dart';
import 'package:fast_sosyo/app/modules/register_number_page/register_number_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fast Sosyo',
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: const Landingscreen(),
      routes: {
        '/RegisterNumber': (context) => const RegisterNumberPage(),
      },
    );
  }
}