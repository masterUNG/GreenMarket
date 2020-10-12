import 'package:flutter/material.dart';
import 'package:greenmarket/utility/my_styte.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:greenmarket/utility/signout_process.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainAdmin extends StatefulWidget {
  @override
  _MainAdminState createState() => _MainAdminState();
}

class _MainAdminState extends State<MainAdmin> {
  String username;
  Widget currentWidget;

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
        title: Text(username == null ? 'Main User' : '$username login'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => signOutProcess(context))
        ],
      ),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHeadDrawer(),
            approve(),
            report(),
          ],
        ),
      );

//สินค้า
  ListTile approve() {
    return ListTile(
      leading: Icon(Icons.person_add),
      title: Text('อนุมัติสมาชิก'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => approve());
        Navigator.push(context, route);
      },
    );
  }

//รายการที่ลูกค้าสั่งซื้อ
  ListTile report() {
    return ListTile(
        leading: Icon(Icons.add),
        title: Text('ออกรายงาน'),
        onTap: () {
          Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => report());
          Navigator.push(context, route);
        });
  }

  UserAccountsDrawerHeader showHeadDrawer() {
    return UserAccountsDrawerHeader(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/b.jpg'), fit: BoxFit.cover),
        ),
        currentAccountPicture: Mystyle().showLogo2(),
        accountName: Text(
          'Green Market',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.black,
          ),
        ),
        accountEmail: Text('แอดมิน',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            )));
  }
}
