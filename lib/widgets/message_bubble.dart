// lib/widgets/message_bubble.dart

import 'package:flutter/material.dart';
import '../models/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageBubble({
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(12),
      bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0),
      bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
    );

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: isMe ? Colors.blueAccent : Colors.grey[300],
          borderRadius: borderRadius,
        ),
        child: Text(
          message.content,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
