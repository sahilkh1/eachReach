// lib/screens/auth/signup_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String? _confirmPassword;
  String? _name;

  bool _isLoading = false;

  void _submit() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_password != _confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      bool success = await authProvider.signUp(_email!, _password!, _name!);

      setState(() {
        _isLoading = false;
      });

      if (success) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign up failed. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    CustomTextField(
                      labelText: 'Name',
                      validator: (value) =>
                          value!.isEmpty ? 'Name is required' : null,
                      onSaved: (value) => _name = value,
                    ),
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
                          value!.length < 6 ? 'Password too short' : null,
                      onSaved: (value) => _password = value,
                    ),
                    CustomTextField(
                      labelText: 'Confirm Password',
                      obscureText: true,
                      validator: (value) =>
                          value!.length < 6 ? 'Password too short' : null,
                      onSaved: (value) => _confirmPassword = value,
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      text: 'Sign Up',
                      onPressed: _submit,
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text('Already have an account? Log In'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
