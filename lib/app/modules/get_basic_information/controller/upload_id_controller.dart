import 'dart:io';

import 'package:fast_sosyo/app/modules/get_basic_information/models/upload_id_model.dart';
import 'package:fast_sosyo/data/services/upload_id_service.dart';

class UploadIdController {
  UploadIdController({
    UploadIdService? uploadIdService,
    UploadIdModel? initialModel,
  })  : _uploadIdService = uploadIdService ?? UploadIdService(),
        _model = initialModel ?? const UploadIdModel(idType: 'National ID');

  final UploadIdService _uploadIdService;
  UploadIdModel _model;

  File? _frontIdFile;
  File? _backIdFile;
  bool _isPickingFront = false;
  bool _isPickingBack = false;

  UploadIdModel get model => _model;
  File? get frontIdFile => _frontIdFile;
  File? get backIdFile => _backIdFile;
  bool get isPickingFront => _isPickingFront;
  bool get isPickingBack => _isPickingBack;
  bool get canContinue => _model.isComplete;

  void setIdType(String idType) {
    _model = _model.copyWith(idType: idType);
  }

  Future<String?> pickFrontId() async {
    if (_isPickingFront) {
      return null;
    }

    _isPickingFront = true;
    try {
      final File? file = await _uploadIdService.pickIdFile();
      if (file != null) {
        _frontIdFile = file;
        _model = _model.copyWith(frontIdPath: file.path);
      }
      return null;
    } catch (_) {
      return 'Unable to select Front ID right now. Please try again.';
    } finally {
      _isPickingFront = false;
    }
  }

  Future<String?> pickBackId() async {
    if (_isPickingBack) {
      return null;
    }

    _isPickingBack = true;
    try {
      final File? file = await _uploadIdService.pickIdFile();
      if (file != null) {
        _backIdFile = file;
        _model = _model.copyWith(backIdPath: file.path);
      }
      return null;
    } catch (_) {
      return 'Unable to select Back ID right now. Please try again.';
    } finally {
      _isPickingBack = false;
    }
  }

  void dispose() {}
}
