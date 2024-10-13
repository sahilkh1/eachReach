// lib/providers/messaging_provider.dart

import 'package:flutter/material.dart';
import '../models/message.dart';
import '../services/messaging_service.dart';

class MessagingProvider with ChangeNotifier {
  final MessagingService _messagingService = MessagingService();
  List<Message> _messages = [];
  bool _isLoading = false;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> fetchMessages(String conversationId, String token) async {
    _isLoading = true;
    notifyListeners();
    try {
      _messages = await _messagingService.getMessages(conversationId, token);
    } catch (e) {
      // Handle error
      print('Error fetching messages: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendMessage(Message message, String token) async {
    try {
      Message? sentMessage = await _messagingService.sendMessage(message, token);
      if (sentMessage != null) {
        _messages.add(sentMessage);
        notifyListeners();
      }
    } catch (e) {
      // Handle error
      print('Error sending message: $e');
    }
  }

  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }
}
