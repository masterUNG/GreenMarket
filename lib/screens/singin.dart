import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:greenmarket/model/user_model.dart';
import 'package:greenmarket/screens/main_admin.dart';
import 'package:greenmarket/screens/main_shop.dart';
import 'package:greenmarket/screens/main_user.dart';
import 'package:greenmarket/utility/my_constant.dart';
import 'package:greenmarket/utility/my_styte.dart';
import 'package:greenmarket/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //String get data => null;
  String username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text('LOGIN',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            )),
      ),
    
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[Colors.white, Mystyle().primaryColor],
            center: Alignment(0, -0.3),
            radius: 1.0,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Mystyle().showLogo(),
                Mystyle().mySizebox(),
                Mystyle().showTitle('Green Market'),
                Mystyle().mySizebox(),
                usernameForm(),
                Mystyle().mySizebox(),
                //ปุ่มล็อคอิน
                passwordForm(),
                Mystyle().mySizebox(),
                loginButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() => Container(
        width: 250.0,
        child: RaisedButton(
          color: Mystyle().darkColor,
          onPressed: () {

/*Navigator.push(context,
MaterialPageRoute(builder: (context) => MainShop()));*/
            
            if (username == null ||
                username.isEmpty ||
                password == null ||
                password.isEmpty) {
              normalDialog(context, 'มีช่องว่าง กรุณากรอกให้ครบคะ');
            } else {
              checkAuthen();
            }
          },
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<Null> checkAuthen() async {
    String url =
        '${MyConstant().domain}/GreenMarket1/getUserWhereUser.php?isAdd=true&username=$username';
        print('url ===>> $url');
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('result =$result');
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        if (password == userModel.password) {
          String chooseType = userModel.chooseType;
          if (chooseType == 'dealer') {
            routeTuService(MainShop(), userModel);
          } else if (chooseType == 'buyer') {
            routeTuService(MainUser(), userModel);
          }else if (chooseType == 'admin') {
             routeTuService(MainAdmin(), userModel);
             
          } else {
            normalDialog(context, 'Error');
          }
        } else {
          normalDialog(context, 'password ผิดกรุณาลองใหม่');
        }
      }
    } catch (e) {

    }
  }

  Future<Null> routeTuService(Widget myWidget, UserModel userModel ) async{
 SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', userModel.id);
    preferences.setString('chooseType', userModel.chooseType);
    preferences.setString('name', userModel.name);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  //กรอบเข้าสู่ระบบ
  Widget usernameForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => username = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: Mystyle().darkColor,
            ),
            labelStyle: TextStyle(color: Mystyle().darkColor),
            labelText: 'Username :',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Mystyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Mystyle().primaryColor)),
          ),
        ),
      );

  Widget passwordForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: Mystyle().darkColor,
            ),
            labelStyle: TextStyle(color: Mystyle().darkColor),
            labelText: 'Password :',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Mystyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Mystyle().primaryColor)),
          ),
        ),
      );
}
