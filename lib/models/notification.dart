// lib/models/notification.dart

class AppNotification {
  final String id;
  final String userId;
  final String type; // e.g., 'message', 'event_update'
  final String content;
  final bool isRead;
  final DateTime timestamp;

  AppNotification({
    required this.id,
    required this.userId,
    required this.type,
    required this.content,
    required this.isRead,
    required this.timestamp,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['_id'] ?? '',
      userId: json['user_id'] ?? '',
      type: json['type'] ?? '',
      content: json['content'] ?? '',
      isRead: json['is_read'] ?? false,
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId,
      'type': type,
      'content': content,
      'is_read': isRead,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
