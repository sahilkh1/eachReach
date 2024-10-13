// lib/models/event.dart

class Event {
  final String id;
  final String hostId;
  final String title;
  final String? description;
  final String eventType;
  final DateTime dateTime;
  final String? location;
  final String visibility; // 'public', 'private', 'interest-based'
  final List<String> attendees;
  final List<String> teamMembers;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Event({
    required this.id,
    required this.hostId,
    required this.title,
    this.description,
    required this.eventType,
    required this.dateTime,
    this.location,
    required this.visibility,
    required this.attendees,
    required this.teamMembers,
    this.createdAt,
    this.updatedAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'] ?? '',
      hostId: json['host_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      eventType: json['event_type'] ?? '',
      dateTime: DateTime.parse(json['date_time']),
      location: json['location'],
      visibility: json['visibility'] ?? 'public',
      attendees:
          json['attendees'] != null ? List<String>.from(json['attendees']) : [],
      teamMembers: json['team_members'] != null
          ? List<String>.from(json['team_members'])
          : [],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'host_id': hostId,
      'title': title,
      'description': description,
      'event_type': eventType,
      'date_time': dateTime.toIso8601String(),
      'location': location,
      'visibility': visibility,
      'attendees': attendees,
      'team_members': teamMembers,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
