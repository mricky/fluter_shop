import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/cart.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail_screen.dart';




class ProductItem extends StatelessWidget {
//   final String id;
//   final String title;
//   final String imageUrl;

//  ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    // cara diatas dapat menggunakan consumer lebih tepat karena hanya dibutuhkan oleh spesifik widget
    return  ClipRRect(
        borderRadius: BorderRadius.circular(10) ,
        child: GridTile(   
             child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(
                  ProductDetailScreen.routeName, arguments: 
                  product.id,
                );
              },
              child: Image.network(
                 product.imageUrl,
                fit: BoxFit.cover,
                ),
             ),
              footer: GridTileBar(
                backgroundColor: Colors.black87,
                leading: Consumer<Product>(
                  // builder: (ctx,product,child) => IconButton(
                  // same way with _
                  builder: (ctx,product,_) => IconButton(
                  icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
                  color: Theme.of(context).accentColor,
                  onPressed: (){
                    product.toogleFavoriteStatus();
                  },
                  ),
                 ),
                 title: Text(product.title, textAlign: TextAlign.center,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  color: Theme.of(context).accentColor,
                 onPressed: (){
                   cart.addItem(product.id, product.price, product.title);
                 },
                ),
                ),  
              ),
           );
  
  }
}