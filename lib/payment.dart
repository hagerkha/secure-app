import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:flutter_localizations/flutter_localizations.dart'; // For localization support


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Method',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const BPaymentMethodScreen(),
    );
  }
}

class BPaymentMethodScreen extends StatefulWidget {
  const BPaymentMethodScreen({Key? key}) : super(key: key);

  @override
  _BPaymentMethodScreenState createState() => _BPaymentMethodScreenState();
}

class _BPaymentMethodScreenState extends State<BPaymentMethodScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 32),
              child: Form( // Wrap the content in a Form widget
                key: _formKey,
                child: Column(
                  children: [
                    _buildCardDetailsStack(context),
                    const SizedBox(height: 32),
                    _buildCardHolderColumn(context),
                    const SizedBox(height: 26),
                    _buildCardNumberColumn(context),
                    const SizedBox(height: 20),
                    _buildExpiryAndCvvRow(context),
                    const SizedBox(height: 54),
                    _buildSaveCardButton(context),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationRow(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      centerTitle: true,
      title: const Text("Add Card"),
    );
  }

  Widget _buildCardDetailsStack(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: Colors.deepOrange[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          height: 194,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.deepOrange[50],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 28, bottom: 22),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "0000 0000 0000 0000", // Card number placeholder
                        style: TextStyle(fontSize: 20, color: Colors.grey[800]),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Card Holder Name", style: TextStyle(color: Colors.grey[800])),
                              const SizedBox(height: 2),
                              Text("Kathryn Murphy"),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Expiry Date", style: TextStyle(color: Colors.grey[800])),
                              Text("04/28"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: fs.Svg('assets/images/your_svg_image.svg'), // Update the path
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardHolderColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Card Holder Name"),
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(hintText: "Kathryn Murphy"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter card holder name';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCardNumberColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Card Number"),
        TextFormField(
          controller: cardNumberController,
          decoration: InputDecoration(hintText: "0000 0000 0000 0000"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter card number';
            } else if (value.length != 19) { // Assuming format "0000 0000 0000 0000"
              return 'Please enter a valid card number';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildExpiryAndCvvRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Expiry Date"),
              TextFormField(
                controller: expiryDateController,
                decoration: InputDecoration(hintText: "MM/YY"),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expiry date';
                  }
                  return null;
                },
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    expiryDateController.text = "${date.month.toString().padLeft(2, '0')}/${date.year.toString().substring(2)}";
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("CVV"),
              TextFormField(
                controller: cvvController,
                decoration: InputDecoration(hintText: "123"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter CVV';
                  } else if (value.length != 3) { // Assuming CVV length is 3
                    return 'Please enter a valid CVV';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSaveCardButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // Save card logic here
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Card details saved successfully")),
          );
        }
      },
      child: const Text("Save Card"),
    );
  }

  Widget _buildBottomNavigationRow(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 58),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.home),
          Icon(Icons.notifications),
          Icon(Icons.shopping_cart),
          Icon(Icons.thumb_up),
          Icon(Icons.lock),
        ],
      ),
    );
  }
}
