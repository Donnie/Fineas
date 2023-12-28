import 'package:flutter/material.dart';
import 'dart:async';
import 'package:finease/widget/list.dart';
import 'package:finease/widget/input.dart';
import 'package:finease/db.dart';
import 'package:finease/message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> messages = []; // Ensure this list holds Message objects
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      setState(() {
        var newMessage = Message('Hello World', MessageType.automated);
        messages.insert(0, newMessage);
        DatabaseHelper().saveMessage(newMessage);
      });
    });
  }

  void _loadMessages() async {
    var db = DatabaseHelper();
    var loadedMessages = await db.getMessages();
    setState(() {
      messages.addAll(loadedMessages);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        var newMessage = Message(_controller.text, MessageType.user);
        messages.insert(0, newMessage);
        DatabaseHelper().saveMessage(newMessage);
        _controller.clear();
      }
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MessagesListView(messages: messages),
        ChatInputArea(
          controller: _controller,
          focusNode: _focusNode,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              _sendMessage();
            }
          },
        ),
      ],
    );
  }
}
