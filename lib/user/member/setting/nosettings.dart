import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'General Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              SwitchListTile(
                title: Text('Dark Mode'),
                value: false, // Add logic to toggle dark mode
                onChanged: (value) {}, // Add logic to handle switch state change
              ),
              ListTile(
                title: Text('Language'),
                subtitle: Text('English'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to language settings page
                },
              ),
              Divider(),
              Text(
                'Notification Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              SwitchListTile(
                title: Text('Push Notifications'),
                value: true, // Add logic to toggle push notifications
                onChanged: (value) {}, // Add logic to handle switch state change
              ),
              SwitchListTile(
                title: Text('Email Notifications'),
                value: true, // Add logic to toggle email notifications
                onChanged: (value) {}, // Add logic to handle switch state change
              ),
              Divider(),
              Text(
                'Account Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text('Change Password'),
                onTap: () {
                  // Navigate to change password page
                },
              ),
              ListTile(
                title: Text('Logout'),
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