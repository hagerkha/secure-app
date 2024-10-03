import 'package:flutter/material.dart';

class PasswordSettingsScreen extends StatefulWidget {
  @override
  _PasswordSettingsScreenState createState() => _PasswordSettingsScreenState();
}

class _PasswordSettingsScreenState extends State<PasswordSettingsScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  int _selectedIndex = 0;
  final Color primaryColor = Color(0xFFF4B5A4); // Background color for icon circles

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        title: Text(
          'Password Settings',
          style: TextStyle(
            color: primaryColor, // Set the text color to primaryColor
          ),
        ),
        backgroundColor: Colors.white, // Background color of the AppBar
        iconTheme: IconThemeData(color: primaryColor), // Back button color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Current Password TextField
            TextField(
              controller: _currentPasswordController,
              decoration: InputDecoration(
                labelText: 'Current Password',
                filled: true,
                fillColor: Color(0xFFFAF0E6), // Set background color for text field
                suffixIcon: Icon(Icons.visibility_off),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none, // Remove border
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
              ),
              obscureText: true, // Encrypt password input
            ),
            SizedBox(height: 16),
            // Forgot Password Link
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  // Handle forgot password
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: primaryColor), // Set the text color to primaryColor
                ),
              ),
            ),
            SizedBox(height: 16),
            // New Password TextField
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: 'New Password',
                filled: true,
                fillColor: Color(0xFFFAF0E6), // Set background color for text field
                suffixIcon: Icon(Icons.visibility_off),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none, // Remove border
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
              ),
              obscureText: true, // Encrypt password input
            ),
            SizedBox(height: 16),
            // Confirm Password TextField
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                filled: true,
                fillColor: Color(0xFFFAF0E6), // Set background color for text field
                suffixIcon: Icon(Icons.visibility_off),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none, // Remove border
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
              ),
              obscureText: true, // Encrypt password input
            ),
            SizedBox(height: 220),
            // Change Password Button
            ElevatedButton(
              onPressed: () {
                // Handle change password
              },
              child: Text('Change Password'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor, // Button color
                textStyle: TextStyle(color: Colors.black54), // Button text color to white
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners for button
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black54,
        unselectedItemColor: primaryColor,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
