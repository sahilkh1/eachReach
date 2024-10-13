// lib/services/user_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/profile.dart';
import '../utils/constants.dart';

class UserService {
  /// Retrieves the user's profile by user ID.
  Future<Profile?> getProfile(String userId, String token) async {
    final response = await http.get(
      Uri.parse('$API_BASE_URL/profiles/$userId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Profile.fromJson(data);
    } else {
      throw Exception(_handleError(response));
    }
  }

  /// Updates the user's profile.
  Future<bool> updateProfile(Profile profile, String token) async {
    final response = await http.put(
      Uri.parse('$API_BASE_URL/profiles/${profile.userId}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(profile.toJson()),
    );

    if (response.statusCode == 200) {
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
