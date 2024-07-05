import 'package:flutter/material.dart';

class CategoryFeatures extends StatelessWidget {
  final Text categoryText1;
  final Text categoryText2;
  final Function categoryFunction1;
  final Function categoryFunction2;
  const CategoryFeatures({
    Key? key,
    required this.categoryText1,
    required this.categoryText2,
    required this.categoryFunction1,
    required this.categoryFunction2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(onPressed: categoryFunction1(), child: categoryText1),
        TextButton(
          onPressed: categoryFunction2(),
          child: categoryText2,
        ),
      ],
    );
  }
}
