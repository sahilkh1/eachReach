// lib/providers/user_provider.dart

import 'package:flutter/material.dart';
import '../models/profile.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  Profile? _profile;
  bool _isLoading = false;

  Profile? get profile => _profile;
  bool get isLoading => _isLoading;

  Future<void> fetchUserProfile(String userId, String token) async {
    _isLoading = true;
    notifyListeners();
    try {
      _profile = await _userService.getProfile(userId, token);
    } catch (e) {
      // Handle error
      print('Error fetching user profile: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateUserProfile(Profile updatedProfile, String token) async {
    _isLoading = true;
    notifyListeners();
    try {
      bool success = await _userService.updateProfile(updatedProfile, token);
      if (success) {
        _profile = updatedProfile;
        notifyListeners();
        return true;
      }
    } catch (e) {
      // Handle error
      print('Error updating user profile: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }
}
