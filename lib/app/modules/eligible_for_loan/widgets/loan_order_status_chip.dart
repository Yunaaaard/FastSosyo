import 'package:flutter/material.dart';

class LoanOrderStatusChip extends StatelessWidget {
  const LoanOrderStatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final _LoanOrderStatusStyle style = _styleForStatus(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: style.dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            style.label,
            style: TextStyle(
              color: style.textColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  _LoanOrderStatusStyle _styleForStatus(String rawStatus) {
    final String normalized = rawStatus.trim().toLowerCase();

    switch (normalized) {
      case 'pending':
        return const _LoanOrderStatusStyle(
          label: 'Pending',
          backgroundColor: Color(0xFFFFF2CC),
          dotColor: Color(0xFFD97706),
          textColor: Color(0xFFD97706),
        );
      case 'preparing':
        return const _LoanOrderStatusStyle(
          label: 'Preparing',
          backgroundColor: Color(0xFFE5E7EB),
          dotColor: Color(0xFF4B5563),
          textColor: Color(0xFF4B5563),
        );
      case 'in transit':
        return const _LoanOrderStatusStyle(
          label: 'in Transit',
          backgroundColor: Color(0xFFDCE8FF),
          dotColor: Color(0xFF3B82F6),
          textColor: Color(0xFF3B82F6),
        );
      case 'delivered':
        return const _LoanOrderStatusStyle(
          label: 'Delivered',
          backgroundColor: Color(0xFFDDF7E6),
          dotColor: Color(0xFF16A34A),
          textColor: Color(0xFF16A34A),
        );
      case 'cancelled':
      case 'canceled':
        return const _LoanOrderStatusStyle(
          label: 'Cancelled',
          backgroundColor: Color(0xFFFFE1E1),
          dotColor: Color(0xFFEF4444),
          textColor: Color(0xFFEF4444),
        );
      default:
        return _LoanOrderStatusStyle(
          label: rawStatus,
          backgroundColor: Colors.grey.shade200,
          dotColor: Colors.grey.shade700,
          textColor: Colors.grey.shade700,
        );
    }
  }
}

class _LoanOrderStatusStyle {
  const _LoanOrderStatusStyle({
    required this.label,
    required this.backgroundColor,
    required this.dotColor,
    required this.textColor,
  });

  final String label;
  final Color backgroundColor;
  final Color dotColor;
  final Color textColor;
}
