import 'package:fast_sosyo/views/SelfieVerificationScreen.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class UploadIDScreen extends StatelessWidget {
	const UploadIDScreen({Key? key}) : super(key: key);

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
									valueColor: AlwaysStoppedAnimation(Color(0xFF2563EB)),
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
									padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
									decoration: BoxDecoration(
										color: Colors.white,
										borderRadius: BorderRadius.circular(12),
										border: Border.all(color: Color(0xFFE0E0E0)),
									),
									child: DropdownButtonHideUnderline(
										child: DropdownButton<String>(
											value: 'National ID',
											items: const [
												DropdownMenuItem(
													value: 'National ID',
													child: Text('National ID'),
												),
												DropdownMenuItem(
													value: 'Passport',
													child: Text('Passport'),
												),
												DropdownMenuItem(
													value: 'Driver License',
													child: Text('Driver License'),
												),
											],
											onChanged: (value) {},
										),
									),
								),
								const SizedBox(height: 24),
								DottedBorder(
									color: const Color(0xFF2563EB),
									strokeWidth: 2,
									dashPattern: [8, 6],
									borderType: BorderType.RRect,
									radius: const Radius.circular(16),
									child: Container(
										width: double.infinity,
										padding: const EdgeInsets.symmetric(vertical: 32),
										child: Column(
											children: [
												Icon(Icons.camera_alt_outlined, size: 40, color: Color(0xFF2563EB)),
												const SizedBox(height: 12),
												const Text(
													'Front of ID',
													style: TextStyle(
														fontFamily: 'Poppins',
														fontWeight: FontWeight.w600,
														fontSize: 18,
														color: Color(0xFF222222),
													),
												),
												const SizedBox(height: 4),
												const Text(
													'PNG, JPG or PDF up to 10MB',
													style: TextStyle(
														fontFamily: 'Poppins',
														fontWeight: FontWeight.w400,
														fontSize: 13,
														color: Color(0xFF8B8B8B),
													),
												),
											],
										),
									),
								),
								const SizedBox(height: 24),
								DottedBorder(
									color: const Color(0xFF2563EB),
									strokeWidth: 2,
									dashPattern: [8, 6],
									borderType: BorderType.RRect,
									radius: const Radius.circular(16),
									child: Container(
										width: double.infinity,
										padding: const EdgeInsets.symmetric(vertical: 32),
										child: Column(
											children: [
												Icon(Icons.camera_alt_outlined, size: 40, color: Color(0xFF2563EB)),
												const SizedBox(height: 12),
												const Text(
													'Back of ID',
													style: TextStyle(
														fontFamily: 'Poppins',
														fontWeight: FontWeight.w600,
														fontSize: 18,
														color: Color(0xFF222222),
													),
												),
												const SizedBox(height: 4),
												const Text(
													'PNG, JPG or PDF up to 10MB',
													style: TextStyle(
														fontFamily: 'Poppins',
														fontWeight: FontWeight.w400,
														fontSize: 13,
														color: Color(0xFF8B8B8B),
													),
												),
											],
										),
									),
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
																									Navigator.push(
																										context,
																										MaterialPageRoute(
																											builder: (context) => const SelfieVerificationScreen(),
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
					fontWeight: FontWeight.w600, // SemiBold
					color: Colors.black,
					fontSize: 20,
				),
			),
			automaticallyImplyLeading: false,
		);
	}
}
