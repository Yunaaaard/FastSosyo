import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/controller/scan_success_controller.dart';
import 'package:get/get.dart';

class ScanSuccessBinding extends Bindings {
  @override
  void dependencies() {
    final dynamic args = Get.arguments;

    // Mock/placeholder data for UI testing
    String qrData = 'https://example.com/qr?referenceNo=1123509321348893';
    String? from;
    String? to;
    String? referenceNo;
    String? dateTime;
    double amountSent = 1834.08;

    if (args is Map<String, dynamic>) {
      qrData = args['qrData'] as String? ?? qrData;
      from = args['from'] as String?;
      to = args['to'] as String?;
      referenceNo = args['referenceNo'] as String?;
      dateTime = args['dateTime'] as String?;
      amountSent = args['amountSent'] as double? ?? 1834.08;
    } else if (args is String) {
      qrData = args;
    }

    Get.put(
      ScanSuccessController(
        qrData: qrData,
        from: from ?? 'Daven Reez Nemenzo',
        to: to ?? 'Fast Sosyo Nestle',
        referenceNo: referenceNo,
        dateTime: dateTime,
        amountSent: amountSent,
      ),
    );
  }
}
