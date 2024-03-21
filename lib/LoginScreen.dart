 import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:masumanager/OTHER/Button/Buttontype1.dart';
import 'package:masumanager/dataClass/FinalClass.dart';
import 'package:masumanager/utils/utils.dart';

import ' restaurantManager/Screenmain.dart';
import 'Mainmanager/SCREENmain.dart';
import 'childrenManager/Screenmain.dart';
import 'dataClass/accountShop.dart';

class SCREENLogin extends StatefulWidget {
  const SCREENLogin({Key? key}) : super(key: key);

  @override
  State<SCREENLogin> createState() => _SCREENLoginState();
}

class _SCREENLoginState extends State<SCREENLogin> {
  final usernamecontroller = TextEditingController();
  final passcontroller = TextEditingController();

  String? name = ' ';
  String? pass = '';
  bool loading = false;
  bool loading1 = false;

  Future<void> saveString(String data, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  Future<void> getSavedata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('username');
    pass = prefs.getString('password');
    if (name != null) {
      usernamecontroller.text = name!;
      setState(() {

      });
    }
    if (pass != null) {
      passcontroller.text = pass!;
      setState(() {

      });
    }
  }

  Future<void> getData1(String id) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Area/' + id).onValue.listen((event) async {
      final dynamic account = event.snapshot.value;
      if (account != null) {
        currentArea.changeData(account);
        Navigator.push(context, MaterialPageRoute(builder:(context) => Screenmainchild()));
        setState(() {
          loading = false;
        });
      } else {
        showErrorDialog();
      }
    });
  }

  Future<bool> getData(String username) async {
    bool ch = false;
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('ADMINaccount/' + username).onValue.listen((event) async {
      final dynamic account = event.snapshot.value;
      if (account != null) {
        currentAccount.changeData(account);

        //nếu là admin chính
        if (account['permission'].toString() == "1") {
          await saveString(account['username'].toString(), 'username');
          await saveString(account['password'].toString(), 'password');
          Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmain()));
          setState(() {
            loading = false;
          });
        } else {
          await saveString(account['username'].toString(), 'username');
          await saveString(account['password'].toString(), 'password');
          setState(() {
            loading = false;
          });
        }

      } else {
        showErrorDialog();
      }
    });
    return ch;
  }

  Future<bool> getDatarestaurant(String username, String pass) async {
    bool ch = false;
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Restaurant').onValue.listen((event) async {
      final dynamic account = event.snapshot.value;
      if (account != null) {
        account.forEach((key, value) async {
          accountShop shop = accountShop.fromJson(value);
          if (shop.phoneNum == username && shop.password == pass) {
            currentShop.changeData(value);
            if (currentShop.status == 1) {
              await saveString(currentShop.phoneNum, 'username');
              await saveString(currentShop.password, 'password');
              Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmainRestaurant()));
              setState(() {
                loading1 = false;
              });
            } else {
              setState(() {
                loading1 = false;
              });
              toastMessage('Tài khoản của bạn đang bị khóa');
            }
          }
        });
      }
    });
    return ch;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSavedata();
  }

  void showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Lỗi'),
          content: Text('Sai tên đăng nhập hoặc mật khẩu'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  loading = false;
                  loading1 = false;
                });
                Navigator.of(context).pop(); // Đóng dialog.
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 242, 242, 247),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: (screenWidth - screenWidth/4)/2,
                  left: (screenWidth - screenWidth/4)/2,
                  child: Container(
                    child: ListView(
                      children: [
                        Container(
                          height: screenHeight/8,
                        ),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 0.5,
                                color: Colors.black
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2), // màu của shadow
                                spreadRadius: 5, // bán kính của shadow
                                blurRadius: 7, // độ mờ của shadow
                                offset: Offset(0, 3), // vị trí của shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(height: 20,),

                              Padding(
                                padding: EdgeInsets.only(left: (screenWidth/4 - (screenWidth/4)/3)/2,right: (screenWidth/4 - (screenWidth/4)/3)/2,top: 10),
                                child: Container(
                                  width: (screenWidth/4)/3,
                                  height: (screenWidth/4)/3,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('assets/image/mainLogo.png'),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                ),
                              ),

                              Container(height: 20,),

                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Tên đăng nhập hệ thống',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'arial',
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ),
                              ),

                              Container(height: 10,),

                              Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Container(
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(0),
                                        border: Border.all(
                                          width: 0.5,
                                          color: Colors.black,
                                        )
                                    ),

                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Form(
                                        child: TextFormField(
                                          controller: usernamecontroller,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'arial',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Tên đăng nhập',
                                            hintStyle: TextStyle(
                                              color: Colors.grey.withOpacity(0.7),
                                              fontSize: 16,
                                              fontFamily: 'arial',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                              ),

                              Container(height: 20,),

                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Mật khẩu',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'arial',
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ),
                              ),

                              Container(height: 10,),

                              Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Container(
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                        border: Border.all(
                                          width: 0.5,
                                          color: Colors.black,
                                        )
                                    ),

                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Form(
                                        child: TextFormField(
                                          controller: passcontroller,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'arial',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Mật khẩu',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                              fontFamily: 'arial',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                              ),

                              Container(height: 20,),

                              Padding(
                                padding: EdgeInsets.only(left: 10,right: 10),
                                child: ButtonType1(Height: 50, Width: 600, color: Colors.black, radiusBorder: 0, title: 'Đăng nhập', fontText: 'arial', colorText: Colors.white,
                                  onTap: () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    await getData(usernamecontroller.text.toString());
                                    if (currentAccount.permission == 2) {
                                      await getData1(currentAccount.provinceCode);
                                    }
                                  }, loading: loading,),
                              ),

                              Container(height: 50,)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
