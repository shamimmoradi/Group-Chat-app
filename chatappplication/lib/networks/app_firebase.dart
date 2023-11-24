import 'package:chatapplication/pages/verification_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AppFirebase {
// send the code to  the number
    Future<void> sendVerificationCode(String number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) {
          printInfo(info: "User verified");
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar("error", e.message!);
          printError(info: e.message!);
        },
        codeSent: (String verificationId, int? resendToken)async {
        SharedPreferences pref =  await SharedPreferences.getInstance();
        await pref.setString("code", verificationId);
        Get.to(()=> const VerificationPage());
        
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) async{
          
        });
  }


// verify the code
    Future<void> verifyOTP(String otp) async {
      SharedPreferences pref =  await SharedPreferences.getInstance();
      String? verificationId = pref.getString("code");
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId!, smsCode: otp);
      await FirebaseAuth.instance.signInWithCredential(credential);
  }
}