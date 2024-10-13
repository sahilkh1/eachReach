// lib/screens/home/messaging_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/messaging_provider.dart';
import '../../providers/auth_provider.dart';
import 'chat_screen.dart';

class MessagingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final messagingProvider = Provider.of<MessagingProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final token = authProvider.token;
    final userId = authProvider.user?.id ?? '';

    // Fetch conversations or messages
    // For simplicity, we'll assume a list of recent messages

    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: messagingProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: messagingProvider.messages.length,
              itemBuilder: (context, index) {
                final message = messagingProvider.messages[index];
                return ListTile(
                  leading: CircleAvatar(
                    // Display the receiver's avatar
                  ),
                  title: Text('Conversation with ${message.receiverId}'),
                  subtitle: Text(message.content),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          conversationId: message.receiverId,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
