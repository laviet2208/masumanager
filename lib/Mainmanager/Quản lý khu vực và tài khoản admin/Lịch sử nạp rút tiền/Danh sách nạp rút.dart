import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../dataClass/Lịch sử giao dịch.dart';
import 'Item nạp rút.dart';

class danhsachnaprutadmin extends StatefulWidget {
  final double width;
  final double height;
  const danhsachnaprutadmin({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<danhsachnaprutadmin> createState() => _danhsachnaprutadminState();
}

class _danhsachnaprutadminState extends State<danhsachnaprutadmin> {
  List<historyTransaction> historylist = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("historyTransaction").onValue.listen((event) {
      historylist.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        historyTransaction area= historyTransaction.fromJson(value);
        if (area.type == 3 || area.type == 4) {
          historylist.add(area);
        }

      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
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
                width: 240,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text(
                  'Xuất danh sách excel',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontFamily: 'arial',
                      fontSize: 14
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 70,
            left: 10,
            child: Container(
              width: widget.width - 20,
              height: 80,
              decoration: BoxDecoration(
                  color:  Color.fromARGB(255, 240, 242, 245)
              ),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: widget.width/6 - 1,
                    child:Padding(
                      padding: EdgeInsets.only(top: 30,bottom: 30, left: 30),
                      child: AutoSizeText(
                        'Mã giao dịch',
                        style: TextStyle(
                            fontFamily: 'arial',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 100
                        ),
                      ),
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Colors.black
                    ),
                  ),

                  Container(
                    width: widget.width/5-1,
                    child:Padding(
                      padding: EdgeInsets.only(top: 30,bottom: 30, left: 30),
                      child: AutoSizeText(
                        'Số tiền giao dịch',
                        style: TextStyle(
                            fontFamily: 'arial',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 100
                        ),
                      ),
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Colors.black
                    ),
                  ),

                  Container(
                    width: widget.width/5-1,
                    child:Padding(
                      padding: EdgeInsets.only(top: 30,bottom: 30, left: 30),
                      child: AutoSizeText(
                        'Người thực hiện giao dịch',
                        style: TextStyle(
                            fontFamily: 'arial',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 100
                        ),
                      ),
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Colors.black
                    ),
                  ),

                  Container(
                    width: widget.width/5-1,
                    child:Padding(
                      padding: EdgeInsets.only(top: 30,bottom: 30, left: 30),
                      child: AutoSizeText(
                        'Người thụ hưởng',
                        style: TextStyle(
                            fontFamily: 'arial',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 100
                        ),
                      ),
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Colors.black
                    ),
                  ),

                  Container(
                    width: widget.width/2 - widget.width/5,
                    child:Padding(
                      padding: EdgeInsets.only(top: 30,bottom: 30, left: 30),
                      child: AutoSizeText(
                        'Thao tác',
                        style: TextStyle(
                            fontFamily: 'arial',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 100
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 165,
            left: 10,
            child: Container(
              width: widget.width - 20,
              height: widget.height - 190,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
              ),
              child: ListView.builder(
                itemCount: historylist.length,
                itemBuilder: (context, index) {
                  return Itemnaprutkhuvuc(width: widget.width, history: historylist[index], color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
