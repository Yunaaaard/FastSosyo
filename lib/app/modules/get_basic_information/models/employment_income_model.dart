import 'dart:convert';

class EmploymentIncomeModel {
  const EmploymentIncomeModel({
    required this.sourceOfIncome,
    required this.monthlyIncome,
    this.personalDataConsentAccepted = false,
    this.incomeTax,
    this.employerName,
    this.yearsOfEmployment,
  });

  final String sourceOfIncome;
  final double monthlyIncome;
  final bool personalDataConsentAccepted;
  final String? incomeTax;
  final String? employerName;
  final int? yearsOfEmployment;

  EmploymentIncomeModel copyWith({
    String? sourceOfIncome,
    double? monthlyIncome,
    bool? personalDataConsentAccepted,
    String? incomeTax,
    String? employerName,
    int? yearsOfEmployment,
  }) {
    return EmploymentIncomeModel(
      sourceOfIncome: sourceOfIncome ?? this.sourceOfIncome,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      personalDataConsentAccepted:
          personalDataConsentAccepted ?? this.personalDataConsentAccepted,
      incomeTax: incomeTax ?? this.incomeTax,
      employerName: employerName ?? this.employerName,
      yearsOfEmployment: yearsOfEmployment ?? this.yearsOfEmployment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sourceOfIncome': sourceOfIncome,
      'monthlyIncome': monthlyIncome,
      'personalDataConsentAccepted': personalDataConsentAccepted,
      'incomeTax': incomeTax,
      'employerName': employerName,
      'yearsOfEmployment': yearsOfEmployment,
    };
  }

  factory EmploymentIncomeModel.fromMap(Map<String, dynamic> map) {
    final dynamic monthlyIncomeValue = map['monthlyIncome'];
    return EmploymentIncomeModel(
      sourceOfIncome: map['sourceOfIncome'] as String? ?? '',
      monthlyIncome:
          monthlyIncomeValue is num ? monthlyIncomeValue.toDouble() : 0,
      personalDataConsentAccepted:
          map['personalDataConsentAccepted'] as bool? ?? false,
      incomeTax: map['incomeTax'] as String?,
      employerName: map['employerName'] as String?,
      yearsOfEmployment: map['yearsOfEmployment'] as int?,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmploymentIncomeModel.fromJson(String source) =>
      EmploymentIncomeModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
