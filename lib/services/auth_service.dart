// lib/services/auth_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../utils/constants.dart';

class AuthService {
  /// Registers a new user with email, password, and name.
  Future<String?> signUp(String email, String password, String name) async {
    final response = await http.post(
      Uri.parse('$API_BASE_URL/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'name': name,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['access_token'];
    } else {
      throw Exception(_handleError(response));
    }
  }

  /// Logs in an existing user with email and password.
  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$API_BASE_URL/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['access_token'];
    } else {
      throw Exception(_handleError(response));
    }
  }

  /// Logs in a user using Google Sign-In.
  Future<String?> googleSignIn(String idToken) async {
    final response = await http.post(
      Uri.parse('$API_BASE_URL/auth/google-signin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': idToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['access_token'];
    } else {
      throw Exception(_handleError(response));
    }
  }

  /// Fetches the current user's data using the provided token.
  Future<User?> getCurrentUser(String token) async {
    final response = await http.get(
      Uri.parse('$API_BASE_URL/users/me'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
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
