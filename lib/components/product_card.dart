import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Image product_image;
  final Text product_text;
 
  final Widget click;

  final Text product_price;
  const ProductCard({
    Key? key,
    required this.product_image,
    required this.product_text,
   
    required this.product_price,
    required this.click,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),
      height: screenHeight / 2,
      width: screenWidth / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: product_image,
          ),
          SizedBox(
            height: 10,
          ),
          product_text,
          SizedBox(
            height: 10,
          ),
          Center(child: product_price),
          SizedBox(
            height: 5,
          ),
          click,
         
        ],
      ),
    );
  }
}
