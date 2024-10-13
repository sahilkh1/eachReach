// lib/utils/constants.dart

import 'package:flutter/material.dart';

/// Base URL for the backend API
const String API_BASE_URL = 'http://your-backend-api-url.com/api';

/// Timeout duration for HTTP requests
const Duration HTTP_TIMEOUT = Duration(seconds: 30);

/// Common error messages
class ErrorMessages {
  static const String networkError = 'Please check your internet connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String unknownError = 'An unknown error occurred.';
}

/// Common regular expressions
class RegexPatterns {
  static final RegExp emailPattern = RegExp(
    r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
  );
  // Add other patterns as needed
}

/// Application-wide colors (if not using themes)
class AppColors {
  static const Color primaryColor = Colors.blue;
  static const Color accentColor = Colors.orange;
  // Add other colors as needed
}
