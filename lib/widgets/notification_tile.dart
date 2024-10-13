// lib/widgets/notification_tile.dart

import 'package:flutter/material.dart';
import '../models/notification.dart';
import 'package:eachreach_front/lib/utils/helpers.dart';

class NotificationTile extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback? onTap;

  const NotificationTile({
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        notification.isRead ? Icons.notifications : Icons.notifications_active,
        color: notification.isRead ? Colors.grey : Colors.blueAccent,
      ),
      title: Text(
        notification.content,
        style: TextStyle(
          fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: Text(
        Helpers.formatDateTime(notification.timestamp),
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}
