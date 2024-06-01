import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:masumanager/MasuShipManager/mainManager/dashboard_manager/dashboard_controller.dart';
import 'package:masumanager/MasuShipManager/mainManager/ingredient/text_line_in_item.dart';
import '../../Data/OrderData/catchOrder.dart';
import '../../Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import '../../Data/OrderData/expressOrder/expressOrder.dart';
import '../../Data/OrderData/foodOrder/foodOrder.dart';
import '../../Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';

class month_order_dashboard extends StatefulWidget {
  const month_order_dashboard({super.key});

  @override
  State<month_order_dashboard> createState() => _month_order_dashboardState();
}

class _month_order_dashboardState extends State<month_order_dashboard> {
  List<CatchOrder> catch_order_list = [];
  List<foodOrder> food_order_list = [];
  List<requestBuyOrder> request_order_list = [];
  List<expressOrder> express_order_list = [];
  List<catchOrderType3> bike_order_list = [];

  void get_order_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").once().then((DatabaseEvent event) {
      final dynamic orders = event.snapshot.value;
      catch_order_list.clear();
      food_order_list.clear();
      request_order_list.clear();
      express_order_list.clear();
      bike_order_list.clear();
      orders.forEach((key, value) {
        if (value['resCost'] != null) {
          foodOrder order = foodOrder.fromJson(value);
          if (order.timeList[1].month == DateTime.now().month && order.timeList[1].year == DateTime.now().year) {
            food_order_list.add(order);
          }
        } else if (value['receiver'] != null) {
          expressOrder order = expressOrder.fromJson(value);
          if (order.S2time.month == DateTime.now().month && order.S2time.year == DateTime.now().year) {
            express_order_list.add(order);
          }
        } else if (value['motherOrder'] != null) {
          catchOrderType3 order = catchOrderType3.fromJson(value);
          if (order.S2time.month == DateTime.now().month && order.S2time.year == DateTime.now().year) {
            bike_order_list.add(order);
          }
        } else if (value['buyLocation'] != null) {
          requestBuyOrder order = requestBuyOrder.fromJson(value);
          if (order.S2time.month == DateTime.now().month && order.S2time.year == DateTime.now().year) {
            request_order_list.add(order);
          }
        } else if (value['orderList'] != null) {
          requestBuyOrder order = requestBuyOrder.fromJson(value);
          if (order.S2time.month == DateTime.now().month && order.S2time.year == DateTime.now().year) {
            request_order_list.add(order);
          }
        } else {
          CatchOrder order = CatchOrder.fromJson(value);
          if (order.S2time.month == DateTime.now().month && order.S2time.year == DateTime.now().year) {
            catch_order_list.add(order);
          }
        }
        setState(() {

        });
      });
    });
  }

  double get_total_income() {
    return dashboard_controller.get_total_catch_income(catch_order_list) + dashboard_controller.get_total_catch_3_income(bike_order_list) +
        dashboard_controller.get_total_express_income(express_order_list) + dashboard_controller.get_total_food_income(food_order_list) +
        dashboard_controller.get_total_request_income(request_order_list);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_order_data();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/3 - 40;

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 10),
        child: ListView(
          children: [
            Container(height: 10,),

            Container(
              height: 20,
              child: Row(
                children: [
                  Container(
                    width: 20,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/image/dashboard.png')
                        )
                    ),
                  ),

                  Container(
                    width: 10,
                  ),

                  Container(
                    width: width - 70,
                    child: AutoSizeText(
                      'Thống kê tháng ' + DateTime.now().month.toString() + '/' + DateTime.now().year.toString(),
                      style: TextStyle(
                        fontFamily: 'muli',
                        fontSize: 100,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 25,
            ),

            text_line_in_item(title: 'Đơn chở người: ', content: catch_order_list.length.toString() + ' Đơn. Tổng thu: ' + getStringNumber(dashboard_controller.get_total_catch_income(catch_order_list)) + '.đ', color: Colors.black),

            Container(
              height: 10,
            ),

            text_line_in_item(title: 'Đơn lái hộ: ', content: bike_order_list.length.toString() + ' Đơn. Tổng thu: ' + getStringNumber(dashboard_controller.get_total_catch_3_income(bike_order_list)) + '.đ', color: Colors.black),


            Container(
              height: 10,
            ),

            text_line_in_item(title: 'Đơn Express: ', content: express_order_list.length.toString() + ' Đơn. Tổng thu: '  + getStringNumber(dashboard_controller.get_total_express_income(express_order_list)) + '.đ', color: Colors.black),

            Container(
              height: 10,
            ),

            text_line_in_item(title: 'Đơn Đồ ăn: ', content: food_order_list.length.toString() + ' Đơn. Tổng thu: ' + getStringNumber(dashboard_controller.get_total_food_income(food_order_list)) + '.đ', color: Colors.black),

            Container(
              height: 10,
            ),

            text_line_in_item(title: 'Đơn mua hộ: ', content: request_order_list.length.toString() + ' Đơn. Tổng thu: ' + getStringNumber(dashboard_controller.get_total_request_income(request_order_list)) + '.đ', color: Colors.black),

            Container(
              height: 10,
            ),

            Container(
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Tổng số đơn: ',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'muli',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TextSpan(
                      text: (catch_order_list.length + express_order_list.length + request_order_list.length + bike_order_list.length + food_order_list.length).toString() + ' Đơn',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'muli',
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Container(
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Tổng thu nhập: ',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'muli',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TextSpan(
                      text: getStringNumber(get_total_income()) + '.đ',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'muli',
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
