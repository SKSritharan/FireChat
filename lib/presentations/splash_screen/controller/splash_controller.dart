import 'package:fire_chat/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    delayedNavigate();
  }

  void delayedNavigate() async {
    await Future.delayed(const Duration(seconds: 3));
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.offAndToNamed(AppRoutes.loginScreen);
      } else {
        Get.offAndToNamed(AppRoutes.homeScreen);
      }
    });
  }
}
