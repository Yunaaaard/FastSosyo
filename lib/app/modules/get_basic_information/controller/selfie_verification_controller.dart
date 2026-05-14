import 'dart:io';

import 'package:fast_sosyo/app/modules/get_basic_information/models/selfie_verification_model.dart';
import 'package:fast_sosyo/data/services/camera_service.dart';
import 'package:get/get.dart';

class SelfieVerificationController extends GetxController {
  SelfieVerificationController({
    CameraService? cameraService,
    SelfieVerificationModel? initialModel,
  })  : _cameraService = cameraService ?? CameraService() {
    _model.value = initialModel ?? const SelfieVerificationModel();
  }

  final CameraService _cameraService;
  final Rx<SelfieVerificationModel> _model = Rx<SelfieVerificationModel>(
    const SelfieVerificationModel(),
  );
  final Rx<File?> _selfieFile = Rx<File?>(null);
  final RxBool _isCapturing = false.obs;

  SelfieVerificationModel get model => _model.value;
  File? get selfieFile => _selfieFile.value;
  bool get isCapturing => _isCapturing.value;
  bool get canContinue => _model.value.isVerified;

  Future<String?> captureSelfie() async {
    if (_isCapturing.value) {
      return null;
    }

    _isCapturing.value = true;
    try {
      final File? capturedSelfie = await _cameraService.captureSelfie();
      if (capturedSelfie != null) {
        _selfieFile.value = capturedSelfie;
        _model.value = _model.value.copyWith(
          selfiePath: capturedSelfie.path,
          isVerified: true,
        );
        _model.refresh();
      }
      return null;
    } catch (_) {
      return 'Unable to open camera right now. Please try again.';
    } finally {
      _isCapturing.value = false;
    }
  }
}
