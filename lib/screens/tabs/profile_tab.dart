import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_header.dart';
import '../welcome_screen.dart';

class ProfileTab extends StatelessWidget {
  final String userName;
  final String userEmail;

  const ProfileTab({
    super.key,
    this.userName = 'Food Lover',
    this.userEmail = 'foodlover@example.com',
  });

  @override
  Widget build(BuildContext context) {
    final options = [
      (Icons.person_outline, 'Personal Information'),
      (Icons.location_on_outlined, 'My Addresses'),
      (Icons.payment_outlined, 'Payment Methods'),
      (Icons.history, 'Order History'),
      (Icons.notifications_outlined, 'Notifications'),
      (Icons.help_outline, 'Help & Support'),
      (Icons.settings_outlined, 'Settings'),
    ];

    return SafeArea(
      child: Column(
        children: [
          appHeader(
            'My Profile',
            subtitle: 'Manage your account',
          ),
          const SizedBox(height: 12),
          const CircleAvatar(
            radius: 43,
            backgroundColor: green,
            child: Icon(Icons.person, size: 48, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            userName,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            userEmail,
            style: const TextStyle(color: muted, fontSize: 12),
          ),
          const SizedBox(height: 25),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: options.length,
              itemBuilder: (_, i) {
                final item = options[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 9),
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    onTap: () {
                      showMessage(
                        context,
                        '${item.$2} selected',
                      );
                    },
                    leading: Icon(item.$1, color: green),
                    title: Text(
                      item.$2,
                      style: const TextStyle(fontSize: 13),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: muted,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WelcomeScreen(),
                    ),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout, color: Colors.redAccent),
                label: const Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
