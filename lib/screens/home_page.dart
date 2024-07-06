import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/bottom_nav.dart';
import '../components/category.dart';
import '../components/product_card.dart';
import '../components/products.dart';
import '../utils/colors.dart';
import '../service/service.dart';
import 'cart.dart';

// Homepage declaring a stateful widget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  Service useService = Service();

  Future<void> fetchProducts() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["products"];
    });
  }

  @override
  void initState() {
    super.initState();
    //fetchProducts();
    useService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(
        items: _addedItems,
        cartItems: _addedItems,
      ),
      backgroundColor: textWhite,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: null,
                  ),
                  Container(
                    child: null,
                  ),
                  Text(
                    "ShopVerse",
                    style: TextStyle(color: textBlue, fontSize: 24),
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CartView(cartItems: _addedItems),
                        ),
                      );
                    },
                  ),
                ]),
          ),
          _items.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: Products(
                            features: CategoryFeatures(
                              categoryText1: Text(
                                "Best Gadgets  ",
                                style:
                                    TextStyle(fontSize: 20, color: textBlack),
                              ),
                              categoryText2: Text(
                                "view ",
                                style: TextStyle(fontSize: 16, color: textBlue),
                              ),
                              categoryFunction1: () {},
                              categoryFunction2: () {},
                            ),
                            card1: ProductCard(
                              product_image:
                                  Image.network(_items[index]["image"]),
                              product_text: Text(_items[index]['name']),
                              product_price: Text(_items[index]['price']),
                              click: TextButton(
                                onPressed: () {
                                  addToCart(_items[index]);
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.black,
                                ).copyWith(
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                ),
                                child: Text("Add"),
                              ),
                              product_desc: Text("Add"),
                            ),
                          ),
                        );
                      }),
                )
              : Container(
                  child: Center(
                  child: CircularProgressIndicator(),
                )),
        ],
      ),
    );
  }
}
