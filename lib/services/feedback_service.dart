// lib/services/feedback_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/feedback.dart';
import '../utils/constants.dart';

class FeedbackService {
  /// Submits feedback to the backend.
  Future<bool> submitFeedback(FeedbackModel feedback, String? token) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.post(
      Uri.parse('$API_BASE_URL/feedback'),
      headers: headers,
      body: jsonEncode(feedback.toJson()),
    );

    if (response.statusCode == 201) {
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
