import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shipperAccount.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/timeKeeping.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Time.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:masumanager/MasuShipManager/mainManager/shipper_manager/shipper_dashboard/dashboard_controller.dart';
import '../../../Data/OrderData/catchOrder.dart';
import '../../../Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import '../../../Data/OrderData/expressOrder/expressOrder.dart';
import '../../../Data/OrderData/foodOrder/foodOrder.dart';
import '../../../Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';

class shipper_dashboard_item extends StatefulWidget {
  final shipperAccount account;
  final Time time;
  final int index;
  const shipper_dashboard_item({super.key, required this.account, required this.time, required this.index});

  @override
  State<shipper_dashboard_item> createState() => _shipper_dashboard_itemState();
}

class _shipper_dashboard_itemState extends State<shipper_dashboard_item> {
  List<CatchOrder> catch_order_list = [];
  List<foodOrder> food_order_list = [];
  List<requestBuyOrder> request_order_list = [];
  List<expressOrder> express_order_list = [];
  List<catchOrderType3> bike_order_list = [];
  bool isKeeping = false;

  void get_order_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").orderByChild('shipper/id').equalTo(widget.account.id).once().then((DatabaseEvent event) {
      final dynamic orders = event.snapshot.value;
      catch_order_list.clear();
      food_order_list.clear();
      request_order_list.clear();
      express_order_list.clear();
      bike_order_list.clear();
      orders.forEach((key, value) {
        if (value['resCost'] != null) {
          foodOrder order = foodOrder.fromJson(value);
          if (order.timeList[1].day == widget.time.day && order.timeList[1].month == widget.time.month && order.timeList[1].year == widget.time.year) {
            food_order_list.add(order);
          }
        } else if (value['receiver'] != null) {
          expressOrder order = expressOrder.fromJson(value);
          if (order.S2time.day == widget.time.day && order.S2time.month == widget.time.month && order.S2time.year == widget.time.year) {
            express_order_list.add(order);
          }
        } else if (value['motherOrder'] != null) {
          catchOrderType3 order = catchOrderType3.fromJson(value);
          if (order.S2time.day == widget.time.day && order.S2time.month == widget.time.month && order.S2time.year == widget.time.year) {
            bike_order_list.add(order);
          }
        } else if (value['buyLocation'] != null) {
          requestBuyOrder order = requestBuyOrder.fromJson(value);
          if (order.S2time.day == widget.time.day && order.S2time.month == widget.time.month && order.S2time.year == widget.time.year) {
            request_order_list.add(order);
          }
        } else {
          CatchOrder order = CatchOrder.fromJson(value);
          if (order.S2time.day == widget.time.day && order.S2time.month == widget.time.month && order.S2time.year == widget.time.year) {
            catch_order_list.add(order);
          }
        }
        setState(() {

        });
      });
    });
  }

  void get_keeping() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("timeKeeping").orderByChild('owner/id').equalTo(widget.account.id).once().then((DatabaseEvent event) {
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        timeKeeping keeping = timeKeeping.fromJson(value);
        if (keeping.dayOff.day == widget.time.day && keeping.dayOff.month == widget.time.month && keeping.dayOff.year == widget.time.year) {
          if (keeping.status == 1) {
            isKeeping = true;
            setState(() {

            });
          }
        }
        setState(() {

        });
      });
    });
  }

  Duration get_all_time() {
    return dashboard_controller.total_time_of_catch_order(catch_order_list) + dashboard_controller.total_time_of_food_order(food_order_list) +
        dashboard_controller.total_time_of_catch_3_order(bike_order_list) + dashboard_controller.total_time_of_express_order(express_order_list) +
        dashboard_controller.total_time_of_request_order(request_order_list);
  }

  double get_total_income() {
    return dashboard_controller.get_total_catch_income(catch_order_list) + dashboard_controller.get_total_catch_3_income(bike_order_list) +
        dashboard_controller.get_total_express_income(express_order_list) + dashboard_controller.get_total_food_income(food_order_list) +
        dashboard_controller.get_total_request_income(request_order_list);
  }

  bool checkKeeping(int hour) {
    if (hour >= 1) {
      return true;
    }

    if (hour < 1 && isKeeping) {
      return true;
    }

    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_order_data();
    get_keeping();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/5*4 - 20;
    return Container(
      height: 70,
      width: width,
      decoration: BoxDecoration(
        color: widget.index % 2 == 0 ? Colors.white : Color.fromARGB(255, 247, 250, 255),
        border: Border.all(
          color: Color.fromARGB(255, 240, 240, 240),
          width: 1.0,
        ),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            width: width/6 - 1,
            child: Center(
              child: Text(
                getTimeString(widget.time),
                style: TextStyle(
                  fontFamily: 'muli',
                  fontWeight: FontWeight.normal,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ),

          Container(width: 1, decoration: BoxDecoration(color: Color.fromARGB(255, 225, 225, 226)),),

          Container(
            width: width/6 - 1,
            child: Center(
              child: Text(
                catch_order_list.length.toString() + ' Đơn',
                style: TextStyle(
                  fontFamily: 'muli',
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          Container(width: 1, decoration: BoxDecoration(color: Color.fromARGB(255, 225, 225, 226)),),

          Container(
            width: width/6 - 1,
            child: Center(
              child: Text(
                request_order_list.length.toString() + ' Đơn',
                style: TextStyle(
                  fontFamily: 'muli',
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          Container(width: 1, decoration: BoxDecoration(color: Color.fromARGB(255, 225, 225, 226)),),

          Container(
            width: width/6 - 1,
            child: Center(
              child: Text(
                food_order_list.length.toString() + ' Đơn',
                style: TextStyle(
                  fontFamily: 'muli',
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          Container(width: 1, decoration: BoxDecoration(color: Color.fromARGB(255, 225, 225, 226)),),

          Container(
            width: width/6 - 1,
            child: Center(
              child: Text(
                express_order_list.length.toString() + ' Đơn',
                style: TextStyle(
                  fontFamily: 'muli',
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          Container(width: 1, decoration: BoxDecoration(color: Color.fromARGB(255, 225, 225, 226)),),

          Container(
            width: width/6 - 1,
            child: Center(
              child: Text(
                get_all_time().inHours.toString() + ' giờ, ' + get_all_time().inMinutes.remainder(60).toString() + ' phút',
                style: TextStyle(
                  fontFamily: 'muli',
                  fontWeight: checkKeeping(get_all_time().inHours) ? FontWeight.bold : FontWeight.normal,
                  color: checkKeeping(get_all_time().inHours) ? (isKeeping ? Colors.blueAccent : Colors.green) : Colors.redAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
