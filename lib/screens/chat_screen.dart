import 'package:chat_app/widgets/message_input.dart';
import 'package:chat_app/widgets/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isInit = false;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    if (!_isInit) {
      final fbm = FirebaseMessaging.instance;
      await fbm.requestPermission();
      FirebaseMessaging.onMessage.listen((message) {
        print(message.data);
        _isInit = true;
        return;
      });
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print(message.data);
        _isInit = true;
        return;
      });
      fbm.subscribeToTopic('chats');
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text('Logout')
                      ],
                    ),
                  ))
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: const [Expanded(child: Messages()), MessageInput()],
        ),
      ),
    );
  }
}
