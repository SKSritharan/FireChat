import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/signup_controller.dart';

class SignupScreen extends GetWidget<SignupController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Signup Screen'),
      ),
    );
  }
}
