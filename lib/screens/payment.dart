import 'package:flutter/material.dart';
import 'package:gadgetverse/screens/home.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Consumer<ProductModel>(
      builder: (context, productModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Checkout'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: screenHeight / 4,
                    width: screenWidth / 1.2,
                    child: Image.asset(
                      "assets/images/pay.jpg",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Accept Payment Request',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                SizedBox(height: 20),
                Container(
                  width: screenWidth / 1.5,
                  height: screenHeight / 12,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      productModel.clearAllCart(context);
                      productModel.delCounter();

                      Future.delayed(Duration(seconds: 1), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      });
                    },
                    child: Text(
                      "Proceed",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
