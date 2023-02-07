import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({super.key});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final _enteredMessage = '';
  late TextEditingController _messageController;

  @override
  void initState() {
    // TODO: implement initState
    _messageController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance
        .collection('chats')
        .add({'text': _messageController.text, 'createdAt': Timestamp.now()});
    setState(() {
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _messageController,
            decoration: const InputDecoration(labelText: 'Type here...'),
          )),
          IconButton(
            onPressed: _messageController.text.isNotEmpty ? _sendMessage : null,
            icon: const Icon(
              Icons.send,
            ),
            color: Theme.of(context).colorScheme.primary,
          )
        ],
      ),
    );
  }
}
