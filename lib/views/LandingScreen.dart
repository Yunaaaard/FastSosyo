import 'package:flutter/material.dart';

class Landingscreen extends StatefulWidget {
  const Landingscreen({super.key});

  @override
  State<Landingscreen> createState() => _LandingscreenState();
}

class _LandingscreenState extends State<Landingscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fast Sosyo'),
      ),
      body: const Center(
        child: Text('Welcome to Fast Sosyo!'),
      ),
    );
  }
}