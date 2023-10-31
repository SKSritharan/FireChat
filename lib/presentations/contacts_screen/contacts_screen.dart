import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import 'controller/contacts_controller.dart';

class ContactsScreen extends GetWidget<ContactsController> {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: FutureBuilder<void>(
        future: controller.fetchContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: controller.contacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  key: UniqueKey(),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(36.0),
                    child: CachedNetworkImage(
                      imageUrl: controller.contacts[index].profilePicture,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  title: Text(controller.contacts[index].name),
                  subtitle: Text(controller.contacts[index].email),
                  onTap: () => Get.toNamed(
                    AppRoutes.chatScreen,
                    arguments: {
                      'uid': controller.contacts[index].uid,
                      'contactName': controller.contacts[index].name,
                      'contactProfilePicture':
                          controller.contacts[index].profilePicture,
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
