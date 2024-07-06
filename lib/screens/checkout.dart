import 'package:flutter/material.dart';
import 'package:gadgetverse/screens/home.dart';
import 'package:gadgetverse/screens/home_page.dart';

class CheckoutPage extends StatefulWidget {
  final double totalPrice;
  final List items;

  CheckoutPage({required this.totalPrice, required this.items});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late List _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
  }

  void handleCheckout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Checkout Successful"),
          content: Text(
              "Price Checked Out: \$${widget.totalPrice.toStringAsFixed(2)}"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                setState(() {
                  _items.clear();
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void clearCart() {
    setState(() {
      _items.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Theme(
          data: Theme.of(context).copyWith(
            textTheme: const TextTheme(
              bodyText2: TextStyle(color: Colors.black),
            ),
          ),
          child: const Text('All items removed from cart'),
        ),
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Price to Check-Out: \$${widget.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.black,
              ),
              width: screenWidth / 1.5,
              height: screenHeight / 12,
              child: TextButton(
                onPressed: handleCheckout,
                child: Text(
                  "Make Payment",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
