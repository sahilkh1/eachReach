// lib/services/messaging_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/message.dart';
import '../utils/constants.dart';

class MessagingService {
  /// Retrieves messages for a specific conversation.
  Future<List<Message>> getMessages(String conversationId, String token) async {
    final response = await http.get(
      Uri.parse('$API_BASE_URL/conversations/$conversationId/messages'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Message> messages = (data as List)
          .map((messageJson) => Message.fromJson(messageJson))
          .toList();
      return messages;
    } else {
      throw Exception(_handleError(response));
    }
  }

  /// Sends a new message.
  Future<Message?> sendMessage(Message message, String token) async {
    final response = await http.post(
      Uri.parse('$API_BASE_URL/conversations/${message.receiverId}/messages'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(message.toJson()),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Message.fromJson(data);
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
