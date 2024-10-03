import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  Map<String, bool> notifications = {
    'General Notification': true,
    'Sound': true,
    'Sound Call': true,
    'Vibrate': false,
    'Special Offers': true,
    'Payments': false,
    'Promo And Discount': true,
    'Cashback': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: TextStyle(color: Color(0xFFF4B5A4)), // Correctly set title style
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: notifications.keys.map((String key) {
          return SwitchListTile(
            title: Text(
              key,
              style: TextStyle(color: Colors.black54),
            ),
            value: notifications[key]!,
            onChanged: (bool value) {
              setState(() {
                notifications[key] = value;
              });
            },
            activeColor: Color(0xFFF4B5A4), // Correctly set active color
            inactiveThumbColor: Color(0xFFFAF0E6), // Use Color for the inactive thumb
          );
        }).toList(),
      ),
    );
  }
}