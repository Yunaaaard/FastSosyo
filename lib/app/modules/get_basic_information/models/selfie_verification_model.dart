import 'dart:convert';

class SelfieVerificationModel {
  const SelfieVerificationModel({
    this.selfiePath,
    this.isVerified = false,
  });

  final String? selfiePath;
  final bool isVerified;

  SelfieVerificationModel copyWith({
    String? selfiePath,
    bool? isVerified,
  }) {
    return SelfieVerificationModel(
      selfiePath: selfiePath ?? this.selfiePath,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'selfiePath': selfiePath,
      'isVerified': isVerified,
    };
  }

  factory SelfieVerificationModel.fromMap(Map<String, dynamic> map) {
    return SelfieVerificationModel(
      selfiePath: map['selfiePath'] as String?,
      isVerified: map['isVerified'] as bool? ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SelfieVerificationModel.fromJson(String source) =>
      SelfieVerificationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
