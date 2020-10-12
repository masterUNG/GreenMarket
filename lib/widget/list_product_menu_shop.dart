import 'package:flutter/material.dart';
import 'package:greenmarket/screens/add_product_menu.dart';

class ListProductMenuShop extends StatefulWidget {
  @override
  _ListProductMenuShopState createState() => _ListProductMenuShopState();
}

class _ListProductMenuShopState extends State<ListProductMenuShop> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text('รายการสินค้า'),
        addMenuButton(),
      ],
    );
  }

Widget addMenuButton() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 16.0, right: 16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => AddProductMenu(),
                    );
                    Navigator.push(context, route)
                       ;
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      );
}