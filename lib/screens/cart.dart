import 'package:flutter/material.dart';
import 'package:gadgetverse/screens/checkout.dart';

class CartView extends StatefulWidget {
  final List cartItems;

  CartView({required this.cartItems});

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late List _cartItems;

  @override
  void initState() {
    super.initState();
    _cartItems = widget.cartItems;
  }

  void removeFromCart(product) {
    setState(() {
      _cartItems.remove(product);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product['name']} removed from cart'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var item in _cartItems) {
      total += double.tryParse(item['price']) ?? 0.0;
    }
    return total;
  }

  void clearCart() {
    setState(() {
      _cartItems.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All items removed from cart'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void checkout() {
    double totalPrice = getTotalPrice();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(
          totalPrice: totalPrice,
          items: _cartItems,
        ),
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
        title: Text("Check-out Products"),
      ),
      body: Column(
        children: [
          Expanded(
            child: _cartItems.isNotEmpty
                ? ListView.builder(
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network(_cartItems[index]["image"]),
                        title: Text(_cartItems[index]["name"]),
                        subtitle: Text('\$${_cartItems[index]["price"]}'),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () {
                            removeFromCart(_cartItems[index]);
                          },
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text("No items in the cart"),
                  ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.black,
            ),
            width: screenWidth / 1.5,
            height: screenHeight / 12,
            child: TextButton(
                onPressed: checkout,
                child: Text("CheckOut",
                    style: TextStyle(color: Colors.white, fontSize: 24))),
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}
