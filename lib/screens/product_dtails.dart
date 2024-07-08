import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../components/bottom_nav.dart';
import '../components/category.dart';
import '../components/nav_bar.dart';
import '../components/product_card.dart';
import '../components/products.dart';
import '../controller/controller.dart';
import '../utils/colors.dart';
import '../service/service.dart';

class ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Consumer<ProductModel>(builder: (context, productModel, child) {
      return Scaffold(
        bottomNavigationBar: BottomNav(),
        backgroundColor: textWhite,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: ProfileNav(screenWidth: screenWidth),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: context.read<ProductModel>().productsService.fetchProduct(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No products found.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var product = snapshot.data![index];
                  final priceList = product['current_price'];
                  String price = 'Price not available';

                  if (priceList != null && priceList.isNotEmpty) {
                    final ngnPrices = priceList[0]['NGN'];
                    if (ngnPrices != null && ngnPrices.isNotEmpty) {
                      price = 'NGN ${ngnPrices[0].toString()}';
                    }
                  }

                  return SingleChildScrollView(
                    child: Products(
                      features: CategoryFeatures(
                        categoryText1: Text(
                          "Hot Sales ✨🔥✨  ",
                          style: TextStyle(fontSize: 20, color: textBlack),
                        ),
                        categoryText2: Text(
                          "${productModel.getCurrentDate()}",
                          style: TextStyle(
                              fontSize: 12,
                              color: textBlue,
                              fontWeight: FontWeight.bold),
                        ),
                        categoryFunction1: () {},
                        categoryFunction2: () {},
                      ),
                      card1: ProductCard(
                        product_image: Image.network(
                          productModel.img + product['photos'][0]['url'],
                          fit: BoxFit.cover,
                        ),
                        product_text: Text(
                          product['name'] ?? 'No Name',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        product_price: Text(
                          price,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                        product_desc: Text(
                            ""), // Text(product['description'] ?? 'No Description'),
                        click: SizedBox(
                          width: 100.0,
                          height: 50.0,
                          child: TextButton(
                            onPressed: () {
                              productModel.addToCart(product, context);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ).copyWith(
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            child: Text("View"),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      );
    });
  }
}
