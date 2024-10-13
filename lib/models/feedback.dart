// lib/models/feedback.dart

class FeedbackModel {
  final String id;
  final String? userId; // Optional for anonymous feedback
  final String category; // 'bug_report', 'feature_request', 'general_comment'
  final String text;
  final String status; // 'pending', 'reviewed', 'resolved'
  final DateTime timestamp;

  FeedbackModel({
    required this.id,
    this.userId,
    required this.category,
    required this.text,
    required this.status,
    required this.timestamp,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['_id'] ?? '',
      userId: json['user_id'],
      category: json['category'] ?? '',
      text: json['text'] ?? '',
      status: json['status'] ?? 'pending',
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId,
      'category': category,
      'text': text,
      'status': status,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
