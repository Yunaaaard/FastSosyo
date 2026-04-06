import 'dart:convert';

import 'package:fast_sosyo/app/modules/get_basic_information/models/about_yourself_model.dart';
import 'package:fast_sosyo/app/modules/get_basic_information/models/employment_income_model.dart';
import 'package:fast_sosyo/app/modules/get_basic_information/models/selfie_verification_model.dart';
import 'package:fast_sosyo/app/modules/get_basic_information/models/upload_id_model.dart';

class BasicInformationFlowModel {
  const BasicInformationFlowModel({
    required this.uploadId,
    required this.selfieVerification,
    required this.aboutYourself,
    required this.employmentIncome,
  });

  final UploadIdModel uploadId;
  final SelfieVerificationModel selfieVerification;
  final AboutYourselfModel aboutYourself;
  final EmploymentIncomeModel employmentIncome;

  BasicInformationFlowModel copyWith({
    UploadIdModel? uploadId,
    SelfieVerificationModel? selfieVerification,
    AboutYourselfModel? aboutYourself,
    EmploymentIncomeModel? employmentIncome,
  }) {
    return BasicInformationFlowModel(
      uploadId: uploadId ?? this.uploadId,
      selfieVerification: selfieVerification ?? this.selfieVerification,
      aboutYourself: aboutYourself ?? this.aboutYourself,
      employmentIncome: employmentIncome ?? this.employmentIncome,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uploadId': uploadId.toMap(),
      'selfieVerification': selfieVerification.toMap(),
      'aboutYourself': aboutYourself.toMap(),
      'employmentIncome': employmentIncome.toMap(),
    };
  }

  factory BasicInformationFlowModel.fromMap(Map<String, dynamic> map) {
    return BasicInformationFlowModel(
      uploadId: UploadIdModel.fromMap(
        (map['uploadId'] as Map<String, dynamic>?) ?? <String, dynamic>{},
      ),
      selfieVerification: SelfieVerificationModel.fromMap(
        (map['selfieVerification'] as Map<String, dynamic>?) ??
            <String, dynamic>{},
      ),
      aboutYourself: AboutYourselfModel.fromMap(
        (map['aboutYourself'] as Map<String, dynamic>?) ?? <String, dynamic>{},
      ),
      employmentIncome: EmploymentIncomeModel.fromMap(
        (map['employmentIncome'] as Map<String, dynamic>?) ??
            <String, dynamic>{},
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory BasicInformationFlowModel.fromJson(String source) =>
      BasicInformationFlowModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
