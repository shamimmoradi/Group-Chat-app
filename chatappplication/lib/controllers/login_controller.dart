import 'package:chatapplication/networks/app_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String code = "+98";
  RxString numberError = RxString("");
  RxString pinError = RxString("");
  FirebaseAuth auth = FirebaseAuth.instance;
  AppFirebase appFirebase = AppFirebase();
  late String number;
  RxBool isLoading = RxBool(false);

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
      pinError("Field is required"); // Changed to pinError
      return; // Added return statement
    } else if (otpController.text.length < 6) {
      pinError.value = "Invalid Pin"; // Changed to pinError
      return; // Added return statement
    } else {
      isLoading.value = true;
      await appFirebase.verifyOTP(otpController.text);
      isLoading.value = false;
      // Get.off(OtherScreen());
    }
  }
}