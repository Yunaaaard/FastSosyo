import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import 'package:fast_sosyo/app/modules/success_eligibility/constants/loan_agreement_content.dart';

class LoanAgreementService {
  Future<String> generateAndSaveAgreementPdf({
    required Uint8List signatureBytes,
    required String fullName,
  }) async {
    final pw.Document pdf = pw.Document();
    final pw.MemoryImage signatureImage = pw.MemoryImage(signatureBytes);
    final Directory documentsDirectory = await _getAgreementDirectory();
    final String fileName =
        'loan_agreement_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final String filePath = '${documentsDirectory.path}/$fileName';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(32),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  LoanAgreementContent.pdfTitle,
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Name: $fullName',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.SizedBox(height: 12),
                pw.Text(
                  LoanAgreementContent.bodyText,
                  style: pw.TextStyle(fontSize: 12, height: 1.5),
                ),
                pw.SizedBox(height: 24),
                pw.Text(
                  'Signature',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Container(
                  height: 120,
                  width: double.infinity,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey400),
                  ),
                  child: pw.Center(
                    child: pw.Image(signatureImage, fit: pw.BoxFit.contain),
                  ),
                ),
                pw.SizedBox(height: 24),
                pw.Text(
                  LoanAgreementContent.footerNote,
                  style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
                ),
              ],
            ),
          );
        },
      ),
    );

    final File file = File(filePath);
    await file.writeAsBytes(await pdf.save());
    return filePath;
  }

  Future<void> openGeneratedAgreementFile(String filePath) async {
    try {
      if (Platform.isWindows) {
        await Process.run(
          'cmd',
          <String>['/c', 'start', '', filePath],
          runInShell: true,
        );
        return;
      }

      if (Platform.isMacOS) {
        await Process.run('open', <String>[filePath]);
        return;
      }

      if (Platform.isLinux) {
        await Process.run('xdg-open', <String>[filePath]);
      }
    } catch (_) {
      // Ignore launch failures; the saved path is still shown to the user.
    }
  }

  Future<void> shareGeneratedAgreementOnMobile(String filePath) async {
    if (!(Platform.isAndroid || Platform.isIOS)) {
      return;
    }

    try {
      await Share.shareXFiles(
        <XFile>[XFile(filePath)],
        text: LoanAgreementContent.shareText,
        subject: LoanAgreementContent.shareSubject,
      );
    } catch (_) {
      // If share sheet fails, user can still open/copy path from the success card.
    }
  }

  Future<String?> saveAgreementToAndroidDownloads(String sourcePath) async {
    if (!Platform.isAndroid) {
      return null;
    }

    final String fileName = extractFileName(sourcePath);
    final List<String> candidateDirs = <String>[
      '/storage/emulated/0/Download',
      '/sdcard/Download',
    ];

    for (final String dirPath in candidateDirs) {
      try {
        final Directory dir = Directory(dirPath);
        if (!await dir.exists()) {
          continue;
        }

        String targetPath = '$dirPath${Platform.pathSeparator}$fileName';
        File target = File(targetPath);
        if (await target.exists()) {
          final String uniqueName =
              'loan_agreement_${DateTime.now().millisecondsSinceEpoch}.pdf';
          targetPath = '$dirPath${Platform.pathSeparator}$uniqueName';
          target = File(targetPath);
        }

        await File(sourcePath).copy(target.path);
        return target.path;
      } catch (_) {
        // Try next candidate folder.
      }
    }

    return null;
  }

  String extractFileName(String filePath) {
    final String separator = Platform.pathSeparator;
    final List<String> parts = filePath.split(separator);
    return parts.isNotEmpty ? parts.last : filePath;
  }

  String extractDirectoryLabel(String filePath) {
    final String separator = Platform.pathSeparator;
    final List<String> parts = filePath.split(separator);
    if (parts.length < 2) {
      return 'device storage';
    }

    final int fileIndex = parts.length - 1;
    for (int i = fileIndex - 1; i >= 0; i--) {
      final String part = parts[i].trim();
      if (part.isNotEmpty) {
        return part;
      }
    }

    return 'device storage';
  }

  Future<Directory> _getAgreementDirectory() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      final String? home =
          Platform.environment['USERPROFILE'] ?? Platform.environment['HOME'];
      if (home != null && home.isNotEmpty) {
        final Directory downloads =
            Directory('$home${Platform.pathSeparator}Downloads');
        if (!await downloads.exists()) {
          await downloads.create(recursive: true);
        }
        return downloads;
      }
    }

    return getApplicationDocumentsDirectory();
  }
}
