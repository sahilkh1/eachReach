// lib/utils/validators.dart

class Validators {
  /// Validates that the input is not empty.
  static String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validates that the input is a valid email address.
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates that the password meets minimum length requirements.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  /// Validates that two password fields match.
  static String? validateConfirmPassword(String? value, String? original) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != original) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Add other validators as needed
}
