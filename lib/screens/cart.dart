import 'package:flutter/material.dart';
import 'package:gadgetverse/controller/controller.dart';
import 'package:gadgetverse/screens/checkout.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  final List cartItems;

  CartView({required this.cartItems});

  final img = "http://api.timbu.cloud/images/";

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Consumer<ProductModel>(
      builder: (context, productModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Check-out Products"),
          ),
          body: Column(
            children: [
              Expanded(
                child: productModel.cartItems.isNotEmpty
                    ? ListView.builder(
                        itemCount: productModel.cartItems.length,
                        itemBuilder: (context, index) {
                          var product = productModel.cartItems[index];
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
                                productModel.removeFromCart(product, context);
                                productModel.decrement();
                              },
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text("No items in the cart"),
                      ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(20),
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
                    productModel.checkout(context);
                  },
                  child: Text(
                    "CheckOut",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
