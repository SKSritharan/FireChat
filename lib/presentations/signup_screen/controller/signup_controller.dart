import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController confirmPwdController = TextEditingController();

  RxBool obscureText = false.obs;

  void updateObscureText() {
    obscureText.value = !obscureText.value;
  }

  void createAccount() async {
    try {
      if (pwdController.text == confirmPwdController.text) {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: pwdController.text,
        );

        if (userCredential.user != null) {
          // Account created successfully
          Get.snackbar("Success", "Account created successfully");
          
          // Add user data to Firestore
          await _firestore.collection('users').doc(userCredential.user!.uid).set({
            'username': nameController.text,
            'email': emailController.text,
            'profile_picture' : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
          });

          Get.offAndToNamed(AppRoutes.homeScreen);
        } else {
          // Account creation failed
          Get.snackbar("Error", "Account creation failed");
        }
      } else {
        // Passwords do not match
        Get.snackbar("Error", "Passwords do not match");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Error", "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Error", "The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }
}