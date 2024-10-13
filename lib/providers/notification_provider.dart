// lib/providers/notification_provider.dart

import 'package:flutter/material.dart';
import '../models/notification.dart';
import '../services/notification_service.dart';

class NotionProvider with ChangeNotifier {
  final NotificationService _notificationService = NotificationService();
  List<AppNotification> _notifications = [];
  bool _isLoading = false;

  List<AppNotification> get notifications => _notifications;
  bool get isLoading => _isLoading;

  Future<void> fetchNotifications(String token) async {
    _isLoading = true;
    notifyListeners();
    try {
      _notifications = await _notificationService.getNotifications(token);
    } catch (e) {
      // Handle error
      print('Error fetching notifications: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markAsRead(String notificationId, String token) async {
    try {
      bool success =
          await _notificationService.markAsRead(notificationId, token);
      if (success) {
        int index =
            _notifications.indexWhere((notif) => notif.id == notificationId);
        if (index != -1) {
          _notifications[index].isRead = true;
          notifyListeners();
        }
      }
    } catch (e) {
      // Handle error
      print('Error marking notification as read: $e');
    }
  }

  void addNotification(AppNotification notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }
}
