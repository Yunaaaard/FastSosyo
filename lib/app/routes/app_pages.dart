import 'package:fast_sosyo/app/modules/check_eligibility/check_eligibility_screen.dart';
import 'package:fast_sosyo/app/modules/dashboard_page/bindings/dashboard_binding.dart';
import 'package:fast_sosyo/app/modules/dashboard_page/screen/dashboard_screen.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/bindings/loan_order_binding.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/screen/order_loan_dashboard.dart';
import 'package:fast_sosyo/app/modules/get_basic_information/bindings/basic_information_binding.dart';
import 'package:fast_sosyo/app/modules/get_basic_information/screens/upload_id_screen.dart';
import 'package:fast_sosyo/app/modules/landing_page/landing_screen.dart';
import 'package:fast_sosyo/app/modules/otp_verification/screens/otp_verification_screen.dart';
import 'package:fast_sosyo/app/modules/pay_with_sosyo_credits/bindings/pay_sosyo_credits_binding.dart';
import 'package:fast_sosyo/app/modules/pay_with_sosyo_credits/models/pay_sosyo_credits_flow_model.dart';
import 'package:fast_sosyo/app/modules/pay_with_sosyo_credits/screens/pay_sosyo_credits.dart';
import 'package:fast_sosyo/app/modules/pay_with_sosyo_credits/screens/pay_with_sosyo_transaction.dart';
import 'package:fast_sosyo/app/modules/register_number_page/register_number_screen.dart';
import 'package:fast_sosyo/app/modules/success_eligibility/bindings/loan_details_binding.dart';
import 'package:fast_sosyo/app/modules/success_eligibility/screens/loan_details_screen.dart';
import 'package:fast_sosyo/app/modules/success_eligibility/screens/loan_success_screen.dart';
import 'package:fast_sosyo/app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static const initial = Routes.landing;

  static final routes = <GetPage<dynamic>>[
    GetPage(
      name: Routes.landing,
      page: () => const Landingscreen(),
    ),
    GetPage(
      name: Routes.registerNumber,
      page: () => const RegisterNumberPage(),
    ),
    GetPage( 
      name: Routes.otpVerification,
      page: () => const OtpVerificationPage(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.checkEligibility,
      page: () => const CheckEligibilityPage(),
    ),
    GetPage(
      name: Routes.basicUploadId,
      page: () => const UploadIDScreen(),
      binding: BasicInformationBinding(),
    ),
    GetPage(
      name: Routes.paySosyoCredits,
      page: () => const PaySosyoCreditsScreen(),
      binding: PaySosyoCreditsBinding(),
    ),
    GetPage(
      name: Routes.paySosyoTransaction,
      page: () {
        final args = Get.arguments;
        return PayWithSosyoTransactionScreen(
          importantDetails: args is PaySosyoCreditsFlowModel
              ? args
              : const PaySosyoCreditsFlowModel(
                  principal: '',
                  distributor: '',
                  salesmanName: '',
                  receiptNumber: '',
                  address: '',
                ),
        );
      },
      binding: PaySosyoCreditsBinding(),
    ),
    GetPage(
      name: Routes.orderLoan,
      page: () => const OrderLoanScreen(),
      binding: LoanOrderBinding(),
    ),
    GetPage(
      name: Routes.loanDetails,
      page: () => LoanDetailsScreen(
        userFullName: (Get.arguments as String?) ?? '',
      ),
      binding: LoanDetailsBinding(),
    ),
    GetPage(
      name: Routes.loanSuccess,
      page: () => LoanSuccessfulPage(
        userFullName: (Get.arguments as String?) ?? '',
      ),
    ),
  ];
}
