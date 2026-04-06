import 'dart:io';

import 'package:fast_sosyo/app/modules/get_basic_information/controller/basic_information_flow_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fast_sosyo/app/modules/get_basic_information/controller/upload_id_controller.dart';
import 'package:fast_sosyo/app/modules/get_basic_information/screens/selfie_verification_screen.dart';
import 'package:flutter/material.dart';

class UploadIDScreen extends StatefulWidget {
  const UploadIDScreen({Key? key, this.flowController}) : super(key: key);

  final BasicInformationFlowController? flowController;

  @override
  State<UploadIDScreen> createState() => _UploadIDScreenState();
}

class _UploadIDScreenState extends State<UploadIDScreen> {
  late final BasicInformationFlowController _flowController;
  late final UploadIdController _controller;
  late final bool _ownsFlowController;
  final List<String> _idTypes = const [
    'National ID',
    'Passport',
    'Driver License'
  ];

  @override
  void initState() {
    super.initState();
    _ownsFlowController = widget.flowController == null;
    _flowController = widget.flowController ?? BasicInformationFlowController();
    _controller = _flowController.uploadIdController;
  }

  Future<void> _pickFrontId() async {
    setState(() {});
    final String? errorMessage = await _controller.pickFrontId();
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

  Future<void> _pickBackId() async {
    setState(() {});
    final String? errorMessage = await _controller.pickBackId();
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

  Widget _buildUploadCard({
    required String title,
    required File? selectedFile,
    required bool isLoading,
    required VoidCallback onTap,
  }) {
    final String fileName = selectedFile?.uri.pathSegments.last ?? '';

    return DottedBorder(
      color: const Color(0xFF2563EB),
      strokeWidth: 2,
      dashPattern: const [8, 6],
      padding: const EdgeInsets.all(2),
      borderType: BorderType.RRect,
      radius: const Radius.circular(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Material(
          color: Colors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
              child: Column(
                children: [
                  if (isLoading)
                    const SizedBox(
                      width: 34,
                      height: 34,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Color(0xFF2563EB),
                      ),
                    )
                  else
                    Icon(
                      selectedFile == null
                          ? Icons.camera_alt_outlined
                          : Icons.check_circle,
                      size: 40,
                      color: selectedFile == null
                          ? const Color(0xFF2563EB)
                          : const Color(0xFF16A34A),
                    ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color(0xFF222222),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedFile == null
                        ? 'PNG, JPG or PDF up to 10MB'
                        : fileName,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: selectedFile == null
                          ? const Color(0xFF8B8B8B)
                          : const Color(0xFF2563EB),
                    ),
                  ),
                  if (selectedFile != null)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        'Tap to replace',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color(0xFF8B8B8B),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
                  'Step 1 of 4',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 0.25,
                  backgroundColor: const Color(0xFFD6E4FF),
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF2563EB)),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(8),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Upload your Government ID',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please take a clear photo of your government-issued ID card. Ensure all details are legible and within the frame.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Color(0xFF8B8B8B),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Select ID Type',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _controller.model.idType,
                      items: _idTypes
                          .map(
                            (idType) => DropdownMenuItem<String>(
                              value: idType,
                              child: Text(idType),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }

                        setState(() {
                          _controller.setIdType(value);
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildUploadCard(
                  title: 'Front of ID',
                  selectedFile: _controller.frontIdFile,
                  isLoading: _controller.isPickingFront,
                  onTap: _pickFrontId,
                ),
                const SizedBox(height: 24),
                _buildUploadCard(
                  title: 'Back of ID',
                  selectedFile: _controller.backIdFile,
                  isLoading: _controller.isPickingBack,
                  onTap: _pickBackId,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Your data is encrypted and only used for identity verification purposes.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFF8B8B8B),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (!_controller.canContinue) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Please upload both front and back of your ID.'),
                          ),
                        );
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelfieVerificationScreen(
                              flowController: _flowController),
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
                const SizedBox(height: 24),
              ],
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
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      automaticallyImplyLeading: false,
    );
  }
}
