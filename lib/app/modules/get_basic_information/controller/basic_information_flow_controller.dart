import 'package:fast_sosyo/app/modules/get_basic_information/controller/about_yourself_controller.dart';
import 'package:fast_sosyo/app/modules/get_basic_information/controller/employment_income_controller.dart';
import 'package:fast_sosyo/app/modules/get_basic_information/controller/selfie_verification_controller.dart';
import 'package:fast_sosyo/app/modules/get_basic_information/controller/upload_id_controller.dart';
import 'package:fast_sosyo/app/modules/get_basic_information/models/about_yourself_model.dart';
import 'package:fast_sosyo/app/modules/get_basic_information/models/basic_information_flow_model.dart';
import 'package:fast_sosyo/app/modules/get_basic_information/models/employment_income_model.dart';
import 'package:fast_sosyo/app/modules/get_basic_information/models/selfie_verification_model.dart';
import 'package:fast_sosyo/app/modules/get_basic_information/models/upload_id_model.dart';
import 'package:get/get.dart';

class BasicInformationFlowController extends GetxController {
  BasicInformationFlowController({BasicInformationFlowModel? initialModel})
      : uploadIdController = UploadIdController(
          initialModel: initialModel?.uploadId,
        ),
        selfieVerificationController = SelfieVerificationController(
          initialModel: initialModel?.selfieVerification,
        ),
        aboutYourselfController = AboutYourselfController(
          initialModel: initialModel?.aboutYourself,
        ),
        employmentIncomeController = EmploymentIncomeController(
          initialModel: initialModel?.employmentIncome,
        );

  final UploadIdController uploadIdController;
  final SelfieVerificationController selfieVerificationController;
  final AboutYourselfController aboutYourselfController;
  final EmploymentIncomeController employmentIncomeController;

  BasicInformationFlowModel buildFlowModel() {
    aboutYourselfController.syncModelFromInputs();
    employmentIncomeController.syncModelFromInputs();

    return BasicInformationFlowModel(
      uploadId: uploadIdController.model,
      selfieVerification: selfieVerificationController.model,
      aboutYourself: aboutYourselfController.model,
      employmentIncome: employmentIncomeController.model,
    );
  }

  Map<String, dynamic> buildPayload() {
    return buildFlowModel().toMap();
  }

  bool get isAllStepsComplete {
    final UploadIdModel uploadId = uploadIdController.model;
    final SelfieVerificationModel selfie = selfieVerificationController.model;
    final AboutYourselfModel about = aboutYourselfController.model;
    final EmploymentIncomeModel employment = employmentIncomeController.model;

    final bool isAboutComplete = about.fullName.isNotEmpty &&
        about.email.isNotEmpty &&
        about.dateOfBirth.isNotEmpty &&
        about.permanentAddress.isNotEmpty;

    final bool isEmploymentComplete = employment.sourceOfIncome.isNotEmpty &&
        employment.monthlyIncome > 0 &&
        employment.personalDataConsentAccepted;

    return uploadId.isComplete &&
        selfie.isVerified &&
        isAboutComplete &&
        isEmploymentComplete;
  }

  @override
  void onClose() {
    uploadIdController.dispose();
    selfieVerificationController.dispose();
    aboutYourselfController.dispose();
    employmentIncomeController.dispose();
    super.onClose();
  }
}
