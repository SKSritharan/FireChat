import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String appKey = "611047697#1224169";
  static const String userId = "FC001";
  String token =
      "007eJxTYKh3eWa54eiU9xen5l+dtvrj/iX2wdMmxp1S2/V0u71PZX+NAoORhUVymmVaapK5YZqJkbm5RZKFQWKSuYmZhaVZarKxRWCHVWpDICND9eFsBkYGViBmZADxVRiSjVINkwwsDXTNTQxNdQ0NU1N1LRMtk3WTzc0NzA1TLU3MTFIArCcpgA==";

  late ChatClient agoraChatClient;
  bool isJoined = false;

  ScrollController scrollController = ScrollController();
  TextEditingController messageBoxController = TextEditingController();
  String messageContent = "", recipientId = "";
  final List<Widget> messageList = [];

  showLog(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void initState() {
    super.initState();
    setupChatClient();
    setupListeners();
  }

  void setupChatClient() async {
    ChatOptions options = ChatOptions(
      appKey: appKey,
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
        displayMessage(body.content, false);
        showLog("Message from ${msg.from}");
      } else {
        String msgType = msg.body.type.name;
        showLog("Received $msgType message, from ${msg.from}");
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
    showLog("Connected");
  }

  void joinLeave() async {
    if (!isJoined) {
      // Log in
      try {
        await agoraChatClient.loginWithAgoraToken(userId, token);
        showLog("Logged in successfully as $userId");
        setState(() {
          isJoined = true;
        });
      } on ChatError catch (e) {
        if (e.code == 200) {
          // Already logged in
          setState(() {
            isJoined = true;
          });
        } else {
          showLog("Login failed, code: ${e.code}, desc: ${e.description}");
        }
      }
    } else {
      // Log out
      try {
        await agoraChatClient.logout(true);
        showLog("Logged out successfully");
        setState(() {
          isJoined = false;
        });
      } on ChatError catch (e) {
        showLog("Logout failed, code: ${e.code}, desc: ${e.description}");
      }
    }
  }

  void sendMessage() async {
    if (recipientId.isEmpty || messageContent.isEmpty) {
      showLog("Enter recipient user ID and type a message");
      return;
    }

    var msg = ChatMessage.createTxtSendMessage(
      targetId: recipientId,
      content: messageContent,
    );
    ChatClient.getInstance.chatManager.addMessageEvent(
      "UNIQUE_HANDLER_ID",
      ChatMessageEvent(
        onSuccess: (msgId, msg) {
          debugPrint("on message succeed");
        },
        onProgress: (msgId, progress) {
          debugPrint("on message progress");
        },
        onError: (msgId, msg, error) {
          debugPrint(
            "on message failed, code: ${error.code}, desc: ${error.description}",
          );
        },
      ),
    );
    ChatClient.getInstance.chatManager.removeMessageEvent("UNIQUE_HANDLER_ID");
    agoraChatClient.chatManager.sendMessage(msg);
  }

  void displayMessage(String text, bool isSentMessage) {
    messageList.add(Row(children: [
      Expanded(
        child: Align(
          alignment:
              isSentMessage ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.fromLTRB(
                (isSentMessage ? 50 : 0), 5, (isSentMessage ? 0 : 50), 5),
            decoration: BoxDecoration(
              color: isSentMessage
                  ? const Color(0xFFDCF8C6)
                  : const Color(0xFFFFFFFF),
            ),
            child: Text(text),
          ),
        ),
      ),
    ]));

    setState(() {
      scrollController.jumpTo(scrollController.position.maxScrollExtent + 50);
    });
  }

  @override
  void dispose() {
    agoraChatClient.chatManager.removeEventHandler("MESSAGE_HANDLER");
    agoraChatClient.removeConnectionEventHandler("CONNECTION_HANDLER");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fire Chat"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter recipient's userId",
                      ),
                      onChanged: (chatUserId) => recipientId = chatUserId,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 80,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: joinLeave,
                    child: Text(isJoined ? "Leave" : "Join"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemBuilder: (_, index) {
                  return messageList[index];
                },
                itemCount: messageList.length,
              ),
            ),
            Row(children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: messageBoxController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Message",
                    ),
                    onChanged: (msg) => messageContent = msg,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 50,
                height: 40,
                child: ElevatedButton(
                  onPressed: sendMessage,
                  child: const Text(">>"),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
