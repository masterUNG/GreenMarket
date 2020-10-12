import 'package:flutter/material.dart';

import 'package:greenmarket/utility/my_styte.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:greenmarket/utility/signout_process.dart';
import 'package:greenmarket/widget/information_shop.dart';

import 'package:greenmarket/widget/list_product_menu_shop.dart';
import 'package:greenmarket/widget/order_list_shop.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MainShop extends StatefulWidget {
  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {
  String username;
   Widget currentWidget = OrderListShop();
    

  @override
  void initState() {
    super.initState();
    findUser();
  }

  void routeToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(username == null ? 'Main Shop' : '$username login'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => signOutProcess(context))
        ],
      ),
    drawer: showDrawer(),
      body: currentWidget,
    );
  }
Drawer showDrawer() => Drawer(
           child: ListView(
             children: <Widget>[
               showHeadDrawer(),
               product(),
               order(),
               store(),
               signOutMenu(),
            ],
            ),
         );
  //สินค้า
         ListTile product() {
    return ListTile(
      leading: Icon(Icons.library_add),
      title: Text('สินค้า'),
      subtitle: Text('รายการสินค้า ของร้าน'),
     onTap: () {
            setState(() {
            currentWidget = ListProductMenuShop();
          });
          Navigator.pop(context);
        },
      );
  }
//รายการที่ลูกค้าสั่งซื้อ
  ListTile  order() {
    return ListTile(
        leading: Icon(Icons.local_grocery_store),
        title: Text('รายการที่ลูกค้าสั่งซื้อ'),
        subtitle: Text('รายการสินค้าที่ยังไม่ได้ ส่งให้ลูกค้า'),
        onTap: () {
            setState(() {
            currentWidget = OrderListShop();
          });
          Navigator.pop(context);
        },
      );
  }
  ListTile  store() {
    return ListTile(
        leading: Icon(Icons.store),
        title: Text('รายละเอียดร้านค้า'),
         subtitle: Text('รายละเอียด ของร้าน พร้อม Edit'),
        onTap: () {
            setState(() {
            currentWidget = InformationShop();
          });
          Navigator.pop(context);
        },
      );
  }

   ListTile signOutMenu() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('ออกจากระบบ'),
        subtitle: Text('Sign Out และ กลับไป หน้าแรก'),
        onTap: () => signOutProcess(context),
      );

  UserAccountsDrawerHeader showHeadDrawer() {
    return UserAccountsDrawerHeader(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/k.png'), fit: BoxFit.cover),
        ),
        currentAccountPicture: Mystyle().showLogo1(),
        accountName: Text(
          'Green Market',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.black,
          ),
        ),
        accountEmail: Text('ผู้จำหน่าย',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            )));
  }
}


