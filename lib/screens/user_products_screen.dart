
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../wdigets/user_products_item.dart';
import '../wdigets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(appBar: AppBar(
      title: const Text('Your Products'),
      actions: <Widget>[

          IconButton(
            icon: const Icon(Icons.add),
            onPressed: (){
              // ..
            },
          )
      ],
    ),
    body: Padding(
      padding: EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: productsData.items.length,
        itemBuilder: (_, i) => Column(
          children: <Widget>[
            UserProductsItem(
              productsData.items[i].id,
              productsData.items[i].title,
              productsData.items[i].imageUrl),
              Divider(),
          ],
        ),
      ),
    ),
    drawer: AppDrawer(),
    );
  }
}