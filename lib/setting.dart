import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart'; // حزمة منع لقطات الشاشة
import 'package:task3/passwordsetting.dart';
import 'notifi.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 0;
  final Color primaryColor = Color(0xFFF4B5A4);

  @override
  void initState() {
    super.initState();
    _disableScreenshots();
  }

  Future<void> _disableScreenshots() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }


  Future<bool> _onWillPop() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('هل تريد الرجوع؟'),
        content: Text('لا يمكنك الرجوع في الوقت الحالي.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('حسنًا'),
          ),
        ],
      ),
    ) ??
        false;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Settings',
            style: TextStyle(
              color: Color(0xFFF4B5A4), // اللون الخاص بالنص
            ),
          ),
        ),
        body: ListView(
          children: [
            // Notification Settings Tile
            ListTile(
              leading: _buildCircleIcon(Icons.notifications),
              title: Text('Notification Settings'),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () {
                // الانتقال إلى إعدادات الإشعارات
              },
            ),
            // Password Settings Tile
            ListTile(
              leading: _buildCircleIcon(Icons.lock),
              title: Text('Password Settings'),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationSettingsScreen()),
                );
              },
            ),
            // Delete Account Tile
            ListTile(
              leading: _buildCircleIcon(Icons.delete),
              title: Text('Delete Account'),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () {
                // حذف الحساب
              },
            ),
          ],
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
      ),
    );
  }

  Widget _buildCircleIcon(IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: primaryColor, // لون الخلفية للدائرة
      ),
      padding: EdgeInsets.all(8.0), // المسافة حول الأيقونة
      child: Icon(
        iconData,
        color: Color(0xFF4B4544), // لون الأيقونة
      ),
    );
  }
}
