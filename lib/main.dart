import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const DeliciousApp());

class DeliciousApp extends StatelessWidget {
  const DeliciousApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delicious Food',
      theme: AppTheme.theme,
      home: const WelcomeScreen(),
    );
  }
}
