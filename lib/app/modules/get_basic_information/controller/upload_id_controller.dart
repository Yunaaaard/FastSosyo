import 'dart:io';

import 'package:fast_sosyo/app/modules/get_basic_information/models/upload_id_model.dart';
import 'package:fast_sosyo/data/services/upload_id_service.dart';
import 'package:get/get.dart';

class UploadIdController extends GetxController {
  UploadIdController({
    UploadIdService? uploadIdService,
    UploadIdModel? initialModel,
  })  : _uploadIdService = uploadIdService ?? UploadIdService() {
    _model.value = initialModel ?? const UploadIdModel(idType: 'National ID');
  }

  final UploadIdService _uploadIdService;
  final Rx<UploadIdModel> _model = Rx<UploadIdModel>(
    const UploadIdModel(idType: 'National ID'),
  );

  final Rx<File?> _frontIdFile = Rx<File?>(null);
  final Rx<File?> _backIdFile = Rx<File?>(null);
  final RxBool _isPickingFront = false.obs;
  final RxBool _isPickingBack = false.obs;

  UploadIdModel get model => _model.value;
  File? get frontIdFile => _frontIdFile.value;
  File? get backIdFile => _backIdFile.value;
  bool get isPickingFront => _isPickingFront.value;
  bool get isPickingBack => _isPickingBack.value;
  bool get canContinue => _model.value.frontIdPath != null && _model.value.backIdPath != null;

  void setIdType(String idType) {
    _model.value = _model.value.copyWith(idType: idType);
    _model.refresh();
  }

  Future<String?> pickFrontId() async {
    if (_isPickingFront.value) {
      return null;
    }

    _isPickingFront.value = true;
    try {
      final File? file = await _uploadIdService.pickIdFile();
      if (file != null) {
        _frontIdFile.value = file;
        _model.value = _model.value.copyWith(frontIdPath: file.path);
        _model.refresh();
      }
      return null;
    } catch (_) {
      return 'Unable to select Front ID right now. Please try again.';
    } finally {
      _isPickingFront.value = false;
    }
  }

  Future<String?> pickBackId() async {
    if (_isPickingBack.value) {
      return null;
    }

    _isPickingBack.value = true;
    try {
      final File? file = await _uploadIdService.pickIdFile();
      if (file != null) {
        _backIdFile.value = file;
        _model.value = _model.value.copyWith(backIdPath: file.path);
        _model.refresh();
      }
      return null;
    } catch (_) {
      return 'Unable to select Back ID right now. Please try again.';
    } finally {
      _isPickingBack.value = false;
    }
  
  }

  @override
  void onClose() {
    super.onClose();
  }
}
