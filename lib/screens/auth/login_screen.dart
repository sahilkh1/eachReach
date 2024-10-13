// lib/screens/auth/login_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        return;
      }
      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken != null) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final success = await authProvider.loginWithGoogle(idToken);
        if (success) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          // Handle login failure
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed. Please try again.')),
          );
        }
      }
    } catch (error) {
      print('Error during Google Sign-In: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
  }

  void _submit() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      bool success = await authProvider.login(_email!, _password!);

      setState(() {
        _isLoading = false;
      });

      if (success) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          labelText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              value!.isEmpty ? 'Email is required' : null,
                          onSaved: (value) => _email = value,
                        ),
                        CustomTextField(
                          labelText: 'Password',
                          obscureText: true,
                          validator: (value) =>
                              value!.isEmpty ? 'Password is required' : null,
                          onSaved: (value) => _password = value,
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          text: 'Log In',
                          onPressed: _submit,
                        ),
                        SizedBox(height: 10),
                        Text('OR'),
                        SizedBox(height: 10),
                        CustomButton(
                          text: 'Sign in with Google',
                          onPressed: _handleGoogleSignIn,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/signup');
                    },
                    child: Text("Don't have an account? Sign Up"),
                  ),
                ],
              ),
            ),
    );
  }
}
