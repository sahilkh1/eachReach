// lib/screens/home/event_list_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/event_provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/event_card.dart';
import 'event_detail_screen.dart';
import 'create_event_screen.dart';

class EventListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final token = authProvider.token;

    // Fetch events if not already loaded
    if (eventProvider.events.isEmpty && token != null) {
      eventProvider.fetchEvents(token);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateEventScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: eventProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: eventProvider.events.length,
              itemBuilder: (context, index) {
                final event = eventProvider.events[index];
                return EventCard(
                  event: event,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailScreen(event: event),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
