import 'dart:io';

import 'package:chatapplication/core/app_units.dart';
import 'package:chatapplication/networks/app_firebase.dart';
import 'package:chatapplication/pages/user_info_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../core/app_permssions.dart';
import '../main.dart';
import '../models/user_model.dart';

class LoginController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  String code = "+98";
  RxString numberError = RxString("");
  RxString pinError = RxString("");
  RxString userNameError = RxString("");
  FirebaseAuth auth = FirebaseAuth.instance;
  AppFirebase appFirebase = AppFirebase();
  late String number;
  RxBool isLoading = RxBool(false);
  // RXstring
  var selectedImage = "".obs;
  AppPermission appPermission = AppPermission();
  @override
  void onClose() {
    super.onClose();
    phoneNumberController.dispose();
    otpController.dispose();
  }

  void sendOTP() async {
    if (phoneNumberController.text.isEmpty) {
      numberError("Field is required");
      return; // Added return statement
    } else if (phoneNumberController.text.length < 10) {
      numberError.value = "Invalid Number";
      return; // Added return statement
    } else {
      numberError("");
      number = code + phoneNumberController.text;
      await appFirebase.sendVerificationCode(number);
    }
  }

  void verifyOTP() async {
    if (otpController.text.isEmpty) {
      pinError("Field is required");
      return;
    } else if (otpController.text.length < 6) {
      pinError.value = "Invalid Pin";
      return;
    } else {
      isLoading.value = true;
      await appFirebase.verifyOTP(otpController.text);
      isLoading.value = false;
      Get.off(const UserInfoScreen());
    }
  }

  void getImage(ImageSource source) async {
    switch (source) {
      case ImageSource.camera:
        var file = await imageFromCamera(true);
        selectedImage.value = file.path;

        break;
      case ImageSource.gallery:
        var file = await imageFromGallery(true);
        selectedImage.value = file.path;
        break;
    }
  }

  void skipInfo() {
    isLoading.value = true;
    var userModel = UserModel(
        uId: auth.currentUser!.uid,
        name: "",
        image: "",
        number: number,
        status: "Hey i'm using this app",
        typing: "false",
        online: DateTime.now().toString());
    appFirebase.createUser(userModel).then((value) => isLoading(false));
    Get.offAllNamed(Routes.DASHBOARD);
  }

  void uploadUserData() async {
    if (userNameController.text.isEmpty) {
      userNameError("Field is required");
    }
    if (selectedImage.value == "") {
      printError(info: "Image is required");
    } else if (auth.currentUser == null) {
      printError(info: "Not authenticated");
      return;
    } else {
      userNameError.value = "";
      isLoading.value = true;
      String link = await appFirebase.uploadUserImage(
          "profile/image", auth.currentUser!.uid, File(selectedImage.value));
      var userModel = UserModel(
          uId: auth.currentUser!.uid,
          name: userNameController.text,
          image: link,
          number: number,
          status: "Hey I'm using this app",
          typing: "false",
          online: DateTime.now().toString());
      await appFirebase.createUser(userModel).then((value) => isLoading(false));
      Get.offAllNamed(Routes.DASHBOARD);
    }
  }

  void showPicker(BuildContext context) {
    Get.bottomSheet(
        SafeArea(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.photo_library,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: const Text("Photo Library"),
                  onTap: () async {
                    Navigator.pop(context);
                    var status = await appPermission.isStoragePermissionOk();
                    switch (status) {
                      case PermissionStatus.denied:
                        var status =
                            await Permission.storage.request().isDenied;
                        if (status) {
                          getImage(ImageSource.gallery);
                        } else {
                          printError(info: "Storage Permission denied");
                        }
                        break;
                      case PermissionStatus.granted:
                        getImage(ImageSource.gallery);
                        break;
                      case PermissionStatus.restricted:
                        printError(info: "Storage Permission denied");
                        break;
                      case PermissionStatus.limited:
                        printError(info: "Storage Permission denied");
                        break;
                      case PermissionStatus.permanentlyDenied:
                        await openAppSettings();
                        break;
                      default:
                        // This will catch any unhandled cases, like 'provisional'
                        printError(
                            info: "Unhandled permission status: $status");
                        break;
                    }
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.photo_camera,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: const Text("Camera"),
                  onTap: () async {
                    Navigator.pop(context);
                    var status = await appPermission.isCameraPermissionOk();
                    switch (status) {
                      case PermissionStatus.denied:
                        var status = await Permission.camera.request().isDenied;
                        if (status) {
                          getImage(ImageSource.camera);
                        } else {
                          printError(info: "Camera Permission denied");
                        }
                        break;
                      case PermissionStatus.granted:
                        getImage(ImageSource.camera);
                        break;
                      case PermissionStatus.restricted:
                        printError(info: "Camera Permission denied");
                        break;
                      case PermissionStatus.limited:
                        printError(info: "Camera Permission denied");
                        break;
                      case PermissionStatus.permanentlyDenied:
                        await openAppSettings();
                        break;
                      default:
                        // This will catch any unhandled cases, like 'provisional'
                        printError(
                            info: "Unhandled permission status: $status");
                        break;
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)));
  }
}
