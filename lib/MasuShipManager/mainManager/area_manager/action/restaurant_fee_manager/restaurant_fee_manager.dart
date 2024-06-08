import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/costData/restaurantCost.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/mainManager/area_manager/action/restaurant_fee_manager/change_restaurant_fee.dart';

class restaurant_fee_manager extends StatefulWidget {
  final String id;
  const restaurant_fee_manager({super.key, required this.id});

  @override
  State<restaurant_fee_manager> createState() => _restaurant_fee_managerState();
}

class _restaurant_fee_managerState extends State<restaurant_fee_manager> {
  restaurantCost cost = restaurantCost(discount: 0);

  void get_cost_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("CostFee/" + widget.id).child('restaurantCost').onValue.listen((event) {
      final dynamic costw = event.snapshot.value;
      cost = restaurantCost.fromJson(costw);
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
    double width = MediaQuery.of(context).size.width/4*3;
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
                    width: (width)/3 - 1,
                    alignment: Alignment.center,
                    child: Text(
                      'Loại phí',
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
                    width: (width)/3 - 1,
                    alignment: Alignment.center,
                    child: Text(
                      'Chiết khấu nhà hàng',
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
                    width: (width)/3 - 1,
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
            top: 50,
            left: 0,
            child: Container(
              width: width,
              height: 60,
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
                    width: (width)/3 - 1,
                    alignment: Alignment.center,
                    child: Text(
                      'Phụ phí nhà hàng',
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
                    width: (width)/3 - 1,
                    alignment: Alignment.center,
                    child: Text(
                      cost.discount.toString() + '%',
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
                    width: (width)/4 - 1,
                    alignment: Alignment.center,
                    child: TextButton(
                      child: Text('Cập nhật', style: TextStyle(fontFamily: 'muli', color: Colors.blueAccent, fontSize: 13),),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return change_restaurant_fee(id: widget.id, cost: cost);
                            },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
