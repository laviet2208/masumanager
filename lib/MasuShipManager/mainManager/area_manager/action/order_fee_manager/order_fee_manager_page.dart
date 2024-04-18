import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../Data/areaData/Area.dart';
import '../../../../Data/costData/Cost.dart';
import '../../../../Data/otherData/Tool.dart';
import 'change_order_fee.dart';
import 'item_order_fee.dart';
import 'package:auto_size_text/auto_size_text.dart';

class order_fee_manager_page extends StatefulWidget {
  final String id;
  const order_fee_manager_page({super.key, required this.id});

  @override
  State<order_fee_manager_page> createState() => _order_fee_manager_pageState();
}

class _order_fee_manager_pageState extends State<order_fee_manager_page> {
  Cost cost = Cost(departKM: 0, departCost: 0, perKMcost: 0, discount: 0);
  
  void get_cost_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("CostFee/" + widget.id).child('Bike').onValue.listen((event) {
      final dynamic costw = event.snapshot.value;
      cost = Cost.fromJson(costw);
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_cost_data();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/2;
    return Container(
      width: width,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: width,
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
                    width: (width)/6 - 1,
                    alignment: Alignment.center,
                    child: Text(
                      'Loại dịch vụ',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'muli',
                          color: Colors.black,
                          fontSize: 13
                      ),
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),

                  Container(
                    width: (width)/6 - 1,
                    alignment: Alignment.center,
                    child: Text(
                      'Số km đề pa',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'muli',
                          color: Colors.black,
                          fontSize: 13
                      ),
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),

                  Container(
                    width: (width)/6 - 1,
                    alignment: Alignment.center,
                    child: Text(
                      'Phí đề pa(đ/km)',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'muli',
                          color: Colors.black,
                          fontSize: 13
                      ),
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),

                  Container(
                    width: (width)/6 - 1,
                    alignment: Alignment.center,
                    child: Text(
                      'Phí mỗi km(đ/km)',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'muli',
                          color: Colors.black,
                          fontSize: 13
                      ),
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),

                  Container(
                    width: (width)/6 - 1,
                    alignment: Alignment.center,
                    child: Text(
                      'Chiết khấu(%)',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'muli',
                          color: Colors.black,
                          fontSize: 13
                      ),
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),

                  Container(
                    width: (width)/6 - 1,
                    alignment: Alignment.center,
                    child: Text(
                      'Thao tác',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'muli',
                          color: Colors.black,
                          fontSize: 13
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 52,
            left: 0,
            right: 0,
            child: Container(
              width: width,
              height: 60,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 240, 240, 240),
                    width: 1.0,
                  ),
                ),
              ),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),


                  Container(
                    width: width/6 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                        child: AutoSizeText(
                          'Phí tài xế',
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
                    width: width/6 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                        child: AutoSizeText(
                          cost.departKM.toString() + ' Km',
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
                    width: width/6 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                        child: AutoSizeText(
                          getStringNumber(cost.departCost),
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
                    width: width/6 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                        child: AutoSizeText(
                          getStringNumber(cost.perKMcost),
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
                    width: width/6 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                        child: AutoSizeText(
                          cost.discount.toString(),
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
                    width: width/6 - 1,
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                width: 0.5,
                                color: Colors.grey
                            )
                        )
                    ),
                    alignment: Alignment.center,
                    child: TextButton(
                      child: Text('Cập nhật', style: TextStyle(fontFamily: 'muli', color: Colors.blueAccent, fontSize: 13),),
                      onPressed: () {
                        showDialog(context: context, builder: (context) {
                          return change_configuration(id: widget.id, cost: cost);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
