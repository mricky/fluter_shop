import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../wdigets/product_item.dart';
import '../providers/products.dart';

class ProductGrid extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
   
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;

    return GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: products.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
         // builder: (c) => products[i],
          value: products[i],
          child: ProductItem(
            // products[i].id,
            // products[i].title, 
            // products[i].imageUrl),
            ), create: (BuildContext context) {},
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        );
  }
}


