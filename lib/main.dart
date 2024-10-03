import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:task3/payment.dart';
import 'package:task3/setting.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !const bool.fromEnvironment('dart.vm.product'),
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: PaymentPage(),
    );
  }
}

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final Color primaryColor = Color(0xFFF4B5A4);
  int _selectedIndex = 0;
  String _selectedMethod = '**** **** **** 67';

  final List<Widget> _pages = [
    Center(child: Text('Home Page')),
    Center(child: Text('List Page')),
    Center(child: Text('Cart Page')),
    Center(child: Text('Favorites Page')),
    Center(child: Text('Profile Page')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Method',
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildPaymentMethod('**** **** **** 67', Icons.credit_card),
            Divider(color: primaryColor),
            _buildPaymentMethod('Apple Pay', Icons.phone_iphone), // Use another icon or custom Apple icon
            Divider(color: primaryColor),
            _buildPaymentMethod('Cash', Icons.payment),
            Divider(color: primaryColor),
            _buildPaymentMethod('PayPal', Icons.payment), // Use custom icon or another suitable icon for PayPal
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Navigate to AddCardScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                minimumSize: Size(double.infinity, 50), // Full width button
              ),
              child: Text('Add New Card', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black54,
        unselectedItemColor: primaryColor,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildPaymentMethod(String name, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(name, style: TextStyle(fontSize: 18)),
      trailing: _buildCheckCircle(name == _selectedMethod),
      onTap: () {
        setState(() {
          _selectedMethod = name;
        });
      },
    );
  }

  Widget _buildCheckCircle(bool isSelected) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: primaryColor,
          width: 2,
        ),
        color: isSelected ? primaryColor : Colors.white,
      ),
      child: isSelected
          ? Icon(
        Icons.check,
        size: 16,
        color: Colors.white,
      )
          : null,
    );
  }
}

