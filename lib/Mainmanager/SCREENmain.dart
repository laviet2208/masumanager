import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20%C4%91%C3%A1nh%20gi%C3%A1/%C4%90%C3%A1nh%20gi%C3%A1%20nh%C3%A0%20h%C3%A0ng.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20%C4%91%C3%A1nh%20gi%C3%A1/%C4%90%C3%A1nh%20gi%C3%A1%20t%C3%A0i%20x%E1%BA%BF.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20%C4%91%C6%A1n%20%C4%91%E1%BA%B7t%20xe/Danh%20s%C3%A1ch.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20%C4%91i%E1%BB%81u%20kho%E1%BA%A3n/Qu%E1%BA%A3n%20l%C3%BD%20%C4%91i%E1%BB%81u%20kho%E1%BA%A3n.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20banner/Qu%E1%BA%A3n%20l%C3%BD%20banner%20facebook.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20banner/Quanlybanner.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20t%C3%A0i%20x%E1%BA%BF/Danh%20s%C3%A1ch.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20t%C3%A0i%20x%E1%BA%BF/L%E1%BB%8Bch%20s%E1%BB%AD%20n%E1%BA%A1p%20r%C3%BAt%20t%C3%A0i%20x%E1%BA%BF/Danh%20s%C3%A1ch.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20y%C3%AAu%20c%E1%BA%A7u%20t%C3%A0i%20x%E1%BA%BF/Danh%20s%C3%A1ch%20y%C3%AAu%20c%E1%BA%A7u.dart';
import 'Quản lý  yêu cầu rút tiền/Danh sách yêu cầu.dart';
import 'Quản lý banner/Quản lý banner chính/Quản lý banner chính.dart';
import 'Quản lý khu vực và tài khoản admin/Danh sách khu vực.dart';
import 'Quản lý khu vực và tài khoản admin/Lịch sử nạp rút tiền/Danh sách nạp rút.dart';
import 'Quản lý khu vực và tài khoản admin/Tài khoản admin khu vực/Danh sách tài khoản.dart';
import 'Quản lý khách hàng/Danhsach.dart';
import 'Quản lý nhà hàng danh mục/Danh sách danh mục.dart';
import 'Quản lý nhà hàng/Danh sách shop.dart';
import 'Quản lý store danh mục/Danh sách danh mục.dart';
import 'Quản lý store/Danh sách shop.dart';
import 'Quản lý thông báo/Danh sách.dart';
import 'Quản lý voucher/Danhsach.dart';
import 'Quản lý đơn giao hàng/Danh sách.dart';
import 'Quản lý đơn đi chợ/Danh sách.dart';
import 'Quản lý đơn đồ ăn/Danh sách.dart';

class SCREENmain extends StatefulWidget {
  const SCREENmain({Key? key}) : super(key: key);

  @override
  State<SCREENmain> createState() => _SCREENmainState();
}

class _SCREENmainState extends State<SCREENmain> {
  int selectButton = 6;

