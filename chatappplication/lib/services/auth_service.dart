// ignore_for_file: empty_catches, use_build_context_synchronously

import 'package:chatapplication/pages/home_page.dart';
import 'package:chatapplication/pages/login_page.dart';
import 'package:chatapplication/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

// handle sighn In
  Future<bool> signinWithGoogle(BuildContext context) async {
    // it asks about gooogle acount and ask to sign any of them
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
// chosed an acount
      try {
        // check the credential
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
// user recovery , use those credential
        final UserCredential userData = await firebaseAuth.signInWithCredential(credential);
        // insert user data into our own database if it doesnt exist
        await DatabaseService(userId: userData.user!.uid)
          .insertUserData(
            userData.user?.displayName, 
            userData.user?.email, 
            userData.user?.photoURL);
        return true;
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.message.toString()),
          backgroundColor: Colors.red,
        ));
        return false;
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.toString()),
          backgroundColor: Colors.red,
        ));
        return false;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("sign in process was cancled"),
        backgroundColor: Colors.red,
      ));
      return false;
    }
  }

// handle sighn out
  Future<void> signOut() async {
    await googleSignIn.signOut();
    await firebaseAuth.signOut();
  }

// determine if user is authenticated or not

  Widget handleAuthState() {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return  const HomePage();
        } else {
          return const LoginPage();
        }
      },
      stream: firebaseAuth.authStateChanges(),
    );
  }
}
