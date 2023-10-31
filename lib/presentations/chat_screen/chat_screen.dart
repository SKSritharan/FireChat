import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './controller/chat_controller.dart';

class ChatScreen extends GetWidget<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(controller.contactProfilePicture),
            ),
            Text(controller.contactName),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Align(
                    alignment: index % 2 == 0
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Colors.lightBlueAccent
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Text(
                        'Message $index',
                        style: TextStyle(
                          color: index % 2 == 0 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
