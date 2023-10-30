import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../data/models/chat_item.dart';
import '../../../routes/app_routes.dart';

class HomeController extends GetxController {
  final List<ChatItem> chatItems = [
    ChatItem(
      name: 'John Doe',
      lastMessage: 'Hello, how are you?',
      time: '10:30 AM',
      unreadCount: 2,
    ),
    ChatItem(
      name: 'Jane Doe',
      lastMessage: 'Hi there!',
      time: 'Yesterday',
      unreadCount: 0,
    ),
  ];

  void handleClick(int item) {
    switch (item) {
      case 0:
        break;
      case 1:
        logout();
        break;
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    Get.offAndToNamed(AppRoutes.loginScreen);
  }
}
