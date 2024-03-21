import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/%20restaurantManager/Danh%20s%C3%A1ch%20%C4%91%C6%A1n%20h%C3%A0ng/Danh%20s%C3%A1ch.dart';
import 'package:masumanager/%20restaurantManager/Qu%E1%BA%A3n%20l%C3%BD%20danh%20m%E1%BB%A5c/Danh%20s%C3%A1ch%20danh%20m%E1%BB%A5c.dart';
import 'package:masumanager/dataClass/FinalClass.dart';

import '../Mainmanager/Quản lý nhà hàng/Danh mục đồ ăn/Hiển thị danh mục.dart';
import 'Danh sách món ăn/Danh sách món ăn.dart';
import 'Danh sách thông báo/Danh sách.dart';

class SCREENmainRestaurant extends StatefulWidget {
  const SCREENmainRestaurant({Key? key}) : super(key: key);

  @override
  State<SCREENmainRestaurant> createState() => _SCREENmainrestaurantState();
}

class _SCREENmainrestaurantState extends State<SCREENmainRestaurant> {
  int selectButton = 1;

  Widget getWidget(int init, double width, double height) {
    if (init == 2) {
      return Danhsachdanhmuc(width: width, height: height, shop: currentShop, data: 'Restaurant',);
    }
    if (init == 3) {
      return Danhsachdoan(width: width, height: height,);
    }
    if (init == 4) {
      return danhsachthongbao(width: width, height: height,);
    }
    if (init == 5) {
      return Danhsachmonannhahang(width: width, height: height,);
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
                        color: Color.fromARGB(255, 0, 21, 41)
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
                                  top: 10,
                                  left: 10,
                                  child: Container(
                                    width: screenHeight/12 - 20,
                                    height: screenHeight/12 - 20,
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
                                  child: Container(
                                    width: (screenHeight/12 - 20) * 4  - 10,
                                    height: (screenHeight/12 - 20)/2 - 10,
                                    child: AutoSizeText(
                                      'Quản lý nhà hàng',
                                      style: TextStyle(
                                        fontFamily: 'arial',
                                        fontSize: 160, // Điều chỉnh font size theo nhu cầu
                                        fontWeight: FontWeight.normal,
                                        color: Colors.blueAccent,
                                      ),
                                      maxLines: 1, // Số dòng tối đa
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 5 + (screenHeight/12 - 20)/2 - 10 + 5,
                                  left: 5,
                                  child: Container(
                                    width: (screenHeight/12 - 20) * 4  - 10,
                                    height: (screenHeight/12 - 20)/2 - 12,
                                    child: AutoSizeText(
                                      currentShop.name,
                                      style: TextStyle(
                                        fontFamily: 'arial',
                                        fontSize: 160, // Điều chỉnh font size theo nhu cầu
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
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
                  child: Container(
                    width: screenWidth,
                    height: screenHeight - (screenHeight/12),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            height: screenHeight - (screenHeight/12 + 10),
                            width: screenWidth/9,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 0, 21, 41)
                            ),
                            child: ListView(
                              children: [
                                GestureDetector(
                                  child: Container(
                                    height: screenHeight/16,
                                    color: (selectButton == 1) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth/9 - 20,
                                            height: screenHeight/16 - 44,
                                            child: AutoSizeText(
                                              'Thống kê',
                                              style: TextStyle(
                                                  fontFamily: 'arial',
                                                  fontSize: 100,
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

                                GestureDetector(
                                  child: Container(
                                    height: screenHeight/16,
                                    color: (selectButton == 2) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth/9 - 20,
                                            height: screenHeight/16 - 44,
                                            child: AutoSizeText(
                                              'Danh mục món ăn',
                                              style: TextStyle(
                                                  fontFamily: 'arial',
                                                  fontSize: 100,
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

                                Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                      color: Colors.white
                                  ),
                                ),

                                GestureDetector(
                                  child: Container(
                                    height: screenHeight/16,
                                    color: (selectButton == 5) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth/9 - 20,
                                            height: screenHeight/16 - 44,
                                            child: AutoSizeText(
                                              'Danh sách món ăn',
                                              style: TextStyle(
                                                  fontFamily: 'arial',
                                                  fontSize: 100,
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

                                Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                      color: Colors.white
                                  ),
                                ),

                                GestureDetector(
                                  child: Container(
                                    height: screenHeight/16,
                                    color: (selectButton == 3) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth/9 - 20,
                                            height: screenHeight/16 - 44,
                                            child: AutoSizeText(
                                              'Danh sách đơn hàng',
                                              style: TextStyle(
                                                  fontFamily: 'arial',
                                                  fontSize: 100,
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

                                Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                      color: Colors.white
                                  ),
                                ),

                                GestureDetector(
                                  child: Container(
                                    height: screenHeight/16,
                                    color: (selectButton == 4) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth/9 - 20,
                                            height: screenHeight/16 - 44,
                                            child: AutoSizeText(
                                              'Thông báo',
                                              style: TextStyle(
                                                  fontFamily: 'arial',
                                                  fontSize: 100,
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

                        Positioned(
                          top: 20,
                          left: screenWidth/9 + 15,
                          child: Container(
                            height: screenHeight - (screenHeight/12 + 10) - 40,
                            width: screenWidth - (screenWidth/9 + 15) - 15,
                            decoration: BoxDecoration(
                                color: Colors.white
                            ),
                            child: Scaffold(
                              body: getWidget(selectButton, screenWidth - (screenWidth/9 + 15) - 15, screenHeight - (screenHeight/12 + 10) - 40),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop:() async {
          return false;
        });
  }
}
