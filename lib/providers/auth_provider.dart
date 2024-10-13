// lib/providers/auth_provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final AuthService _authService = AuthService();

  User? _user;
  bool _isAuthenticated = false;
  String? _token;

  User? get user => _user;
  bool get isAuthenticated => _isAuthenticated;
  String? get token => _token;

  AuthProvider() {
    _loadUser();
  }

  Future<void> _loadUser() async {
    _token = await _storage.read(key: 'token');
    if (_token != null) {
      try {
        _user = await _authService.getCurrentUser(_token!);
        if (_user != null) {
          _isAuthenticated = true;
        } else {
          await logout();
        }
        notifyListeners();
      } catch (e) {
        await logout();
      }
    }
  }

  /// Registers a new user with email, password, and name.
  Future<bool> signUp(String email, String password, String name) async {
    try {
      _token = await _authService.signUp(email, password, name);
      if (_token != null) {
        await _storage.write(key: 'token', value: _token);
        _user = await _authService.getCurrentUser(_token!);
        if (_user != null) {
          _isAuthenticated = true;
          notifyListeners();
          return true;
        }
      }
    } catch (e) {
      // Handle error
      print('Error during sign up: $e');
    }
    return false;
  }

  /// Logs in an existing user with email and password.
  Future<bool> login(String email, String password) async {
    try {
      _token = await _authService.login(email, password);
      if (_token != null) {
        await _storage.write(key: 'token', value: _token);
        _user = await _authService.getCurrentUser(_token!);
        if (_user != null) {
          _isAuthenticated = true;
          notifyListeners();
          return true;
        }
      }
    } catch (e) {
      // Handle error
      print('Error during login: $e');
    }
    return false;
  }

  /// Logs in a user using Google Sign-In.
  Future<bool> loginWithGoogle(String idToken) async {
    try {
      _token = await _authService.googleSignIn(idToken);
      if (_token != null) {
        await _storage.write(key: 'token', value: _token);
        _user = await _authService.getCurrentUser(_token!);
        if (_user != null) {
          _isAuthenticated = true;
          notifyListeners();
          return true;
        }
      }
    } catch (e) {
      // Handle error
      print('Error during Google Sign-In: $e');
    }
    return false;
  }

  /// Logs out the current user.
  Future<void> logout() async {
    _isAuthenticated = false;
    _user = null;
    _token = null;
    await _storage.delete(key: 'token');
    notifyListeners();
  }
}
