

import 'package:flutter/material.dart';

class UserProductsItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  UserProductsItem(this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title), 
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl)),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.edit),
              onPressed: (){},
            ),
            IconButton(
              color: Theme.of(context).errorColor,
              icon: Icon(Icons.delete),
              onPressed: (){},
            )
          ],
        ),
      ),
    );
  }
}