  Widget getWidget(int init, double width, double height) {
    if (init == 2) {
      return Danhsachvoucher(width: width, height: height);
    }

    if (init == 3) {
      return Danhsachtaikhoan(width: width, height: height);
    }

    if (init == 4) {
      return Danhsachgiaohang(width: width, height: height);
    }

    if (init == 5) {
      return Danhsachdoan(width: width, height: height);
    }

    if (init == 6) {
      return Danhsachdatxe(width: width, height: height);
    }

    if (init == 7) {
      return danhsachtaixe(width: width, height: height);
    }

    if (init == 8) {
      return Danhsachyeucau(width: width, height: height);
    }

    if (init == 9) {
      return Quanlybanner(width: width, height: height);
    }

    if (init == 10) {
      return PageQuanlyshop(width: width, height: height);
    }

    if (init == 11) {
      return Danhsachkhachhang(width: width, height: height);
    }

    if (init == 12) {
      return Danhsachnapruttaixe(width: width, height: height);
    }

    if (init == 13) {
      return Danhsachyeucaurut(width: width, height: height);
    }

    if (init == 14) {
      return Quanlybannerchinhtrencung(width: width, height: height);
    }

    if (init == 15) {
      return quanlybannerfacebook(width: width, height: height);
    }

    if (init == 16) {
      return Danhsachdanhmuc(width: width, height: height);
    }

    if (init == 17) {
      return PageQuanlystore(width: width, height: height);
    }


    if (init == 18) {
      return Danhsachdanhmucstore(width: width, height: height);
    }

    if (init == 19) {
      return Quanlykhuvuc(width: width, height: height);
    }

    if (init == 20) {
      return danhsachnaprutadmin(width: width, height: height);
    }

    if (init == 21) {
      return Danhsachdicho(width: width, height: height);
    }

    if (init == 22) {
      return Pagequanlythongbao(width: width, height: height);
    }

    if (init == 23) {
      return Quanlydieukhoan(width: width, height: height);
    }

    if (init == 24) {
      return Danhgianhang(width: width, height: height);
    }

    if (init == 25) {
      return Danhgiataixe(width: width, height: height);
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
                                  child: Container(
                                    width: (screenHeight/12 - 20) * 4  - 10,
                                    height: (screenHeight/12 - 20)/2 - 10,
                                    child: AutoSizeText(
                                      'Admin hệ thống',
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
                                      'hiển thị số tiền ',
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
                                        top: ((screenHeight/16)-(screenHeight/35))/2,
                                        left: 15,
                                        child: Icon(
                                          Icons.discount_outlined,
                                          size: screenHeight/35,
                                          color: Colors.white,
                                        )
                                    ),

                                    Positioned(
                                      top: 22,
                                      left: 70,
                                      child: Container(
                                        width: screenWidth/9 - 40,
                                        height: screenHeight/16 - 44,
                                        child: AutoSizeText(
                                          'DS khuyến mãi',
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
                                color: (selectButton == 22) ? Colors.red : null,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                        top: ((screenHeight/16)-(screenHeight/35))/2,
                                        left: 15,
                                        child: Icon(
                                          Icons.notifications_active_outlined,
                                          size: screenHeight/35,
                                          color: Colors.white,
                                        )
                                    ),

                                    Positioned(
                                      top: 22,
                                      left: 70,
                                      child: Container(
                                        width: screenWidth/9 - 20,
                                        height: screenHeight/16 - 44,
                                        child: AutoSizeText(
                                          'Quản lý thông báo',
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
                                  selectButton = 22;
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
                                color: (selectButton == 11) ? Colors.red : null,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                        top: ((screenHeight/16)-(screenHeight/35))/2,
                                        left: 15,
                                        child: Icon(
                                          Icons.account_circle_outlined,
                                          size: screenHeight/35,
                                          color: Colors.white,
                                        )
                                    ),

                                    Positioned(
                                      top: 22,
                                      left: 70,
                                      child: Container(
                                        width: screenWidth/9 - 20,
                                        height: screenHeight/16 - 44,
                                        child: AutoSizeText(
                                          'Khách hàng',
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
                                  selectButton = 11;
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
                                color: (selectButton == 23) ? Colors.red : null,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                        top: ((screenHeight/16)-(screenHeight/35))/2,
                                        left: 15,
                                        child: Icon(
                                          Icons.policy_outlined,
                                          size: screenHeight/35,
                                          color: Colors.white,
                                        )
                                    ),

                                    Positioned(
                                      top: 22,
                                      left: 70,
                                      child: Container(
                                        width: screenWidth/9 - 20,
                                        height: screenHeight/16 - 44,
                                        child: AutoSizeText(
                                          'Quản lý điều khoản',
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
                                  selectButton = 23;
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
                                              'Đơn giao hàng',
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
                                              'Đơn đồ ăn',
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

                                GestureDetector(
                                  child: Container(
                                    height: screenHeight/16,
                                    color: (selectButton == 21) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth/9 - 20,
                                            height: screenHeight/16 - 44,
                                            child: AutoSizeText(
                                              'Đơn đi chợ',
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
                                      selectButton = 21;
                                    });
                                  },
                                ),

                                GestureDetector(
                                  child: Container(
                                    height: screenHeight/16,
                                    color: (selectButton == 6) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth/9 - 20,
                                            height: screenHeight/16 - 44,
                                            child: AutoSizeText(
                                              'Đơn gọi xe',
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
                                      selectButton = 6;
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
                                      'Qlý tài xế',
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
                                    height: screenHeight/16,
                                    color: (selectButton == 7) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth/9 - 20,
                                            height: screenHeight/16 - 44,
                                            child: AutoSizeText(
                                              'DS tài xế',
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
                                      selectButton = 7;
                                    });
                                  },
                                ),

                                GestureDetector(
                                  child: Container(
                                    height: screenHeight/16,
                                    color: (selectButton == 8) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth/9 - 20,
                                            height: screenHeight/16 - 44,
                                            child: AutoSizeText(
                                              'Hồ sơ đăng ký tài xế',
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
                                      selectButton = 8;
                                    });
                                  },
                                ),

                                GestureDetector(
                                  child: Container(
                                    height: screenHeight/16,
                                    color: (selectButton == 13) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth/9 - 20,
                                            height: screenHeight/16 - 44,
                                            child: AutoSizeText(
                                              'Yêu cầu rút tiền',
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
                                      selectButton = 13;
                                    });
                                  },
                                ),

                                GestureDetector(
                                  child: Container(
                                    height: screenHeight/16,
                                    color: (selectButton == 12) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth/9 - 20,
                                            height: screenHeight/16 - 44,
                                            child: AutoSizeText(
                                              'Lịch sử nạp / rút',
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
                                      selectButton = 12;
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
                                Icons.ads_click,
                                color: Colors.white,
                              ),
                              iconColor: Colors.white,
                              collapsedIconColor: Colors.white,
                              title: Container(
                                  alignment: Alignment.centerLeft,
                                  child : Padding(
                                    padding: EdgeInsets.only(top: 15,bottom: 15),
                                    child: Text(
                                      'Qlý Banner',
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
                                    height: screenHeight / 16,
                                    color: (selectButton == 9) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth / 9 - 20,
                                            height: screenHeight / 16 - 44,
                                            child: AutoSizeText(
                                              'Banner nhà hàng',
                                              style: TextStyle(
                                                fontFamily: 'arial',
                                                fontSize: 20, // Điều chỉnh kích thước phù hợp với bạn
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectButton = 9;
                                    });
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                    height: screenHeight / 16,
                                    color: (selectButton == 15) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth / 9 - 20,
                                            height: screenHeight / 16 - 44,
                                            child: AutoSizeText(
                                              'Banner facebook',
                                              style: TextStyle(
                                                fontFamily: 'arial',
                                                fontSize: 20, // Điều chỉnh kích thước phù hợp với bạn
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectButton = 15;
                                    });
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                    height: screenHeight / 16,
                                    color: (selectButton == 14) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth / 9 - 20,
                                            height: screenHeight / 16 - 44,
                                            child: AutoSizeText(
                                              'Banner top',
                                              style: TextStyle(
                                                fontFamily: 'arial',
                                                fontSize: 20, // Điều chỉnh kích thước phù hợp với bạn
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectButton = 14;
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
                                Icons.restaurant,
                                color: Colors.white,
                              ),
                              iconColor: Colors.white,
                              collapsedIconColor: Colors.white,
                              title: Container(
                                  alignment: Alignment.centerLeft,
                                  child : Padding(
                                    padding: EdgeInsets.only(top: 15,bottom: 15),
                                    child: Text(
                                      'Qlý nhà hàng',
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
                                    height: screenHeight/16,
                                    color: (selectButton == 10) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth/9 - 20,
                                            height: screenHeight/16 - 44,
                                            child: AutoSizeText(
                                              'Nhà hàng',
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
                                      selectButton = 10;
                                    });
                                  },
                                ),

                                GestureDetector(
                                  child: Container(
                                    height: screenHeight/16,
                                    color: (selectButton == 16) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth/9 - 20,
                                            height: screenHeight/16 - 44,
                                            child: AutoSizeText(
                                              'Danh mục nhà hàng',
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
                                      selectButton = 16;
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
                                Icons.storefront,
                                color: Colors.white,
                              ),
                              iconColor: Colors.white,
                              collapsedIconColor: Colors.white,
                              title: Container(
                                  alignment: Alignment.centerLeft,
                                  child : Padding(
                                    padding: EdgeInsets.only(top: 15,bottom: 15),
                                    child: Text(
                                      'Qlý cửa hàng',
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
                                    height: screenHeight/16,
                                    color: (selectButton == 17) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth/9 - 20,
                                            height: screenHeight/16 - 44,
                                            child: AutoSizeText(
                                              'Cửa hàng',
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
                                      selectButton = 17;
                                    });
                                  },
                                ),

                                GestureDetector(
                                  child: Container(
                                    height: screenHeight/16,
                                    color: (selectButton == 18) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth/9 - 20,
                                            height: screenHeight/16 - 44,
                                            child: AutoSizeText(
                                              'Danh mục cửa hàng',
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
                                      selectButton = 18;
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
                                      'Qlý khu vực',
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
                                    height: screenHeight/16,
                                    color: (selectButton == 19) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth/9 - 20,
                                            height: screenHeight/16 - 44,
                                            child: AutoSizeText(
                                              'Quản lý khu vực',
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
                                      selectButton = 19;
                                    });
                                  },
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
                                              'Quản lý Admin khu vực',
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

                                GestureDetector(
                                  child: Container(
                                    height: screenHeight/16,
                                    color: (selectButton == 20) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth/9 - 20,
                                            height: screenHeight/16 - 44,
                                            child: AutoSizeText(
                                              'Xem lịch sử nạp',
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
                                      selectButton = 20;
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
                                Icons.star_border_purple500_sharp,
                                color: Colors.white,
                              ),
                              iconColor: Colors.white,
                              collapsedIconColor: Colors.white,
                              title: Container(
                                  alignment: Alignment.centerLeft,
                                  child : Padding(
                                    padding: EdgeInsets.only(top: 15,bottom: 15),
                                    child: Text(
                                      'Qlý đánh giá',
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
                                    height: screenHeight/16,
                                    color: (selectButton == 24) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth/9 - 20,
                                            height: screenHeight/16 - 44,
                                            child: AutoSizeText(
                                              'Đánh giá nhà hàng',
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
                                      selectButton = 24;
                                    });
                                  },
                                ),

                                GestureDetector(
                                  child: Container(
                                    height: screenHeight/16,
                                    color: (selectButton == 25) ? Colors.red : null,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 22,
                                          left: 10,
                                          child: Container(
                                            width: screenWidth/9 - 20,
                                            height: screenHeight/16 - 44,
                                            child: AutoSizeText(
                                              'Đánh giá tài xế',
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
                                      selectButton = 25;
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
