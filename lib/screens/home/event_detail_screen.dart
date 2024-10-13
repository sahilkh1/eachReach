// lib/screens/home/event_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/event.dart';
import '../../providers/event_provider.dart';
import '../../providers/auth_provider.dart';

class EventDetailScreen extends StatelessWidget {
  final Event event;

  EventDetailScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final token = authProvider.token;

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        actions: [
          if (event.hostId == authProvider.user?.id)
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Navigate to edit event screen
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              event.description ?? 'No Description',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Date & Time: ${event.dateTime}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Location: ${event.location ?? 'No Location'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            // Display attendees, team members, etc.
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.event_available),
        onPressed: () {
          // Handle event RSVP or join action
        },
      ),
    );
  }
}
