import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class AgoraService {
  late ChatClient agoraChatClient;
  bool isJoined = false;

  static Future<void> initializeAgora() async {
    final agoraService = AgoraService();
    await agoraService.setupChatClient();
    agoraService.setupListeners();
  }

  Future<void> setupChatClient() async {
    ChatOptions options = ChatOptions(
      appKey: Constants.appKey,
      autoLogin: false,
    );
    agoraChatClient = ChatClient.getInstance;
    await agoraChatClient.init(options);
    // Notify the SDK that the Ul is ready. After the following method is executed, callbacks within ChatRoomEventHandler and ChatGroupEventHandler can be triggered.
    await ChatClient.getInstance.startCallback();
  }

  void setupListeners() {
    agoraChatClient.addConnectionEventHandler(
      "CONNECTION_HANDLER",
      ConnectionEventHandler(
          onConnected: onConnected,
          onDisconnected: onDisconnected,
          onTokenWillExpire: onTokenWillExpire,
          onTokenDidExpire: onTokenDidExpire),
    );

    agoraChatClient.chatManager.addEventHandler(
      "MESSAGE_HANDLER",
      ChatEventHandler(onMessagesReceived: onMessagesReceived),
    );
  }

  void onMessagesReceived(List<ChatMessage> messages) {
    for (var msg in messages) {
      if (msg.body.type == MessageType.TXT) {
        ChatTextMessageBody body = msg.body as ChatTextMessageBody;
        // displayMessage(body.content, false);
        // showLog("Message from ${msg.from}");
        Get.snackbar("Message from ${msg.from}", "Message ${body.content}");
      } else {
        String msgType = msg.body.type.name;
        // showLog("Received $msgType message, from ${msg.from}");
        Get.snackbar("Received $msgType message",
            "Received $msgType message, from ${msg.from}");
      }
    }
  }

  void onTokenWillExpire() {
    // The token is about to expire. Get a new token
    // from the token server and renew the token.
  }
  void onTokenDidExpire() {
    // The token has expired
  }
  void onDisconnected() {
    // Disconnected from the Chat server
  }
  void onConnected() {
    Get.snackbar("Connected", "Agora is connected");
  }

  bool isLoggedIn() {
    return isJoined;
  }

  Future<void> joinLeave(userId, pwd) async {
    if (!isJoined) {
      // Log in
      try {
        await agoraChatClient.login(userId, pwd);
        Get.snackbar("Success", "Logged in successfully as $userId");
        isJoined = true;
      } on ChatError catch (e) {
        if (e.code == 200) {
          // Already logged in
          isJoined = true;
        } else {
          Get.snackbar("Login Failed",
              "Login failed, code: ${e.code}, desc: ${e.description}");
        }
      }
    } else {
      // Log out
      try {
        await agoraChatClient.logout(true);
        Get.snackbar("Success", "Logged out successfully");
        isJoined = false;
      } on ChatError catch (e) {
        Get.snackbar("Login Failed",
            "Logout failed, code: ${e.code}, desc: ${e.description}");
      }
    }
  }
}
