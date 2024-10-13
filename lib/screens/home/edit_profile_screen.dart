// lib/screens/home/edit_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/profile.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _profession;
  String? _bio;
  List<String> _interests = [];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final token = authProvider.token;

    // Pre-fill form fields with existing data
    if (userProvider.profile != null) {
      _name = userProvider.profile!.name;
      _profession = userProvider.profile!.profession;
      _bio = userProvider.profile!.bio;
      _interests = userProvider.profile!.interests ?? [];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: userProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    CustomTextField(
                      labelText: 'Name',
                      initialValue: _name,
                      onSaved: (value) => _name = value,
                    ),
                    CustomTextField(
                      labelText: 'Profession',
                      initialValue: _profession,
                      onSaved: (value) => _profession = value,
                    ),
                    CustomTextField(
                      labelText: 'Bio',
                      initialValue: _bio,
                      maxLines: 3,
                      onSaved: (value) => _bio = value,
                    ),
                    // Add interests input as needed
                    SizedBox(height: 16),
                    CustomButton(
                      text: 'Save',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final updatedProfile = Profile(
                            userId: authProvider.user!.id,
                            name: _name,
                            profession: _profession,
                            bio: _bio,
                            interests: _interests,
                            profilePictureUrl:
                                userProvider.profile?.profilePictureUrl,
                          );
                          final success = await userProvider
                              .updateUserProfile(updatedProfile, token!);
                          if (success) {
                            Navigator.pop(context);
                          } else {
                            // Handle update failure
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Update failed. Please try again.')),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
