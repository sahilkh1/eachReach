// lib/screens/home/notification_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final token = authProvider.token;

    // Fetch notifications if not already loaded
    if (notificationProvider.notifications.isEmpty && token != null) {
      notificationProvider.fetchNotifications(token);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: notificationProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: notificationProvider.notifications.length,
              itemBuilder: (context, index) {
                final notification = notificationProvider.notifications[index];
                return ListTile(
                  leading: Icon(notification.isRead
                      ? Icons.notifications
                      : Icons.notifications_active),
                  title: Text(notification.content),
                  subtitle: Text(notification.timestamp.toString()),
                  onTap: () {
                    // Handle notification tap
                    notificationProvider.markAsRead(notification.id, token!);
                  },
                );
              },
            ),
    );
  }
}
