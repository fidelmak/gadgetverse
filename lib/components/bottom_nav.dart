import 'package:flutter/material.dart';

import '../model/home_page.dart';
import '../screens/cart.dart';
import '../screens/checkout.dart';

class BottomNav extends StatefulWidget {
  final List items;
  final List cartItems; // Add this to pass the items

  const BottomNav(
      {super.key,
      required this.items,
      required this.cartItems}); // Modify the constructor to accept items

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int get totalItems => widget.cartItems.length;
  List get items => widget.cartItems;

  get _cartItems => items;
  double getTotalPrice() {
    double total = 0.0;
    for (var item in widget.cartItems) {
      total += double.tryParse(item['price']) ?? 0.0;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UseApp(),
                        ),
                      );
                    },
                    icon: Icon(Icons.home)),
                Text(
                  'Home',
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.favorite_outline)),
                Text(
                  'Wishlist',
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CartView(cartItems: widget.items),
                        ),
                      );
                    },
                    icon: Icon(Icons.shopping_cart_outlined)),
                Text(
                  'Cart',
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutPage(
                            totalPrice: getTotalPrice(),
                            items: _cartItems,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.person_4_outlined)),
                Text(
                  'Checkout',
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
