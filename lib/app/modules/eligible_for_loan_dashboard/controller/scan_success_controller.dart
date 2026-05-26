import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ScanSuccessController extends GetxController {
  ScanSuccessController({
    required this.qrData,
    this.from = 'Daven Reez Nemenzo',
    this.to = 'Fast Sosyo Nestle',
    this.referenceNo,
    this.dateTime,
    this.amountSent = 1834.08,
  });

  final String qrData;
  final String from;
  final String to;
  final String? referenceNo;
  final String? dateTime;
  final double amountSent;

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
