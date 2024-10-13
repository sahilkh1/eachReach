// lib/services/notification_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/notification.dart';
import '../utils/constants.dart';

class NotificationService {
  /// Retrieves a list of notifications for the user.
  Future<List<AppNotification>> getNotifications(String token) async {
    final response = await http.get(
      Uri.parse('$API_BASE_URL/notifications'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<AppNotification> notifications = (data as List)
          .map((notifJson) => AppNotification.fromJson(notifJson))
          .toList();
      return notifications;
    } else {
      throw Exception(_handleError(response));
    }
  }

  /// Marks a notification as read.
  Future<bool> markAsRead(String notificationId, String token) async {
    final response = await http.patch(
      Uri.parse('$API_BASE_URL/notifications/$notificationId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'is_read': true}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(_handleError(response));
    }
  }

  /// Handles error responses and extracts error messages.
  String _handleError(http.Response response) {
    final data = jsonDecode(response.body);
    if (data['error'] != null) {
      return data['error'];
    } else if (data['message'] != null) {
      return data['message'];
    } else {
      return 'An unknown error occurred';
    }
  }
}
