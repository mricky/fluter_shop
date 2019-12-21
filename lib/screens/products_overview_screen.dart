import 'package:flutter/material.dart';
import '../wdigets/product_grid.dart';
class ProductsOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('MyShop'),
        ),
        body: ProductGrid(),
      ),
    );
  }
}