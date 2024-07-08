import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/checkout.dart';
import '../screens/home.dart';
import '../screens/product_dtails.dart';
import '../service/service.dart';

class ProductModel with ChangeNotifier {
  late Future<List<dynamic>> _productsFuture;
  final img = "http://api.timbu.cloud/images/";

  List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> _addedItems = [];
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get items => _addedItems;
  List<Map<String, dynamic>> get cartItems => _cartItems;

  Service productsService = Service();

  String getCurrentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }

  addToCart(Map<String, dynamic> product, BuildContext context) {
    if (!_addedItems.contains(product)) {
      _cartItems.add(product);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product['name']} added to cart'),
          duration: Duration(seconds: 2),
        ),
      );
      notifyListeners();
    }
  }

  removeFromCart(Map<String, dynamic> product, BuildContext context) {
    _cartItems.remove(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} removed from cart'),
        duration: Duration(seconds: 2),
      ),
    );
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var item in _cartItems) {
      total +=
          double.tryParse(item['current_price'][0]['NGN'][0].toString()) ?? 0.0;
    }
    return total;
  }

  checkout(BuildContext context) {
    double totalPrice = getTotalPrice();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(
          totalPrice: totalPrice,
          productItems: _cartItems,
        ),
      ),
    );
  }

  // Method to clear all items in the cart
  clearAllCart(BuildContext context) {
    _cartItems.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All items removed from cart'),
        duration: Duration(seconds: 2),
      ),
    );
    notifyListeners(); // Notify listeners after state change
  }

  handleCheckout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Checkout Successful"),
          content: Text(
              "Price Checked Out: \$${getTotalPrice().toStringAsFixed(2)}"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
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

  productView(String id, context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetails(),
      ),
    );
  }

  int _counter = 0;
  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    if (_counter > 0) {
      _counter--;
      notifyListeners();
    }
  }

  int get currentCount => _counter;
}
