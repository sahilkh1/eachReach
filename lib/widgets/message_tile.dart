// lib/widgets/message_tile.dart

import 'package:flutter/material.dart';
import '../models/message.dart';
import 'profile_avatar.dart';

class MessageTile extends StatelessWidget {
  final Message message;
  final VoidCallback? onTap;

  const MessageTile({
    required this.message,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Assuming you have a way to get the other user's name and avatar
    final otherUserName = message.receiverId; // Replace with actual name
    final lastMessage = message.content;

    return ListTile(
      onTap: onTap,
      leading: const ProfileAvatar(
        imageUrl: null, // Replace with actual image URL
      ),
      title: Text(
        otherUserName,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: message.isRead
          ? null
          : Icon(Icons.circle, color: Colors.blueAccent, size: 12),
    );
  }
}
