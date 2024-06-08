import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/costData/weatherCost.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:masumanager/MasuShipManager/mainManager/area_manager/action/weather_manager/change_weather_cost.dart';

import '../../../../Data/otherData/utils.dart';

class weather_fee_manager extends StatefulWidget {
  final String id;
  const weather_fee_manager({super.key, required this.id});

  @override
  State<weather_fee_manager> createState() => _weather_fee_managerState();
}

class _weather_fee_managerState extends State<weather_fee_manager> {
  weatherCost cost = weatherCost(available: 0, cost: 0, weatherTitle: '');

  void get_cost_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("CostFee/" + widget.id).child('weatherCost').onValue.listen((event) {
      final dynamic costw = event.snapshot.value;
      cost = weatherCost.fromJson(costw);
      setState(() {

      });
    });
  }

  Future<void> change_status(int status) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('CostFee').child(widget.id).child('weatherCost').child('available').set(status);
      toastMessage('Khóa, mở thành công');
      setState(() {

      });
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
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
                    width: (width)/4 - 1,
                    alignment: Alignment.center,
                    child: Text(
                      'Trạng thái thời tiết',
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
                    child: Text(
                      'Phụ phí thời tiết',
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
                    child: Text(
                      'Cho phép áp dụng',
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
              height: 100,
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
                    width: (width)/4 - 1,
                    alignment: Alignment.center,
                    child: Text(
                      cost.weatherTitle,
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
                    child: Text(
                      getStringNumber(cost.cost),
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
                    child: Text(
                      cost.available == 0 ? 'Không khả dụng' : 'Được áp dụng',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'muli',
                          color: cost.available == 0 ? Colors.redAccent : Colors.blueGrey,
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
                    child: Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: ListView(
                        children: [
                          Container(height: 4,),

                          GestureDetector(
                            child: Container(
                              height: 25,
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  border: Border.all(width: 0.5)
                              ),
                              child: Center(
                                child: Text(
                                  'Chỉnh sửa',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return change_weather_cost(id: widget.id, cost: cost);
                                },
                              );
                            },
                          ),

                          Container(height: 10,),

                          GestureDetector(
                            child: Container(
                              height: 25,
                              decoration: BoxDecoration(
                                color: cost.available == 0 ? Colors.redAccent : Colors.green,
                                border: Border.all(width: 0.5),
                              ),
                              child: Center(
                                child: Text(
                                  cost.available == 0 ? 'Mở phụ phí' : 'Đóng phụ phí',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () async {
                              if (cost.available == 0) {
                                await change_status(1);
                              } else {
                                await change_status(0);
                              }
                            },
                          ),
                        ],
                      ),
                    )
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
