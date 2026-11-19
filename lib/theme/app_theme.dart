import 'package:flutter/material.dart';

const Color bg = Color(0xFF222222);
const Color surface = Color(0xFF2D2D2D);
const Color surface2 = Color(0xFF373737);
const Color green = Color(0xFF08AD70);
const Color muted = Color(0xFF999999);

class AppTheme {
  static ThemeData get theme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(
          primary: green,
          surface: surface,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      );
}

String money(double value) => '৳${value.toStringAsFixed(0)}';

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: surface2,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
}
