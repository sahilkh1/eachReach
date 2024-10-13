// lib/widgets/event_card.dart

import 'package:flutter/material.dart';
import '../models/event.dart';
import 'package:eachreach_front/lib/utils/helpers.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback? onTap;

  const EventCard({
    required this.event,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      child: ListTile(
        onTap: onTap,
        leading: Icon(Icons.event, color: Theme.of(context).primaryColor),
        title: Text(
          event.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${Helpers.formatDateTime(event.dateTime)}\n${event.location ?? 'Online'}',
          style: TextStyle(fontSize: 14),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
