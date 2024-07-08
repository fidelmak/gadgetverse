import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/home.dart';
import '../screens/cart.dart';
import '../screens/checkout.dart';
import '../controller/controller.dart';

// bottom nav bar 
class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductModel>(builder: (context, productModel, child) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        color: Colors.white, // custom color 
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
                          builder: (context) => HomeScreen(),// navigating to the home screen 
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
            // button icons with text
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
