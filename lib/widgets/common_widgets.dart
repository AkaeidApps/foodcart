import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

Widget foodImage(String url, {double? height}) {
  return Image.network(
    url,
    height: height,
    width: double.infinity,
    fit: BoxFit.cover,
    loadingBuilder: (context, child, progress) {
      if (progress == null) return child;
      return Container(
        height: height,
        color: surface,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: green,
          strokeWidth: 2,
        ),
      );
    },
    errorBuilder: (_, __, ___) => Container(
      height: height,
      color: surface,
      alignment: Alignment.center,
      child: const Icon(Icons.restaurant, color: muted, size: 35),
    ),
  );
}

Widget smallButton(IconData icon, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 27,
      height: 27,
      decoration: BoxDecoration(
        color: green,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Icon(icon, size: 15, color: Colors.white),
    ),
  );
}

Widget priceRow(String title, String value, {bool bold = false}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: TextStyle(
            color: bold ? Colors.white : muted,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: bold ? 18 : 14,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: bold ? green : Colors.white,
        ),
      ),
    ],
  );
}

Widget iconCircle(
    IconData icon,
    VoidCallback onTap, {
      Color color = Colors.white,
    }) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        color: surface,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 19),
    ),
  );
}
