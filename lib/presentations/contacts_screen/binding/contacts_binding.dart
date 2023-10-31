import 'package:get/get.dart';

import '../controller/contacts_controller.dart';

class ContactsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactsController());
  }
}