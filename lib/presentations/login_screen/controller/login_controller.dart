import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  RxBool obscureText = false.obs;

  void updateObscureText() {
    obscureText.value = !obscureText.value;
  }

  void login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: pwdController.text,
      );

      // Agora integration logic here
      if (userCredential.user != null) {
        // Login successful
        Get.snackbar("Success", "Login successful");
        Get.offAndToNamed(AppRoutes.homeScreen);
      } else {
        // Login failed
        Get.snackbar("Error", "Login failed");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Error", "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Error", "Wrong password provided for that user.");
      }
    } catch (e) {
      print(e);
    }
  }
}
