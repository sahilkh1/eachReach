// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/user_provider.dart';
import 'providers/messaging_provider.dart';
import 'providers/event_provider.dart';
import 'providers/feedback_provider.dart';

import 'utils/themes.dart';

import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<MessagingProvider>(create: (_) => MessagingProvider()),
        ChangeNotifierProvider<EventProvider>(create: (_) => EventProvider()),
        ChangeNotifierProvider<NotificationProvider>(create: (_) => NotificationProvider()),
        ChangeNotifierProvider<FeedbackProvider>(create: (_) => FeedbackProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return MaterialApp(
            title: 'Cross-Domain Networking App',
            theme: appTheme,
            debugShowCheckedModeBanner: false,
            home: authProvider.isAuthenticated ? HomeScreen() : SplashScreen(),
            routes: {
              '/login': (context) => LoginScreen(),
              '/signup': (context) => SignupScreen(),
              '/home': (context) => HomeScreen(),
              // Add other routes as needed
            },
          );
        },
      ),
    );
  }
}
