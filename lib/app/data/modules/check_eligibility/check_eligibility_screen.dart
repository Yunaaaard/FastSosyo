

import 'package:flutter/material.dart';
import '../get_basic_information/screens/upload_id_screen.dart';

class CheckEligibilityPage extends StatelessWidget {
	const CheckEligibilityPage({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: const Color(0xFFF7FAFF),
			appBar: appBar(),
			body: SingleChildScrollView(
				child: Padding(
					padding: const EdgeInsets.symmetric(horizontal: 16.0),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							const SizedBox(height: 8),
							const Text(
								'GOOD DAY!',
								style: TextStyle(
									color: Color(0xFF64748B),
									fontWeight: FontWeight.bold,
									fontSize: 16,
									letterSpacing: 1.1,
								),
							),
							const SizedBox(height: 6),
							const Text(
								'Welcome to Sosyo Loan',
								style: TextStyle(
									color: Colors.black,
									fontWeight: FontWeight.bold,
									fontSize: 26,
								),
							),
							const SizedBox(height: 18),
							// Blue Card
							Container(
								width: double.infinity,
								decoration: BoxDecoration(
									color: Color(0xFF275DCE),
									borderRadius: BorderRadius.circular(18),
								),
								child: Padding(
									padding: const EdgeInsets.all(22.0),
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: [
											Row(
												children: [
													Expanded(
														child: Text(
															'Unlock your financial potential. Check your eligibility in minutes.',
															style: const TextStyle(
																color: Colors.white,
																fontWeight: FontWeight.bold,
																fontSize: 26,
																height: 1.2,
															),
														),
													),
													Container(
														width: 70,
														height: 70,
														decoration: BoxDecoration(
															shape: BoxShape.circle,
															border: Border.all(color: Colors.white24, width: 2),
														),
													),
												],
											),
											const SizedBox(height: 24),
											SizedBox(
												width: double.infinity,
												child: ElevatedButton(
													style: ElevatedButton.styleFrom(
														backgroundColor: Colors.white,
														foregroundColor: const Color(0xFF275DCE),
														shape: RoundedRectangleBorder(
															borderRadius: BorderRadius.circular(12),
														),
														padding: const EdgeInsets.symmetric(vertical: 16),
													),
																								onPressed: () {
																									Navigator.push(
																										context,
																										MaterialPageRoute(
																											builder: (context) => const UploadIDScreen(),
																										),
																									);
																								},
													child: const Text(
														'Check My Eligibility',
														style: TextStyle(
															fontWeight: FontWeight.w600,
															fontSize: 17,
														),
													),
												),
											),
										],
									),
								),
							),
							const SizedBox(height: 28),
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: const [
									Text(
										'How to get your funds',
										style: TextStyle(
											color: Colors.black87,
											fontWeight: FontWeight.bold,
											fontSize: 20,
										),
									),
									Text(
										'3 SIMPLE STEPS',
										style: TextStyle(
											color: Color(0xFF275DCE),
											fontWeight: FontWeight.bold,
											fontSize: 13,
											letterSpacing: 1.1,
										),
									),
								],
							),
							const SizedBox(height: 12),
							// Steps
							_StepCard(
								number: 1,
								title: 'Configure Loan',
								subtitle: 'Choose your term and amount',
							),
							_StepCard(
								number: 2,
								title: 'Confirm Terms',
								subtitle: 'Review and e-sign the agreement',
							),
							_StepCard(
								number: 3,
								title: 'Receive Funds',
								subtitle: 'Credited instantly to your wallet',
							),
							const SizedBox(height: 28),
							const Text(
								'Why choose Fundora?',
								style: TextStyle(
									color: Colors.black87,
									fontWeight: FontWeight.bold,
									fontSize: 20,
								),
							),
							const SizedBox(height: 12),
							_ReasonCard(
								number: 1,
								title: 'Instant Approval',
								subtitle: 'Get feedback on your application within minutes, not days.',
							),
							_ReasonCard(
								number: 2,
								title: 'No Collateral',
								subtitle: 'Access credit without putting your assets at risk. High trust, low friction.',
							),
							_ReasonCard(
								number: 3,
								title: 'Flexible Terms',
								subtitle: 'Repayment schedules that align with your unique monthly cash flow.',
							),
							const SizedBox(height: 32),
						],
					),
				),
			),
			bottomNavigationBar: _BottomNavBar(selectedIndex: 0),
		);
	}

	AppBar appBar() {
	  return AppBar(
				backgroundColor: Colors.transparent,
				elevation: 0,
				centerTitle: true,
				title: const Text(
					'SOSYO LOAN',
					style: TextStyle(
						color: Color(0xFF275DCE),
						fontWeight: FontWeight.bold,
						fontSize: 20,
						letterSpacing: 1.2,
					),
				),
				automaticallyImplyLeading: false,
			);
	}
}

