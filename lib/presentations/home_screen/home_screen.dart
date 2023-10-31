import 'package:fire_chat/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/home_controller.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FireChat'),
        actions: [
          IconButton(
            onPressed: () {
              // Add action here
            },
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton<int>(
            onSelected: (item) => controller.handleClick(item),
            itemBuilder: (context) => const [
              PopupMenuItem<int>(
                value: 0,
                child: Text('Settings'),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: controller.chatItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(controller.chatItems[index].name[0]),
            ),
            title: Text(controller.chatItems[index].name),
            subtitle: Text(controller.chatItems[index].lastMessage),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(controller.chatItems[index].time),
                if (controller.chatItems[index].unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9F7BFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      controller.chatItems[index].unreadCount.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
            onTap: () => Get.toNamed(AppRoutes.chatScreen),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.contactsScreen),
        child: const Icon(Icons.chat_bubble),
      ),
    );
  }
}
