import 'dart:convert';

class PaySosyoCreditsFlowModel {
  const PaySosyoCreditsFlowModel({
    required this.principal,
    required this.distributor,
    required this.salesmanName,
    required this.receiptNumber,
    required this.address,
  });

  final String principal;
  final String distributor;
  final String salesmanName;
  final String receiptNumber;
  final String address;

  PaySosyoCreditsFlowModel copyWith({
    String? principal,
    String? distributor,
    String? salesmanName,
    String? receiptNumber,
    String? address,
  }) {
    return PaySosyoCreditsFlowModel(
      principal: principal ?? this.principal,
      distributor: distributor ?? this.distributor,
      salesmanName: salesmanName ?? this.salesmanName,
      receiptNumber: receiptNumber ?? this.receiptNumber,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'principal': principal,
      'distributor': distributor,
      'salesmanName': salesmanName,
      'receiptNumber': receiptNumber,
      'address': address,
    };
  }

  factory PaySosyoCreditsFlowModel.fromMap(Map<String, dynamic> map) {
    return PaySosyoCreditsFlowModel(
      principal: map['principal'] as String? ?? '',
      distributor: map['distributor'] as String? ?? '',
      salesmanName: map['salesmanName'] as String? ?? '',
      receiptNumber: map['receiptNumber'] as String? ?? '',
      address: map['address'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaySosyoCreditsFlowModel.fromJson(String source) {
    return PaySosyoCreditsFlowModel.fromMap(
      json.decode(source) as Map<String, dynamic>,
    );
  }
}