class _StepCard extends StatelessWidget {
	final int number;
	final String title;
	final String subtitle;
	const _StepCard({required this.number, required this.title, required this.subtitle});

	@override
	Widget build(BuildContext context) {
		return Container(
			margin: const EdgeInsets.only(bottom: 10),
			padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(14),
			),
			child: Row(
				children: [
					CircleAvatar(
						radius: 18,
						backgroundColor: const Color(0xFFE8F0FE),
						child: Text(
							number.toString(),
							style: const TextStyle(
								color: Color(0xFF275DCE),
								fontWeight: FontWeight.bold,
								fontSize: 18,
							),
						),
					),
					const SizedBox(width: 16),
					Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Text(
								title,
								style: const TextStyle(
									fontWeight: FontWeight.bold,
									fontSize: 16,
								),
							),
							const SizedBox(height: 2),
							Text(
								subtitle,
								style: const TextStyle(
									color: Colors.black54,
									fontSize: 14,
								),
							),
						],
					),
				],
			),
		);
	}
}

class _ReasonCard extends StatelessWidget {
	final int number;
	final String title;
	final String subtitle;
	const _ReasonCard({required this.number, required this.title, required this.subtitle});

	@override
	Widget build(BuildContext context) {
		return Container(
			margin: const EdgeInsets.only(bottom: 10),
			padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
			decoration: BoxDecoration(
				color: const Color(0xFFE8F0FE),
				borderRadius: BorderRadius.circular(14),
			),
			child: Row(
				children: [
					CircleAvatar(
						radius: 18,
						backgroundColor: Colors.white,
						child: Text(
							number.toString(),
							style: const TextStyle(
								color: Color(0xFF275DCE),
								fontWeight: FontWeight.bold,
								fontSize: 18,
							),
						),
					),
					const SizedBox(width: 16),
					Expanded(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text(
									title,
									style: const TextStyle(
										fontWeight: FontWeight.bold,
										fontSize: 16,
									),
								),
								const SizedBox(height: 2),
								Text(
									subtitle,
									style: const TextStyle(
										color: Colors.black54,
										fontSize: 14,
									),
								),
							],
						),
					),
				],
			),
		);
	}
}

class _BottomNavBar extends StatelessWidget {
	final int selectedIndex;
	const _BottomNavBar({required this.selectedIndex});

	@override
	Widget build(BuildContext context) {
		return BottomNavigationBar(
			currentIndex: selectedIndex,
			type: BottomNavigationBarType.fixed,
			selectedItemColor: const Color(0xFF275DCE),
			unselectedItemColor: Colors.black38,
			showUnselectedLabels: true,
			items: const [
				BottomNavigationBarItem(
					icon: Icon(Icons.home_rounded),
					label: 'Home',
				),
				BottomNavigationBarItem(
					icon: Icon(Icons.article_outlined),
					label: 'Loans',
				),
				BottomNavigationBarItem(
					icon: Icon(Icons.history),
					label: 'History',
				),
				BottomNavigationBarItem(
					icon: Icon(Icons.person_outline),
					label: 'Profile',
				),
			],
		);
	}
}
