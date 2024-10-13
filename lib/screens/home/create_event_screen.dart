// lib/screens/home/create_event_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/event_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/event.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _description;
  String _eventType = 'Workshop';
  DateTime _dateTime = DateTime.now();
  String? _location;
  String _visibility = 'public';

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final token = authProvider.token;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: eventProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    CustomTextField(
                      labelText: 'Title',
                      onSaved: (value) => _title = value,
                    ),
                    CustomTextField(
                      labelText: 'Description',
                      onSaved: (value) => _description = value,
                      maxLines: 3,
                    ),
                    // Event Type Dropdown
                    DropdownButtonFormField<String>(
                      value: _eventType,
                      decoration: InputDecoration(labelText: 'Event Type'),
                      items: ['Workshop', 'Conference', 'Meetup', 'Webinar']
                          .map((type) => DropdownMenuItem(
                                child: Text(type),
                                value: type,
                              ))
                          .toList(),
                      onChanged: (value) => _eventType = value!,
                    ),
                    // Date & Time Picker
                    ListTile(
                      title: Text('Date & Time: $_dateTime'),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _dateTime,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(_dateTime),
                          );
                          if (time != null) {
                            setState(() {
                              _dateTime = DateTime(
                                date.year,
                                date.month,
                                date.day,
                                time.hour,
                                time.minute,
                              );
                            });
                          }
                        }
                      },
                    ),
                    CustomTextField(
                      labelText: 'Location',
                      onSaved: (value) => _location = value,
                    ),
                    // Visibility Dropdown
                    DropdownButtonFormField<String>(
                      value: _visibility,
                      decoration: InputDecoration(labelText: 'Visibility'),
                      items: ['public', 'private', 'interest-based']
                          .map((vis) => DropdownMenuItem(
                                child: Text(vis),
                                value: vis,
                              ))
                          .toList(),
                      onChanged: (value) => _visibility = value!,
                    ),
                    SizedBox(height: 16),
                    CustomButton(
                      text: 'Create Event',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final newEvent = Event(
                            id: '',
                            hostId: authProvider.user!.id,
                            title: _title!,
                            description: _description,
                            eventType: _eventType,
                            dateTime: _dateTime,
                            location: _location,
                            visibility: _visibility,
                            attendees: [],
                            teamMembers: [],
                          );
                          final success =
                              await eventProvider.createEvent(newEvent, token!);
                          if (success) {
                            Navigator.pop(context);
                          } else {
                            // Handle creation failure
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Event creation failed. Please try again.')),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
