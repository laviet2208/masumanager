import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20banner/Itembanner.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20banner/Th%C3%AAm%20s%E1%BB%ADa%20banner/S%E1%BB%ADa%20banner%20c%E1%BB%A7a%20h%C3%A0ng.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20banner/Th%C3%AAm%20s%E1%BB%ADa%20banner/Th%C3%AAm%20banner%20c%E1%BB%ADa%20h%C3%A0ng.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20voucher/page%20t%C3%ACm%20ki%E1%BA%BFm.dart';
import 'package:masumanager/dataClass/Ads/ADStype1.dart';
import 'package:masumanager/dataClass/FinalClass.dart';
import 'package:masumanager/dataClass/Time.dart';
import 'package:masumanager/dataClass/accountShop.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../utils/utils.dart';

class Quanlybanner extends StatefulWidget {
  final double width;
  final double height;
  const Quanlybanner({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Quanlybanner> createState() => _QuanlybannerState();
}

class _QuanlybannerState extends State<Quanlybanner> {
  List<ADStype1> adsList = [];
  String query = '';
  int lengthSearch = 0;
  List<accountShop> filteredList = [];




  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("ADStype1").onValue.listen((event) {
      adsList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        ADStype1 food= ADStype1.fromJson(value);
        if (food.shop.Area == currentAccount.provinceCode) {
          adsList.add(food);
        }
      });
      setState(() {

      });
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              left: 10,
              child: GestureDetector(
                child: Container(
                  width: 240,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    '+ Thêm mới banner cửa hàng',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontFamily: 'muli',
                        fontSize: 14
                    ),
                  ),
                ),
                onTap: () {
                  showDialog (
                    context: context,
                    builder: (BuildContext context) {
                      return AddShopBanner();
                    },
                  );
                },
              ),
            ),

            Positioned(
              top: 80,
              left: 10,
              child: Container(
                width: widget.width - 20,
                height: 50,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 247, 250, 255),
                    border: Border.all(
                        width: 1,
                        color: Color.fromARGB(255, 225, 225, 226)
                    )
                ),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: (widget.width - 20)/4 - 1 - 150,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'ID của Banner',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 100
                            ),
                          )
                      ),
                    ),

                    Container(
                      width: 1,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 225, 225, 226)
                      ),
                    ),

                    Container(
                      width: (widget.width - 20)/4 - 1 + 150,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Tên sự kiện',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 100
                            ),
                          )
                      ),
                    ),

                    Container(
                      width: 1,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 225, 225, 226)
                      ),
                    ),

                    Container(
                      width: (widget.width - 20)/4 + 100,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Nhà hàng liên kết',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 100
                            ),
                          )
                      ),
                    ),

                    Container(
                      width: 1,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 225, 225, 226)
                      ),
                    ),

                    Container(
                      width: (widget.width - 20)/4 - 100,
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Thao tác',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 100
                            ),
                          )
                      ),
                    ),

                    Container(
                      width: 1,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 225, 225, 226)
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 130,
              left: 10,
              child: Container(
                width: widget.width - 20,
                height: widget.height - 140,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255)
                ),
                child: ListView.builder(
                  itemCount: adsList.length,
                  itemBuilder: (context, index) {
                    return ITEMbanner(width: widget.width, height: 120, adStype1: adsList[index], color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255),
                      updateEvent: () {
                        showDialog (
                          context: context,
                          builder: (BuildContext context) {
                            return SuaBannerShop(adStype1: adsList[index]);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
