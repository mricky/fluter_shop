import 'package:flutter/material.dart';
import 'package:flutter_shop/wdigets/product_grid.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
class ProductsOverviewScreen extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('MyShop'),
        ),
        body: ProductGrid(),
        
      ),
    );
  }
}