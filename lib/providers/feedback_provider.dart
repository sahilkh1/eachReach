// lib/providers/feedback_provider.dart

import 'package:flutter/material.dart';
import '../models/feedback.dart';
import '../services/feedback_service.dart';

class FeedbackProvider with ChangeNotifier {
  final FeedbackService _feedbackService = FeedbackService();
  bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;

  Future<bool> submitFeedback(FeedbackModel feedback, String? token) async {
    _isSubmitting = true;
    notifyListeners();
    try {
      bool success = await _feedbackService.submitFeedback(feedback, token);
      if (success) {
        // Feedback submitted successfully
        return true;
      }
    } catch (e) {
      // Handle error
      print('Error submitting feedback: $e');
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
    return false;
  }
}
