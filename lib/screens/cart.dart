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
  final img = "http://api.timbu.cloud/images/";

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

    ;
    for (var item in _cartItems) {
      total +=
          double.tryParse(item['current_price'][0]['NGN'][0].toString()) ?? 0.0;
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
                      var product = _cartItems[index];
                      final priceList = product['current_price'];
                      String price = 'Price not available';
                      if (priceList != null && priceList.isNotEmpty) {
                        final ngnPrices = priceList[0]['NGN'];
                        if (ngnPrices != null && ngnPrices.isNotEmpty) {
                          price = 'NGN ${ngnPrices[0].toString()}';
                        }
                      }

                      return ListTile(
                        leading: Image.network(
                          img + product['photos'][0]['url'],
                        ),
                        title: Text(product['name'] ?? 'No Name'),
                        subtitle: Text(price),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () {
                            removeFromCart(product);
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
