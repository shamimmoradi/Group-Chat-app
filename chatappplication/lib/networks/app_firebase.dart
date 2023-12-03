import 'dart:io';
import 'package:chatapplication/pages/verification_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/user_model.dart';
class AppFirebase {
// send the code to  the number
    
Future<void> sendVerificationCode(String number) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // This callback gets called when the verification is done automatically
          await auth.signInWithCredential(credential);
          printInfo(info: "User verified automatically");
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar("Error", e.message!);
          printError(info: e.message!);
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Navigate to the VerificationPage, passing the verificationId
          Get.to(() => VerificationPage(verificationId: verificationId));
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) async {
          // This callback gets called when the automatic retrieval times out
          // You can prompt the user to enter the code manually and complete the verification
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }


// verify the code
    Future<void> verifyOTP(String otp) async {
      SharedPreferences pref =  await SharedPreferences.getInstance();
      String? verificationId = pref.getString("code");
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId!, smsCode: otp);
      await FirebaseAuth.instance.signInWithCredential(credential);
  }


  Future<void> createUser(UserModel userModel) async {
    CollectionReference ref = FirebaseFirestore.instance.collection("users");
    await FirebaseAuth.instance.currentUser?.updateDisplayName(userModel.name);
    await FirebaseAuth.instance.currentUser?.updatePhotoURL(userModel.image);
    SharedPreferences.getInstance().then((value) {
      value.setString("number", userModel.number);
    });

    return await ref.doc(userModel.uId).set(userModel.toJson());
  }

Future<String> uploadUserImage(String path, String uId, File file) async {
  try {
    // Construct the full path
    String fullPath = '$uId/$path';
    print('Uploading to: $fullPath'); // Log the path for debugging

    // Get a reference to the storage location
    Reference storageReference = FirebaseStorage.instance.ref().child(fullPath);

    // Start the upload task
    UploadTask uploadTask = storageReference.putFile(file);

    // Wait for the task to complete
    TaskSnapshot snapshot = await uploadTask;

    // Get the download URL
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    print('Error in uploadUserImage: $e'); // Log the error
    rethrow; // Re-throw the error for further handling
  }
}
}