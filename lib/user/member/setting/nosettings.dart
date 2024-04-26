import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'General Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: false, // Add logic to toggle dark mode
                onChanged: (value) {}, // Add logic to handle switch state change
              ),
              ListTile(
                title: const Text('Language'),
                subtitle: const Text('English'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to language settings page
                },
              ),
              const Divider(),
              const Text(
                'Notification Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SwitchListTile(
                title: const Text('Push Notifications'),
                value: true, // Add logic to toggle push notifications
                onChanged: (value) {}, // Add logic to handle switch state change
              ),
              SwitchListTile(
                title: const Text('Email Notifications'),
                value: true, // Add logic to toggle email notifications
                onChanged: (value) {}, // Add logic to handle switch state change
              ),
              const Divider(),
              const Text(
                'Account Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: const Text('Change Password'),
                onTap: () {
                  // Navigate to change password page
                },
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () {
                  // Add logout functionality
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}