
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../wdigets/order_item.dart';
import '../wdigets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    print('building order');
    //final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: FutureBuilder(
          future: Provider.of<Orders>(context,listen: false).fetchAndSetOrders(),
          builder: (ctx, dataSnapshot){
            if(dataSnapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
            } else {
              if(dataSnapshot.error != null){
                // Do Error
                return Center(child: Text('An error occurred'));
              }
              else {
                return Consumer<Orders>(
                  builder: (ctx, orderData,child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                  ),
                );
              }
            }
          },
      ),  
      drawer: AppDrawer(),
    );
  }
}
