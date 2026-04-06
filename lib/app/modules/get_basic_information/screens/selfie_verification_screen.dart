import 'package:fast_sosyo/app/modules/get_basic_information/controller/basic_information_flow_controller.dart';
import 'package:fast_sosyo/app/modules/get_basic_information/controller/selfie_verification_controller.dart';
import 'package:fast_sosyo/app/modules/get_basic_information/screens/about_yourself_screen.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class SelfieVerificationScreen extends StatefulWidget {
  const SelfieVerificationScreen({Key? key, this.flowController})
      : super(key: key);

  final BasicInformationFlowController? flowController;

  @override
  State<SelfieVerificationScreen> createState() =>
      _SelfieVerificationScreenState();
}

class _SelfieVerificationScreenState extends State<SelfieVerificationScreen> {
  late final BasicInformationFlowController _flowController;
  late final SelfieVerificationController _controller;
  late final bool _ownsFlowController;

  @override
  void initState() {
    super.initState();
    _ownsFlowController = widget.flowController == null;
    _flowController = widget.flowController ?? BasicInformationFlowController();
    _controller = _flowController.selfieVerificationController;
  }

  Future<void> _startLivenessCheck() async {
    if (_controller.isCapturing) {
      return;
    }

    setState(() {});

    final String? errorMessage = await _controller.captureSelfie();
    if (!mounted) {
      return;
    }

    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }

    setState(() {});
  }

  @override
  void dispose() {
    if (_ownsFlowController) {
      _flowController.dispose();
    }
    super.dispose();
  }

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
                      child: ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _startLivenessCheck,
                            child: SizedBox(
                              width: 350,
                              height: 350,
                              child: _controller.selfieFile == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (_controller.isCapturing)
                                          const SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 3,
                                              color: Color(0xFF2563EB),
                                            ),
                                          )
                                        else
                                          const Icon(
                                            Icons.camera_alt_outlined,
                                            size: 40,
                                            color: Color(0xFF2563EB),
                                          ),
                                        const SizedBox(height: 16),
                                        Text(
                                          _controller.isCapturing
                                              ? 'Opening Camera...'
                                              : 'Start Liveness Check',
                                          style: const TextStyle(
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
                                    )
                                  : Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.file(_controller.selfieFile!,
                                            fit: BoxFit.cover),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_controller.selfieFile != null)
              GestureDetector(
                onTap: _startLivenessCheck,
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Retake',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2563EB),
                    ),
                  ),
                ),
              ),
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
                  if (!_controller.canContinue) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Please complete selfie verification first.'),
                      ),
                    );
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AboutYourselfPage(flowController: _flowController),
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
          ],
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
