import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<File> imageFromCamera(bool isCropped) async {
  File? result;
  final imagePicker = ImagePicker();
  final pickedFile = await imagePicker.pickImage(
    source: ImageSource.camera,
    preferredCameraDevice: CameraDevice.rear,
    imageQuality: 85,
  );
  if (pickedFile != null) {
    result = File(pickedFile.path);
    if (isCropped) result = await cropImage(result);
  }

  return result!;
}



Future<File> imageFromGallery(bool isCropped) async {
  File? result;
  final imagePicker = ImagePicker();
  final pickFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85
      );
  if (pickFile!= null) {
    result = File(pickFile.path);
    if (isCropped) result = await cropImage(result);

  }
  return result!;
}

Future<File> cropImage(File imageFile) async {
  late File result;
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.green,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Cropper',
      ),
    ],
  );

  result = File(croppedFile!.path);
  return result;
}