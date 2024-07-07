import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/home.dart';
import '../screens/cart.dart';
import '../screens/checkout.dart';
import '../controller/controller.dart'; // Import your ProductModel

class BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductModel>(builder: (context, productModel, child) {
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
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    icon: Icon(Icons.home),
                  ),
                  Text(
                    'Home',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_outline),
                  ),
                  Text(
                    'Wishlist',
                    style: TextStyle(fontSize: 12),
                  ),
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
                              CartView(cartItems: productModel.cartItems),
                        ),
                      );
                    },
                    icon: Icon(Icons.shopping_cart_outlined),
                  ),
                  Text(
                    'Cart',
                    style: TextStyle(fontSize: 12),
                  ),
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
                            totalPrice: productModel.getTotalPrice(),
                            productItems: productModel.cartItems,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.person_4_outlined),
                  ),
                  Text(
                    'Checkout',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
