import 'package:flutter/material.dart';
import 'package:flutter_shop/wdigets/product_item.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
      print(productsData);
   
    return GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: products.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider(
            builder: (c) =>products[i],
            child: ProductItem(),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        );
      
  }
}


