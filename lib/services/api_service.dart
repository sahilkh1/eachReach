// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  Future<dynamic> get(String endpoint, String? token) async {
    final response = await http.get(
      Uri.parse('$API_BASE_URL$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return _processResponse(response);
  }

  Future<dynamic> post(String endpoint, dynamic data, String? token) async {
    final response = await http.post(
      Uri.parse('$API_BASE_URL$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  dynamic _processResponse(http.Response response) {
    final data = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      throw Exception(data['detail'] ?? 'An error occurred');
    }
  }
}
