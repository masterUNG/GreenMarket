
import 'package:flutter/material.dart';
import 'package:greenmarket/utility/my_styte.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:greenmarket/utility/signout_process.dart';
import 'package:greenmarket/widget/order_list_shop.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
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
      appBar: AppBar(backgroundColor: Colors.greenAccent,
        title: Text(username == null ? 'Main User' : '$username login'),
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
               store(),
               cart(),
              order(),
            ],
            ),
         );

//สินค้า
         ListTile store() {
    return ListTile(
      leading: Icon(Icons.store),
      title: Text('ร้านค้า'),
       onTap: () {
            setState(() {
            currentWidget = OrderListShop();
          });
          Navigator.pop(context);
        },
      );
  }
//รายการที่ลูกค้าสั่งซื้อ
  ListTile  cart() {
    return ListTile(
        leading: Icon(Icons.shopping_basket),
        title: Text('สินค้าในตะกร้า'),
        onTap: () {
            setState(() {
            currentWidget = OrderListShop();
          });
          Navigator.pop(context);
        },
      );
  }
  ListTile  order() {
    return ListTile(
        leading: Icon(Icons.shopping_cart),
        title: Text('รายการสั่งซื้อ'),
         onTap: () {
            setState(() {
            currentWidget = OrderListShop();
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
         /* image: DecorationImage(
              image: AssetImage('images/dis.png'), fit: BoxFit.cover),
       */ ),
        currentAccountPicture: Mystyle().showLogo3(),
        accountName: Text(
          'Green Market',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.black,
          ),
        ),
        accountEmail: Text('ผู้ซื้อ',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            )));
  }
}
