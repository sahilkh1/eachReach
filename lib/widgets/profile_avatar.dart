// lib/widgets/profile_avatar.dart

import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;

  const ProfileAvatar({
    this.imageUrl,
    this.radius = 24,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: imageUrl != null
          ? NetworkImage(imageUrl!)
          : AssetImage('assets/images/default_avatar.png') as ImageProvider,
    );
  }
}
