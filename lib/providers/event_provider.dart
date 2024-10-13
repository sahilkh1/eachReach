// lib/providers/event_provider.dart

import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/event_service.dart';

class EventProvider with ChangeNotifier {
  final EventService _eventService = EventService();
  List<Event> _events = [];
  bool _isLoading = false;

  List<Event> get events => _events;
  bool get isLoading => _isLoading;

  Future<void> fetchEvents(String token) async {
    _isLoading = true;
    notifyListeners();
    try {
      _events = await _eventService.getEvents(token);
    } catch (e) {
      // Handle error
      print('Error fetching events: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createEvent(Event event, String token) async {
    _isLoading = true;
    notifyListeners();
    try {
      Event? newEvent = await _eventService.createEvent(event, token);
      if (newEvent != null) {
        _events.add(newEvent);
        notifyListeners();
        return true;
      }
    } catch (e) {
      // Handle error
      print('Error creating event: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }

  Future<bool> updateEvent(Event event, String token) async {
    _isLoading = true;
    notifyListeners();
    try {
      bool success = await _eventService.updateEvent(event, token);
      if (success) {
        int index = _events.indexWhere((e) => e.id == event.id);
        if (index != -1) {
          _events[index] = event;
          notifyListeners();
        }
        return true;
      }
    } catch (e) {
      // Handle error
      print('Error updating event: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }

  Future<bool> deleteEvent(String eventId, String token) async {
    _isLoading = true;
    notifyListeners();
    try {
      bool success = await _eventService.deleteEvent(eventId, token);
      if (success) {
        _events.removeWhere((event) => event.id == eventId);
        notifyListeners();
        return true;
      }
    } catch (e) {
      // Handle error
      print('Error deleting event: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }
}
