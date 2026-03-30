import 'package:fast_sosyo/views/AboutYourself.dart';
import 'package:fast_sosyo/views/UploadIDScreen.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class SelfieVerificationScreen extends StatelessWidget {
  const SelfieVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAFF),
      appBar: appBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Step 2 of 4',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 0.5,
                  backgroundColor: const Color(0xFFD6E4FF),
                  valueColor: AlwaysStoppedAnimation(Color(0xFF2563EB)),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(8),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Selfie Verification',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ensure you are in a well-lit area and not wearing a hat or glass.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Color(0xFF8B8B8B),
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: DottedBorder(
                    color: const Color(0xFF2563EB),
                    strokeWidth: 2,
                    dashPattern: const [8, 6],
                    borderType: BorderType.Circle,
                    radius: const Radius.circular(180),
                    child: Container(
                      width: 350,
                      height: 350,
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt_outlined, size: 40, color: Color(0xFF2563EB)),
                          const SizedBox(height: 16),
                          const Text(
                            'Start Liveness Check',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Color(0xFF222222),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Position your face within the frame',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Color(0xFF8B8B8B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),                // The Continue button is now moved to bottomNavigationBar
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: SizedBox(
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
																									Navigator.push(
																										context,
																										MaterialPageRoute(
																											builder: (context) => const AboutYourselfPage(),
																										),
																									);
																								},
            child: const Text(
              'Continue',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Basic Information',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600, // SemiBold
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      automaticallyImplyLeading: false,
    );
  }
}
