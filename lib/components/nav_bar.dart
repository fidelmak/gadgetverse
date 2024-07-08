import 'package:flutter/material.dart';
import 'package:gadgetverse/controller/controller.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

class ProfileNav extends StatefulWidget {
  const ProfileNav({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  State<ProfileNav> createState() => _ProfileNavState();
}

class _ProfileNavState extends State<ProfileNav> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductModel>(builder: (context, productModel, child) {
      return Padding(
        padding: const EdgeInsets.all(0.0),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 37, 37, 37),
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.collections_bookmark_rounded,
                    size: 15.0, // Size of the icon
                    color: textWhite,
                  ),
                ),
              ),
              Center(
                  child: Text(
                "GADGETVERSE",
                style: TextStyle(color: priColor),
              )),
              Container(
                decoration: BoxDecoration(
                  // Background color
                  shape: BoxShape.rectangle, // Shape of the container
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        size: 18,
                        color: textWhite,
                      ),
                    ),
                    Text(
                      '${productModel.counter}',
                      style: TextStyle(fontSize: 12, color: primaryRed),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [],
        ),
      );
    });
  }
}
