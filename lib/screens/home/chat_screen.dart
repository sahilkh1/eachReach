// lib/screens/home/chat_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/messaging_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/message.dart';
import '../../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String conversationId;

  ChatScreen({required this.conversationId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();

  void _sendMessage(BuildContext context) async {
    final messagingProvider =
        Provider.of<MessagingProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = authProvider.token;
    final userId = authProvider.user?.id ?? '';

    if (_messageController.text.trim().isEmpty) return;

    final message = Message(
      id: '',
      senderId: userId,
      receiverId: widget.conversationId,
      content: _messageController.text.trim(),
      timestamp: DateTime.now(),
      isRead: false,
    );

    await messagingProvider.sendMessage(message, token!);
    _messageController.clear();
  }

  @override
  void initState() {
    super.initState();
    final messagingProvider =
        Provider.of<MessagingProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = authProvider.token;
    messagingProvider.fetchMessages(widget.conversationId, token!);
  }

  @override
  Widget build(BuildContext context) {
    final messagingProvider = Provider.of<MessagingProvider>(context);
    final userId = Provider.of<AuthProvider>(context).user?.id ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.conversationId}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: messagingProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    reverse: true,
                    itemCount: messagingProvider.messages.length,
                    itemBuilder: (context, index) {
                      final message = messagingProvider.messages[index];
                      return MessageBubble(
                        message: message,
                        isMe: message.senderId == userId,
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
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(context),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
