// lib/services/event_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event.dart';
import '../utils/constants.dart';

class EventService {
  /// Retrieves a list of events.
  Future<List<Event>> getEvents(String token) async {
    final response = await http.get(
      Uri.parse('$API_BASE_URL/events'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Event> events = (data as List)
          .map((eventJson) => Event.fromJson(eventJson))
          .toList();
      return events;
    } else {
      throw Exception(_handleError(response));
    }
  }

  /// Creates a new event.
  Future<Event?> createEvent(Event event, String token) async {
    final response = await http.post(
      Uri.parse('$API_BASE_URL/events'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(event.toJson()),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Event.fromJson(data);
    } else {
      throw Exception(_handleError(response));
    }
  }

  /// Updates an existing event.
  Future<bool> updateEvent(Event event, String token) async {
    final response = await http.put(
      Uri.parse('$API_BASE_URL/events/${event.id}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(event.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(_handleError(response));
    }
  }

  /// Deletes an event.
  Future<bool> deleteEvent(String eventId, String token) async {
    final response = await http.delete(
      Uri.parse('$API_BASE_URL/events/$eventId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 204) {
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
