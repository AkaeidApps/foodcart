import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

Widget appHeader(
    String title, {
      String? subtitle,
      Widget? trailing,
    }) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: muted,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    ),
  );
}
