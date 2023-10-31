import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String userProfilePictureUrl;
  late String userName;
  late String userEmail;

  Future<void> fetchUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot snapshot =
            await _firestore.collection('users').doc(user.uid).get();
        if (snapshot.exists) {
          userProfilePictureUrl = snapshot.get('profile_picture');
          userName = snapshot.get('username');
          userEmail = snapshot.get('email');
          update();
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
