import 'package:flutter/material.dart';

import '../components/bottom_nav.dart';
import '../components/category.dart';
import '../components/nav_bar.dart';
import '../components/product_card.dart';
import '../components/products.dart';
import '../utils/colors.dart';
import '../service/service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> _productsFuture;
  final img = "http://api.timbu.cloud/images/";
  List _items = [];
  List _addedItems = [];

  List get items => _addedItems;

  void addToCart(product) {
    setState(() {
      if (!_addedItems.contains(product)) {
        _addedItems.add(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product['name']} added to cart'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _productsFuture = Service().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      bottomNavigationBar: BottomNav(
        items: _addedItems,
        cartItems: _addedItems,
      ),
      backgroundColor: textWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: ProfileNav(screenWidth: screenWidth),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _productsFuture,
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
                        "Best Gadgets  ",
                        style: TextStyle(fontSize: 20, color: textBlack),
                      ),
                      categoryText2: Text(
                        "view ",
                        style: TextStyle(fontSize: 16, color: textBlue),
                      ),
                      categoryFunction1: () {},
                      categoryFunction2: () {},
                    ),
                    card1: ProductCard(
                      product_image: Image.network(
                        img + product['photos'][0]['url'],
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
                            fontSize: 22, fontWeight: FontWeight.normal),
                      ),
                      product_desc: Text(
                          ""), // Text(product['description'] ?? 'No Description'),
                      click: SizedBox(
                        width: 100.0,
                        height: 50.0,
                        child: TextButton(
                          onPressed: () {
                            addToCart(product);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ).copyWith(
                            overlayColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: Text("View"),
                        ),
                      ),
                    ),
                  ),
                );

                // ListTile(
                //   leading: product['photos'].isNotEmpty
                //       ? Image.network(
                //           img + product['photos'][0]['url'],
                //           width: 50,
                //           height: 50,
                //           fit: BoxFit.cover,
                //         )
                //       : Container(
                //           width: 50,
                //           height: 50,
                //           color: Colors.grey[300],
                //         ),
                //   title: Text(product['name'] ?? 'No Name'),
                //   subtitle: Text(product['description'] ?? 'No Description'),
                // );
              },
            );
          }
        },
      ),
    );
  }
}
