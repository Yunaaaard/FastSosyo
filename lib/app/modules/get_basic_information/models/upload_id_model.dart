import 'dart:convert';

class UploadIdModel {
  const UploadIdModel({
    required this.idType,
    this.frontIdPath,
    this.backIdPath,
  });

  final String idType;
  final String? frontIdPath;
  final String? backIdPath;

  bool get isComplete =>
      frontIdPath != null &&
      frontIdPath!.isNotEmpty &&
      backIdPath != null &&
      backIdPath!.isNotEmpty;

  UploadIdModel copyWith({
    String? idType,
    String? frontIdPath,
    String? backIdPath,
  }) {
    return UploadIdModel(
      idType: idType ?? this.idType,
      frontIdPath: frontIdPath ?? this.frontIdPath,
      backIdPath: backIdPath ?? this.backIdPath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idType': idType,
      'frontIdPath': frontIdPath,
      'backIdPath': backIdPath,
    };
  }

  factory UploadIdModel.fromMap(Map<String, dynamic> map) {
    return UploadIdModel(
      idType: map['idType'] as String? ?? 'National ID',
      frontIdPath: map['frontIdPath'] as String?,
      backIdPath: map['backIdPath'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadIdModel.fromJson(String source) =>
      UploadIdModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
