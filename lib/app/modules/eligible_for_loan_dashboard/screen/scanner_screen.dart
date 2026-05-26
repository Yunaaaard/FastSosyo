import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:fast_sosyo/app/routes/app_routes.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final MobileScannerController _cameraController = MobileScannerController();
  bool _showDisclaimer = true;
  Rect? _scanRect;
  bool _hasHandledScan = false;

  static const double _minScanSize = 220;
  static const double _initialScanSize = 280;
  static const double _frameInset = 18;
  static const double _handleSize = 26;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_hasHandledScan) {
      return;
    }

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String? code = barcodes.first.rawValue;
      if (code != null && code.isNotEmpty) {
        _hasHandledScan = true;
        _cameraController.stop();
        if (mounted) {
          Get.offNamed(Routes.scanSuccess, arguments: code);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(
            'assets/icons/alt_arrow_left.svg',
            width: 24,
            height: 24,
          ),
        ),
        title: const Text(
          'Scanner',
          style: TextStyle(color: Colors.white),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          MobileScanner(
            controller: _cameraController,
            onDetect: _onDetect,
          ),

          // Four dark panels to create a transparent center 'hole'
          LayoutBuilder(builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;
            final initialSize = math.min(
              _initialScanSize,
              math.min(width, height * 0.58),
            );
            final rect = _scanRect ?? Rect.fromCenter(
              center: Offset(width / 2, height * 0.42),
              width: initialSize,
              height: initialSize,
            );

            if (_scanRect == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted || _scanRect != null) {
                  return;
                }
                setState(() {
                  _scanRect = _clampRect(rect, width, height);
                });
              });
            }

            final activeRect = _clampRect(rect, width, height);
            final left = activeRect.left;
            final top = activeRect.top;
            final scanWidth = activeRect.width;
            final scanHeight = activeRect.height;

            return Stack(children: [
              Positioned.fill(
                child: Container(color: Colors.black38),
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                height: top,
                child: Container(color: Colors.black54),
              ),
              Positioned(
                left: 0,
                top: top,
                width: left,
                height: scanHeight,
                child: Container(color: Colors.black54),
              ),
              Positioned(
                left: left + scanWidth,
                top: top,
                right: 0,
                height: scanHeight,
                child: Container(color: Colors.black54),
              ),
              Positioned(
                left: 0,
                top: top + scanHeight,
                right: 0,
                bottom: 0,
                child: Container(color: Colors.black54),
              ),

              Positioned(
                left: left,
                top: top,
                width: scanWidth,
                height: scanHeight,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onPanUpdate: (details) {
                    _moveScanRect(details.delta, width, height);
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                      ),
                      Positioned(
                        left: -6,
                        top: -6,
                        child: _corner(),
                      ),
                      Positioned(
                        right: -6,
                        top: -6,
                        child: Transform.rotate(
                          angle: 1.57,
                          child: _corner(),
                        ),
                      ),
                      Positioned(
                        left: -6,
                        bottom: -6,
                        child: Transform.rotate(
                          angle: -1.57,
                          child: _corner(),
                        ),
                      ),
                      Positioned(
                        right: -6,
                        bottom: -6,
                        child: Transform.rotate(
                          angle: 3.14,
                          child: _corner(),
                        ),
                      ),
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onPanUpdate: (details) {
                            _resizeScanRect(details.delta, width, height);
                          },
                          child: Container(
                            width: _handleSize,
                            height: _handleSize,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x33000000),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.open_in_full_rounded,
                              size: 16,
                              color: Color(0xFF2563EB),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]);
          }),

          if (_showDisclaimer)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 18,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 22),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          width: 42,
                          height: 5,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE4E7EC),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Note!',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Color(0xFF111827),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Please scan a valid receipt from our salesman\nMake sure everything is correct before you continue. Once you click the button, the payment is final and cannot be changed or reversed.',
                          style: TextStyle(
                            color: Color(0xFF98A2B3),
                            fontSize: 12.5,
                            height: 1.35,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: OutlinedButton(
                                onPressed: () => Get.back(),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Color(0xFF2F6BFF),
                                    width: 1.3,
                                  ),
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF2F6BFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _showDisclaimer = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2F6BFF),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Proceed',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _corner() {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.white70, width: 4),
          top: BorderSide(color: Colors.white70, width: 4),
        ),
      ),
    );
  }

  Rect _clampRect(Rect rect, double width, double height) {
    final double maxSize = math.min(width, math.max(0, height - 120));
    final double size = rect.width.clamp(_minScanSize, maxSize);
    final double left = rect.left.clamp(_frameInset, width - size - _frameInset);
    final double top = rect.top.clamp(_frameInset + 40, height - size - _frameInset);

    return Rect.fromLTWH(left, top, size, size);
  }

  void _moveScanRect(Offset delta, double width, double height) {
    final current = _scanRect;
    if (current == null) {
      return;
    }

    setState(() {
      _scanRect = _clampRect(
        current.shift(delta),
        width,
        height,
      );
    });
  }

  void _resizeScanRect(Offset delta, double width, double height) {
    final current = _scanRect;
    if (current == null) {
      return;
    }

    final double nextSize = (current.width + delta.dx + delta.dy)
        .clamp(_minScanSize, math.min(width, height * 0.75));

    setState(() {
      _scanRect = _clampRect(
        Rect.fromLTWH(current.left, current.top, nextSize, nextSize),
        width,
        height,
      );
    });
  }
}
