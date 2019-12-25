import 'package:flutter/material.dart';
import 'package:flutter_shop/wdigets/product_grid.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

enum FilterOptions{
    Favorites,
    All,
}
class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context, listen: false);
    
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('MyShop'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue){
                if(selectedValue == FilterOptions.Favorites){
                  // ...
                  productsContainer.showFavoritesOnly();
                } else{
                  // ...
                  productsContainer.showAll();
                }
              },
              icon: Icon(
                Icons.more_vert
              ), 
             itemBuilder: (_) => [
              PopupMenuItem(child: Text('Only Favorites'), value: FilterOptions.Favorites),
              PopupMenuItem(child: Text('Show All'), value: FilterOptions.All),
            ],)
          ],
        ),
        body: ProductGrid(),
        
      ),
    );
  }
}