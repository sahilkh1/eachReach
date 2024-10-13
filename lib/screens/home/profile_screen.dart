// lib/screens/home/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/auth_provider.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final token = authProvider.token;
    final userId = authProvider.user?.id ?? '';

    // Fetch user profile if not already loaded
    if (userProvider.profile == null && token != null) {
      userProvider.fetchUserProfile(userId, token);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: userProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : userProvider.profile != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: userProvider.profile!.profilePictureUrl != null
                            ? NetworkImage(userProvider.profile!.profilePictureUrl!)
                            : AssetImage('assets/images/default_avatar.png')
                                as ImageProvider,
                      ),
                      SizedBox(height: 16),
                      Text(
                        userProvider.profile!.name ?? 'No Name',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        userProvider.profile!.profession ?? 'No Profession',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      SizedBox(height: 16),
                      Text(
                        userProvider.profile!.bio ?? 'No Bio',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        children: userProvider.profile!.interests?.map((interest) {
                              return Chip(
                                label: Text(interest),
                              );
                            }).toList() ??
                            [],
                      ),
                    ],
                  ),
                )
              : Center(child: Text('No profile data')),
    );
  }
}
