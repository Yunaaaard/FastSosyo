import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:fast_sosyo/app/modules/success_eligibility/constants/loan_agreement_content.dart';

class LoanAgreementService {
  static pw.Font? _cachedTimesNewRoman;
  static const List<String> _androidDownloadsDirs = <String>[
    '/storage/emulated/0/Download',
    '/sdcard/Download',
  ];

  Future<String> generateAndSaveAgreementPdf({
    required Uint8List signatureBytes,
    required String fullName,
  }) async {
    final pw.Document pdf = pw.Document();
    final pw.MemoryImage signatureImage = pw.MemoryImage(signatureBytes);
    final pw.Font times = await _getTimesNewRomanFont();
    final pw.Font timesBold = pw.Font.timesBold();
    final DateTime now = DateTime.now();
    final String signedDate = _formatShortDate(now);
    final Directory documentsDirectory = await _getAgreementDirectory();
    final String fileName =
        'loan_agreement_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final String filePath = '${documentsDirectory.path}/$fileName';

    final pw.TextStyle titleStyle = pw.TextStyle(
      font: timesBold,
      fontSize: 12,
      color: PdfColors.black,
    );
    final pw.TextStyle subtitleStyle = pw.TextStyle(
      font: times,
      fontSize: 9,
      color: PdfColors.black,
    );
    final pw.TextStyle partyLineStyle = pw.TextStyle(
      font: timesBold,
      fontSize: 12,
      color: PdfColors.black,
      lineSpacing: 6,
    );
    final pw.TextStyle bodyStyle = pw.TextStyle(
      font: times,
      fontSize: 12,
      color: PdfColors.black,
      lineSpacing: 4,
    );

    final List<pw.Widget> bodyParagraphs = _buildBodyParagraphs(bodyStyle);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(72, 44, 72, 46),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Center(
              child: pw.Text(
                'LOAN AGREEMENT TERMS',
                style: titleStyle,
              ),
            ),
            pw.SizedBox(height: 2),
            pw.Center(
              child: pw.Text(
                '(Sample Contract)',
                style: subtitleStyle,
              ),
            ),
            pw.SizedBox(height: 18),
            pw.Text('Fast Distribution Corporation', style: partyLineStyle),
            pw.Text('Fast Sosyo', style: partyLineStyle),
            pw.Text(signedDate, style: partyLineStyle),
            pw.SizedBox(height: 18),
            ...bodyParagraphs,
            pw.SizedBox(height: 10),
            pw.Container(
              width: 260,
              height: 52,
              child: pw.Stack(
                children: [
                  pw.Positioned(
                    left: 0,
                    bottom: 0,
                    child: pw.Container(
                      width: 250,
                      child: pw.Text(
                        fullName,
                        style: pw.TextStyle(
                          font: times,
                          fontSize: 13,
                          color: PdfColors.black,
                          decoration: pw.TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  pw.Positioned(
                    left: 0,
                    bottom: 8,
                    child: pw.Container(
                      width: 110,
                      height: 32,
                      child: pw.Image(
                        signatureImage,
                        fit: pw.BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 3),
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 46),
              child: pw.Text(
                'Name',
                style: pw.TextStyle(
                  font: timesBold,
                  fontSize: 12,
                  color: PdfColors.black,
                ),
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Text(
              'Date Signed: $signedDate',
              style: pw.TextStyle(
                font: times,
                fontSize: 12,
                color: PdfColors.black,
              ),
            ),
          ];
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
    for (final String dirPath in _androidDownloadsDirs) {
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

  bool isAndroidDownloadsPath(String filePath) {
    final String normalizedPath = filePath.replaceAll('\\', '/');
    return _androidDownloadsDirs.any(
      (String dir) => normalizedPath.startsWith(dir),
    );
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
    if (Platform.isAndroid) {
      for (final String dirPath in _androidDownloadsDirs) {
        final Directory downloads = Directory(dirPath);
        if (await downloads.exists()) {
          return downloads;
        }
      }
    }

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

  String _formatShortDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  List<pw.Widget> _buildBodyParagraphs(pw.TextStyle bodyStyle) {
    final List<String> paragraphs = LoanAgreementContent.bodyText
        .split('\n\n')
        .map((String part) => part.trim())
        .where((String part) => part.isNotEmpty)
        .toList();

    return paragraphs
        .map(
          (String paragraph) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 10),
            child: pw.Paragraph(
              text: paragraph,
              textAlign: pw.TextAlign.justify,
              style: bodyStyle,
            ),
          ),
        )
        .toList();
  }

  Future<pw.Font> _getTimesNewRomanFont() async {
    if (_cachedTimesNewRoman != null) {
      return _cachedTimesNewRoman!;
    }

    final ByteData fontData = await rootBundle.load(
      'assets/fonts/Times-New-Roman.ttf',
    );
    _cachedTimesNewRoman = pw.Font.ttf(fontData);
    return _cachedTimesNewRoman!;
  }
}
