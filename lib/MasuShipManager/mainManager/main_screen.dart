import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/mainManager/restaurant_manager/restaurant_directory_manager/restaurant_directory_manager.dart';
import 'package:masumanager/MasuShipManager/mainManager/restaurant_manager/restaurant_manager_page/free_restaurant_manager.dart';
import 'package:masumanager/MasuShipManager/mainManager/restaurant_manager/restaurant_manager_page/partner_restaurant_manager.dart';
import 'area_manager/area_manager_page.dart';
import 'catch_order_manager/catch_order_manager_page.dart';
import 'customer_manager/customer_manager_main/customer_manager_main.dart';
import 'request_buy_order_manager/request_buy_order_manager_page.dart';
import 'shipper_manager/history_transaction/history_transaction_manager.dart';
import 'shipper_manager/shipper_manager_main/shipper_manager_main_page.dart';


class main_screen extends StatefulWidget {
  const main_screen({Key? key}) : super(key: key);

  @override
  State<main_screen> createState() => _main_screenState();
}

class _main_screenState extends State<main_screen> {
  int selectButton = 10;

  Widget getWidget(int init, double width, double height) {
    if (init == 2) {
      return catch_order_manager_page_();
    }

    if (init == 3) {
      return request_buy_order_manager_page();
    }

    if (init == 4) {
      return partner_restaurant_manager();
    }

    if (init == 5) {
      return free_restaurant_manager();
    }

    if (init == 6) {
      return shipper_manager_main_page();
    }

    if (init == 7) {
      return area_manager_page();
    }

    if (init == 8) {
      return customer_manager_main();
    }

    if (init == 9) {
      return history_transaction_manager();
    }

    if (init == 10) {
      return restaurant_directory_manager();
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 242, 245)
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: screenWidth,
                    height: screenHeight/12,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 21, 41),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            width: screenWidth,
                            height: screenHeight/12,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 0,
                                  left: 10,
                                  bottom: 10,
                                  child: Container(
                                    width: screenHeight/12 - 10,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage('assets/image/mainLogo.png')
                                        )
                                    ),
                                  ),

                                )
                              ],
                            ),
                          ),
                        ),

                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            width: (screenHeight/12 - 20) * 4,
                            height: screenHeight/12 - 20,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 230, 247, 255),
                                border: Border.all(
                                    color: Colors.blueAccent,
                                    width: 2
                                ),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 5,
                                  left: 5,
                                  bottom: 5,
                                  right: 5,
                                  child: Container(
                                    child: Text(
                                      'Admin hệ thống',
                                      style: TextStyle(
                                        fontFamily: 'roboto',
                                        fontSize: 13, // Điều chỉnh font size theo nhu cầu
                                        fontWeight: FontWeight.normal,
                                        color: Colors.blueAccent,
                                      ),
                                      maxLines: 1, // Số dòng tối đa
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Positioned(
                          top: 20,
                          right: (screenHeight/12 - 20) * 4 + 30,
                          child: Text(
                            'V 1.0.0001',
                            style: TextStyle(
                                fontFamily: 'arial',
                                fontSize: 15,
                                color: Colors.white
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: screenHeight/12,
                  left: 0,
                  bottom: 0,
                  right: 10,
                  child: Scaffold(
                    body: Container(
                      width: screenWidth,
                      height: screenHeight - (screenHeight/12),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 30,
                            left: 30,
                            right: 30,
                            bottom: 30,
                            child: Container(
                              height: screenHeight - 60,
                              width: screenWidth - 60,
                              decoration: BoxDecoration(
                                  color: Colors.white
                              ),
                              child: Scaffold(
                                body: getWidget(selectButton, screenWidth - 60, screenHeight - 60),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    floatingActionButton: Builder(builder: (context) {
                      return FloatingActionButton(
                        backgroundColor: Colors.yellow,
                        child: Icon(
                          Icons.menu_sharp,
                          color: Colors.black,
                        ),
                        onPressed: () => Scaffold.of(context).openDrawer(), // <-- Opens drawer.
                      );
                    }),

                    drawer: Drawer(
                      width: screenWidth/5,
                      child: Container(
                        height: screenHeight - (screenHeight/12 + 10),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 0, 21, 41)
                        ),
                        child: ListView(
                          children: [
                            GestureDetector(
                              child: Container(
                                height: 60,
                                color: (selectButton == 1) ? Colors.red : Colors.transparent,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      left: 10,
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Thống kê',
                                          style: TextStyle(
                                              fontFamily: 'arial',
                                              fontSize: 13,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  selectButton = 1;
                                });
                              },
                            ),

                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                  color: Colors.white
                              ),
                            ),

                            ExpansionTile(
                              leading: Icon(
                                Icons.list_alt_outlined,
                                color: Colors.white,
                              ),
                              iconColor: Colors.white,
                              collapsedIconColor: Colors.white,
                              title: Container(
                                  alignment: Alignment.centerLeft,
                                  child : Padding(
                                    padding: EdgeInsets.only(top: 15,bottom: 15),
                                    child: Text(
                                      'Qlý đơn hàng',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: 'roboto',
                                        fontSize: 13, // Điều chỉnh kích thước phù hợp với bạn
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  )
                              ),
                              children: [
                                GestureDetector(
                                  child: Container(
                                    height: 60,
                                    color: (selectButton == 2) ? Colors.red : Colors.transparent,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          left: 10,
                                          top: 0,
                                          bottom: 0,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Đơn gọi xe',
                                              style: TextStyle(
                                                  fontFamily: 'arial',
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectButton = 2;
                                    });
                                  },
                                ),

                                GestureDetector(
                                  child: Container(
                                    height: 60,
                                    color: (selectButton == 3) ? Colors.red : Colors.transparent,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          left: 10,
                                          top: 0,
                                          bottom: 0,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Đơn mua hộ tự do',
                                              style: TextStyle(
                                                  fontFamily: 'arial',
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectButton = 3;
                                    });
                                  },
                                ),

                                GestureDetector(
                                  child: Container(
                                    height: 60,
                                    color: (selectButton == 4) ? Colors.red : Colors.transparent,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          left: 10,
                                          top: 0,
                                          bottom: 0,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Đơn đồ ăn',
                                              style: TextStyle(
                                                  fontFamily: 'arial',
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectButton = 4;
                                    });
                                  },
                                ),

                                GestureDetector(
                                  child: Container(
                                    height: 60,
                                    color: (selectButton == 5) ? Colors.red : Colors.transparent,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          left: 10,
                                          top: 0,
                                          bottom: 0,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Đơn đi chợ',
                                              style: TextStyle(
                                                  fontFamily: 'arial',
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectButton = 5;
                                    });
                                  },
                                ),
                              ],
                            ),

                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                  color: Colors.white
                              ),
                            ),

                            ExpansionTile(
                              leading: Icon(
                                Icons.directions_bike_outlined,
                                color: Colors.white,
                              ),
                              iconColor: Colors.white,
                              collapsedIconColor: Colors.white,
                              title: Container(
                                  alignment: Alignment.centerLeft,
                                  child : Padding(
                                    padding: EdgeInsets.only(top: 15,bottom: 15),
                                    child: Text(
                                      'Quản lý tài xế',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: 'roboto',
                                        fontSize: 13, // Điều chỉnh kích thước phù hợp với bạn
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  )
                              ),
                              children: [
                                GestureDetector(
                                  child: Container(
                                    height: 60,
                                    color: (selectButton == 6) ? Colors.red : Colors.transparent,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          left: 10,
                                          top: 0,
                                          bottom: 0,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Danh sách tài xế',
                                              style: TextStyle(
                                                  fontFamily: 'arial',
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectButton = 6;
                                    });
                                  },
                                ),

                                GestureDetector(
                                  child: Container(
                                    height: 60,
                                    color: (selectButton == 9) ? Colors.red : Colors.transparent,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          left: 10,
                                          top: 0,
                                          bottom: 0,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Lịch sử nạp, rút',
                                              style: TextStyle(
                                                  fontFamily: 'arial',
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectButton = 9;
                                    });
                                  },
                                ),
                              ],
                            ),

                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                  color: Colors.white
                              ),
                            ),

                            ExpansionTile(
                              leading: Icon(
                                Icons.account_circle_outlined,
                                color: Colors.white,
                              ),
                              iconColor: Colors.white,
                              collapsedIconColor: Colors.white,
                              title: Container(
                                  alignment: Alignment.centerLeft,
                                  child : Padding(
                                    padding: EdgeInsets.only(top: 15,bottom: 15),
                                    child: Text(
                                      'Quản lý khách hàng',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: 'roboto',
                                        fontSize: 13, // Điều chỉnh kích thước phù hợp với bạn
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  )
                              ),
                              children: [
                                GestureDetector(
                                  child: Container(
                                    height: 60,
                                    color: (selectButton == 8) ? Colors.red : Colors.transparent,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          left: 10,
                                          top: 0,
                                          bottom: 0,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Danh sách khách hàng',
                                              style: TextStyle(
                                                  fontFamily: 'arial',
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectButton = 8;
                                    });
                                  },
                                ),
                              ],
                            ),

                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                  color: Colors.white
                              ),
                            ),

                            ExpansionTile(
                              leading: Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                              ),
                              iconColor: Colors.white,
                              collapsedIconColor: Colors.white,
                              title: Container(
                                  alignment: Alignment.centerLeft,
                                  child : Padding(
                                    padding: EdgeInsets.only(top: 15,bottom: 15),
                                    child: Text(
                                      'Quản lý khu vực',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: 'roboto',
                                        fontSize: 13, // Điều chỉnh kích thước phù hợp với bạn
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  )
                              ),
                              children: [
                                GestureDetector(
                                  child: Container(
                                    height: 60,
                                    color: (selectButton == 7) ? Colors.red : Colors.transparent,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          left: 10,
                                          top: 0,
                                          bottom: 0,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Danh sách khu vực',
                                              style: TextStyle(
                                                  fontFamily: 'arial',
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectButton = 7;
                                    });
                                  },
                                ),
                              ],
                            ),

                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                  color: Colors.white
                              ),
                            ),

                            ExpansionTile(
                              leading: Icon(
                                Icons.fastfood_outlined,
                                color: Colors.white,
                              ),
                              iconColor: Colors.white,
                              collapsedIconColor: Colors.white,
                              title: Container(
                                  alignment: Alignment.centerLeft,
                                  child : Padding(
                                    padding: EdgeInsets.only(top: 15,bottom: 15),
                                    child: Text(
                                      'Quản lý nhà hàng',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: 'roboto',
                                        fontSize: 13, // Điều chỉnh kích thước phù hợp với bạn
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  )
                              ),
                              children: [
                                GestureDetector(
                                  child: Container(
                                    height: 60,
                                    color: (selectButton == 4) ? Colors.red : Colors.transparent,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          left: 10,
                                          top: 0,
                                          bottom: 0,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Quán đối tác',
                                              style: TextStyle(
                                                  fontFamily: 'arial',
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectButton = 4;
                                    });
                                  },
                                ),

                                GestureDetector(
                                  child: Container(
                                    height: 60,
                                    color: (selectButton == 5) ? Colors.red : Colors.transparent,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          left: 10,
                                          top: 0,
                                          bottom: 0,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Quán tự do',
                                              style: TextStyle(
                                                  fontFamily: 'arial',
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectButton = 5;
                                    });
                                  },
                                ),

                                GestureDetector(
                                  child: Container(
                                    height: 60,
                                    color: (selectButton == 10) ? Colors.red : Colors.transparent,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          left: 10,
                                          top: 0,
                                          bottom: 0,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Danh mục nhà hàng',
                                              style: TextStyle(
                                                  fontFamily: 'arial',
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectButton = 10;
                                    });
                                  },
                                ),
                              ],
                            ),

                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          return false;
        }
    );
  }
}

