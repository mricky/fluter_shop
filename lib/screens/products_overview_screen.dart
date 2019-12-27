
import 'package:flutter/material.dart';
import 'package:flutter_shop/wdigets/product_grid.dart';
import 'package:provider/provider.dart';
import '../wdigets/badge.dart';
import '../providers/cart.dart';
import '../wdigets/app_drawer.dart';
import 'cart_screen.dart';
import '../providers/products.dart';
enum FilterOptions{
    Favorites,
    All,
}
class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    //Provider.of<Products>(context).fetchAndSetProduct(); WONT WORK;
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
     if(_isInit){
       setState(() {
         _isLoading = true;
       });
        Provider.of<Products>(context).fetchAndSetProduct().then((_){
        setState(() {
            _isLoading = false;
        });
        });
     }
     _isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
        appBar: AppBar(
          title: Text('MyShop'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue){
                setState(() {
                if(selectedValue == FilterOptions.Favorites){
                  _showOnlyFavorites = true;
                } else{
                  // ...
                   _showOnlyFavorites = false;
                }
                });
              },
              icon: Icon(
                Icons.more_vert
              ), 
             itemBuilder: (_) => [
              PopupMenuItem(child: Text('Only Favorites'), value: FilterOptions.Favorites),
              PopupMenuItem(child: Text('Show All'), value: FilterOptions.All
              ),

            ],
            ),
            Consumer<Cart>(builder:(_, cartData, ch) =>  Badge(
              child: ch,
              value: cartData.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart
              ),
              onPressed: (){
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              ),
            )
          ],
        ),
        drawer: AppDrawer(),
        body: _isLoading 
          ? Center(
          child: CircularProgressIndicator(),)
          : ProductGrid(_showOnlyFavorites),
        
      );
    
  }
}