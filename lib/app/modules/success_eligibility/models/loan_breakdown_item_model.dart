import 'package:flutter/material.dart';

class LoanBreakdownItemModel {
  const LoanBreakdownItemModel({
    required this.label,
    required this.value,
    this.isBold = false,
    this.hasPeso = false,
    this.valueColor = Colors.black87,
  });

  final String label;
  final String value;
  final bool isBold;
  final bool hasPeso;
  final Color valueColor;
}
