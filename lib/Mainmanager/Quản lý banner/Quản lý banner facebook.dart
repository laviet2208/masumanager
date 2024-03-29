import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20banner/Th%C3%AAm%20s%E1%BB%ADa%20banner/S%E1%BB%ADa%20banner%20facebook.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20banner/Th%C3%AAm%20s%E1%BB%ADa%20banner/Th%C3%AAm%20banner%20facebook.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../dataClass/Ads/ADStype2.dart';
import '../../dataClass/Time.dart';
import '../../dataClass/accountShop.dart';
import '../../utils/utils.dart';
import 'Item banner facebook.dart';

class quanlybannerfacebook extends StatefulWidget {
  final double width;
  final double height;
  const quanlybannerfacebook({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<quanlybannerfacebook> createState() => _quanlybannerfacebookState();
}

class _quanlybannerfacebookState extends State<quanlybannerfacebook> {
  List<ADStype2> adsList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("ADStype2").onValue.listen((event) {
      adsList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        ADStype2 food= ADStype2.fromJson(value);
        adsList.add(food);
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
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    '+ Thêm mới banner facebook',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontFamily: 'arial',
                        fontSize: 14
                    ),
                  ),
                ),
                onTap: () {
                  showDialog (
                    context: context,
                    builder: (BuildContext context) {
                      return ThemBannerFace();
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
                            'Liên kết facebook',
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
                    return ITEMbannerFacebook(width: widget.width, height: 120, adStype2: adsList[index],color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255),
                      updateEvent: () {
                        showDialog (
                          context: context,
                          builder: (BuildContext context) {
                            return SuaBannerFace(adStype2: adsList[index]);
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
