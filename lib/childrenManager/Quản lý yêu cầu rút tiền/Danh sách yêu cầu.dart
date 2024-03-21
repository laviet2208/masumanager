import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/FinalClass.dart';

import '../../Mainmanager/Quản lý  yêu cầu rút tiền/Itemyeucaurut.dart';
import '../../Mainmanager/Quản lý  yêu cầu rút tiền/yeucauruttien.dart';

class Yeucauruttien extends StatefulWidget {
  final double width;
  final double height;
  const Yeucauruttien({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Yeucauruttien> createState() => _YeucauruttienState();
}

class _YeucauruttienState extends State<Yeucauruttien> {
  List<withdrawRequest> requestList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("withdrawRequest").onValue.listen((event) {
      requestList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        withdrawRequest food= withdrawRequest.fromJson(value);
        if(food.owner.Area == currentAccount.provinceCode) {
          requestList.add(food);
        }
      });
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
              child: Container(
                width: 250,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text(
                  'Xuất danh sách Excel',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontFamily: 'arial',
                      fontSize: 14
                  ),
                ),
              ),
              onTap: () {

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
                    width: (widget.width - 20)/3 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thông tin tài khoản yêu cầu',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'arial',
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
                    width: (widget.width - 20)/3 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Chi tiết yêu cầu',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'arial',
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
                    width: (widget.width - 20)/3 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thao tác',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'arial',
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
            top: 135,
            left: 10,
            child: Container(
              width: widget.width - 20,
              height: widget.height - 170,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
              ),
              child: ListView.builder(
                itemCount: requestList.length,
                itemBuilder: (context, index) {
                  return ITEMdonrut(width: widget.width - 20, height: 120, request: requestList[index],
                    accept: () {

                    }, color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255),
                  );
                },
              ),
            ),
          ),


        ],
      ),
    );
  }
}
