import 'dart:io';

import 'package:fast_sosyo/app/modules/get_basic_information/models/selfie_verification_model.dart';
import 'package:fast_sosyo/data/services/camera_service.dart';

class SelfieVerificationController {
  SelfieVerificationController({
    CameraService? cameraService,
    SelfieVerificationModel? initialModel,
  })  : _cameraService = cameraService ?? CameraService(),
        _model = initialModel ?? const SelfieVerificationModel();

  final CameraService _cameraService;
  SelfieVerificationModel _model;
  File? _selfieFile;
  bool _isCapturing = false;

  SelfieVerificationModel get model => _model;
  File? get selfieFile => _selfieFile;
  bool get isCapturing => _isCapturing;
  bool get canContinue => _model.isVerified;

  Future<String?> captureSelfie() async {
    if (_isCapturing) {
      return null;
    }

    _isCapturing = true;
    try {
      final File? capturedSelfie = await _cameraService.captureSelfie();
      if (capturedSelfie != null) {
        _selfieFile = capturedSelfie;
        _model = _model.copyWith(
          selfiePath: capturedSelfie.path,
          isVerified: true,
        );
      }
      return null;
    } catch (_) {
      return 'Unable to open camera right now. Please try again.';
    } finally {
      _isCapturing = false;
    }
  }

  void dispose() {}
}
