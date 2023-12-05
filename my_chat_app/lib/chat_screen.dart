// lib/screens/chat_screen.dart

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:my_chat_app/message_model.dart';
import 'package:my_chat_app/message_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Message> _messagesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with AI"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messagesList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: _buildMessageBubble(_messagesList[index].message),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await _sendMessage();
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String message) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Future<void> _sendMessage() async {
    final messageContent = _controller.text.trim();
    if (messageContent.isNotEmpty) {
      try {
        final response = await MessageService.sendMessage(messageContent);
        setState(() {
          _messagesList.add(response);
          print('Messages List: $_messagesList');
        });
      } catch (e) {
        log("Error sending message: $e");
        // Handle error as needed
      }
      _controller.clear();
    }
  }
}
