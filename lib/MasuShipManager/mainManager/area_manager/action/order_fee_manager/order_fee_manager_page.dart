import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../Data/areaData/Area.dart';
import '../../../../Data/costData/Cost.dart';
import 'item_order_fee.dart';

class order_fee_manager_page extends StatefulWidget {
  final String id;
  const order_fee_manager_page({super.key, required this.id});

  @override
  State<order_fee_manager_page> createState() => _order_fee_manager_pageState();
}

class _order_fee_manager_pageState extends State<order_fee_manager_page> {
  final Area area = Area(id: '', name: '', money: 0, status: 0);
  final List<Cost> listCost = [];

  void get_cost_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("CostFee/" + widget.id).onValue.listen((event) {
      listCost.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        if (value['weatherTitle'] == null) {
          Cost cost= Cost.fromJson(value);
          listCost.add(cost);
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
            bottom: 0,
            child: Container(
              child: ListView.builder(
                itemCount: listCost.length,
                itemBuilder: (context, index) {
                  return item_configuration(index: index, width: width, id: widget.id, cost: listCost[index]);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
