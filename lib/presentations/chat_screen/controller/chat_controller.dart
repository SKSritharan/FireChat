import 'package:get/get.dart';

class ChatController extends GetxController {
  final recepientId = Get.arguments['uid'];
  final contactName = Get.arguments['contactName'];
  final contactProfilePicture = Get.arguments['contactProfilePicture'];

  @override
  void onInit() {
    // print('receipient id: $recepientId');
    super.onInit();
  }
}
