import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ScanSuccessController extends GetxController {
  ScanSuccessController({
    required this.qrData,
    this.from,
    this.to,
    this.referenceNo,
    this.dateTime,
    this.amountSent = 1834.08,
  }) {
    _parsedQrJson = _parseQrJson();
  }

  final String qrData;
  final String? from;
  final String? to;
  final String? referenceNo;
  final String? dateTime;
  final double amountSent;

  late Map<String, dynamic>? _parsedQrJson;

  Map<String, dynamic>? _parseQrJson() {
    try {
      return jsonDecode(qrData) as Map<String, dynamic>;
    } catch (e) {
      print('Error parsing QR JSON: $e');
      return null;
    }
  }

  // JSON getters with fallbacks
  String get loanId => _parsedQrJson?['loanId'] as String? ?? 'N/A';
  String get principalTitle => _parsedQrJson?['principalTitle'] as String? ?? to ?? 'N/A';
  String get principalLogo => _parsedQrJson?['principalLogo'] as String? ?? '';
  double get amountDueFromQr => (_parsedQrJson?['amountDue'] as num?)?.toDouble() ?? amountSent;
  String get appliedDate => _parsedQrJson?['appliedDate'] as String? ?? '';
  String get dueDate => _parsedQrJson?['dueDate'] as String? ?? '';
  List<dynamic>? get products => _parsedQrJson?['products'] as List<dynamic>?;

  String get formattedAppliedDate {
    try {
      if (appliedDate.isEmpty) return '';
      final DateTime parsed = DateTime.parse(appliedDate);
      return DateFormat('MM-dd-yy').format(parsed);
    } catch (e) {
      return appliedDate;
    }
  }

  String get formattedDueDate {
    try {
      if (dueDate.isEmpty) return '';
      final DateTime parsed = DateTime.parse(dueDate);
      return DateFormat('MM-dd-yy').format(parsed);
    } catch (e) {
      return dueDate;
    }
  }

  // Simple computed getters - no reactive state needed
  String get formattedDateTime =>
      dateTime ?? DateFormat('MM-dd-yy | HH:mm').format(DateTime.now());

  String get displayReferenceNo => formatReferenceNo(referenceNo ?? qrData);

  String formatReferenceNo(String value) {
    final Uri? uri = Uri.tryParse(value);
    final String? queryReference = _referenceFromUri(uri);
    final String source = queryReference ?? value;
    final String digitsOnly = source.replaceAll(RegExp(r'[^0-9]'), '');

    if (digitsOnly.isEmpty) {
      return value;
    }

    final Iterable<String> chunks = RegExp(r'.{1,4}')
        .allMatches(digitsOnly)
        .map((Match match) => match.group(0) ?? '');
    return chunks.join(' ');
  }

  String? _referenceFromUri(Uri? uri) {
    if (uri == null) {
      return null;
    }

    if (uri.scheme != 'http' && uri.scheme != 'https') {
      return null;
    }

    for (final String key in <String>['referenceNo', 'refNo', 'ref', 'orderId', 'id']) {
      final String? value = uri.queryParameters[key];
      if (value != null && value.isNotEmpty) {
        return value;
      }
    }

    final String pathDigits = uri.path.replaceAll(RegExp(r'[^0-9]'), '');
    if (pathDigits.isNotEmpty) {
      return pathDigits;
    }

    final String queryDigits = uri.query.replaceAll(RegExp(r'[^0-9]'), '');
    if (queryDigits.isNotEmpty) {
      return queryDigits;
    }

    return null;
  }

  String formatMoney(double amount) {
    return amount.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match.group(1)},',
        );
  }
}
