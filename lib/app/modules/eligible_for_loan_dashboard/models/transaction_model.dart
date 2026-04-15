import 'package:flutter/material.dart';

class TransactionModel {
  const TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.status,
    required this.iconPath,
    required this.transactionType,
  });

  final String id;
  final String title;
  final double amount;
  final String date;
  final String status;
  final String iconPath;
  final TransactionType transactionType;

  static List<TransactionModel> getSampleTransactions() {
    return [
      TransactionModel(
        id: '1',
        title: 'Upcoming Payment',
        amount: 307.02,
        date: 'June 15, 2026',
        status: 'UPCOMING',
        iconPath: 'assets/icons/upcoming-payment-icon.svg',
        transactionType: TransactionType.upcoming,
      ),
      TransactionModel(
        id: '2',
        title: 'Extra Payment',
        amount: 307.02,
        date: 'May 21, 2026',
        status: 'SUCCESS',
        iconPath: 'assets/icons/recent-transaction-success.svg',
        transactionType: TransactionType.successTransaction,
      ),
      TransactionModel(
        id: '3',
        title: 'Extra Payment',
        amount: 67.67,
        date: 'May 21, 2026',
        status: 'SUCCESS',
        iconPath: 'assets/icons/extra-payment-but-blue.svg',
        transactionType: TransactionType.extraPayment,
      ),
    ];
  }
}

enum TransactionType {
  upcoming,
  extraPayment,
  successTransaction,
}

extension TransactionTypeExtension on TransactionType {
  String get displayName {
    switch (this) {
      case TransactionType.upcoming:
        return 'Upcoming Payment';
      case TransactionType.extraPayment:
        return 'Extra Payment';
      case TransactionType.successTransaction:
        return 'Successful Transaction';
    }
  }

  Color get statusColor {
    switch (this) {
      case TransactionType.upcoming:
        return const Color(0xFFFF9800); // Orange
      case TransactionType.extraPayment:
        return const Color(0xFF4CAF50); // Green
      case TransactionType.successTransaction:
        return const Color(0xFF2196F3); // Blue
    }
  }
}
