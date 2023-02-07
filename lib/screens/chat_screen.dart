import 'package:chat_app/widgets/message_input.dart';
import 'package:chat_app/widgets/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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
