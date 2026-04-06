import 'dart:convert';

class AboutYourselfModel {
  const AboutYourselfModel({
    required this.fullName,
    required this.email,
    required this.dateOfBirth,
    required this.status,
    required this.gender,
    required this.permanentAddress,
    this.partnerName,
  });

  final String fullName;
  final String email;
  final String dateOfBirth;
  final String status;
  final String gender;
  final String permanentAddress;
  final String? partnerName;

  AboutYourselfModel copyWith({
    String? fullName,
    String? email,
    String? dateOfBirth,
    String? status,
    String? gender,
    String? permanentAddress,
    String? partnerName,
  }) {
    return AboutYourselfModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      status: status ?? this.status,
      gender: gender ?? this.gender,
      permanentAddress: permanentAddress ?? this.permanentAddress,
      partnerName: partnerName ?? this.partnerName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'status': status,
      'gender': gender,
      'permanentAddress': permanentAddress,
      'partnerName': partnerName,
    };
  }

  factory AboutYourselfModel.fromMap(Map<String, dynamic> map) {
    return AboutYourselfModel(
      fullName: map['fullName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      dateOfBirth: map['dateOfBirth'] as String? ?? '',
      status: map['status'] as String? ?? 'Single',
      gender: map['gender'] as String? ?? '',
      permanentAddress: map['permanentAddress'] as String? ?? '',
      partnerName: map['partnerName'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory AboutYourselfModel.fromJson(String source) =>
      AboutYourselfModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
