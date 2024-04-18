import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import 'package:masumanager/MasuShipManager/Data/costData/Cost.dart';
import 'package:masumanager/MasuShipManager/Data/finalData/finalData.dart';
import 'package:masumanager/MasuShipManager/Data/locationData/Location.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/mainManager/bike_order_manager/ingredient/cancel_bike_order/cancel_bike_order_controller.dart';
import 'package:masumanager/MasuShipManager/mainManager/bike_order_manager/ingredient/delete_bike_order/delete_bike_order_button.dart';
import 'package:masumanager/MasuShipManager/mainManager/bike_order_manager/ingredient/view_all_child_order_page/view_log_child_order/view_log_button.dart';
import 'package:masumanager/MasuShipManager/mainManager/catch_order_manager/action/delete_order/delete_order.dart';
import '../../../../Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import '../../../../Data/otherData/Time.dart';
import '../../../../Data/otherData/Tool.dart';
import '../../../../Data/voucherData/Voucher.dart';
import '../../../ingredient/text_line_in_item.dart';
import '../cancel_bike_order/cancel_bike_order_button.dart';

class item_child_order extends StatefulWidget {
  final motherOrder order;
  final int index;
  const item_child_order({super.key, required this.order, required this.index});

  @override
  State<item_child_order> createState() => _item_child_orderState();
}

class _item_child_orderState extends State<item_child_order> {

  catchOrderType3 order = catchOrderType3(
      id: generateID(25),
      locationSet: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),
      locationGet: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),
      cost: 0,
      owner: finalData.user_account,
      shipper: finalData.shipper_account,
      status: 'A',
      voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 0, Otype: '', perCustom: 0, CustomList: [], maxSale: 00, area: ''),
      S1time: getCurrentTime(),
      S2time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
      S3time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
      S4time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
      costFee: Cost(departKM: 0, departCost: 0, perKMcost: 0, discount: 0),
      subFee: 0,
      type: 1,
      motherOrder: ''
  );

  void get_child_order_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").child(widget.order.orderList[widget.index]).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      order = catchOrderType3.fromJson(orders);
      setState(() {
        
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_child_order_data();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/4*3 - 70;
    String status = '';
    if (order.status == 'A') {
      status = 'Chờ đẩy đơn cho shipper';
    }

    if (order.status == 'B') {
      status = 'Đơn đã đẩy cho shipper ' + order.shipper.name;
    }

    if (order.status == 'C') {
      status = 'Shipper đã đón khách';
    }

    if (order.status == 'D') {
      status = 'Hoàn thành';
    }

    if (order.status == 'E') {
      status = 'Bị khách hủy';
    }

    if (order.status == 'E1') {
      status = 'Bị admin hủy';
    }
    
    return Container(
      height: 160,
      width: width,
      decoration: BoxDecoration(
        color: widget.index % 2 == 0 ? Colors.white : Color.fromARGB(255, 247, 250, 255),
        border: Border.all(
          color: Color.fromARGB(255, 240, 240, 240),
          width: 1.0,
        ),
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 49,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: Center(
                child: Text(
                  (widget.index + 1).toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'muli',
                    color: Colors.black,
                    fontWeight: FontWeight.bold, // Để in đậm
                  ),
                ),
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: width/4-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Mã đơn con : ', content: order.id),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Điểm đến: ', content: order.locationGet.mainText),

                  Container(height: 20,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: width/4-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Loại đơn : ', content: order.type == 1 ? 'Chở người' : 'Lái xe hộ'),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Trạng thái : ', content: status),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Tài xế : ', content: order.shipper.id != '' ? order.shipper.name : 'Chưa đẩy cho tài xế'),

                  Container(height: 20,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: width/4-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Giá trị đơn gốc : ', content: order.cost != 0 ? (getStringNumber(order.cost).toString() + ' VNĐ') : 'Chưa tới nơi'),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Giá trị đơn thực tế : ', content: order.cost != 0 ? (getStringNumber(order.cost - getVoucherSale(order.voucher, order.cost)).toString() + ' VNĐ') : 'Chưa tới nơi'),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Chiết khấu : ', content: order.cost != 0 ? (order.costFee.discount.toString() + '% (' + getStringNumber(order.costFee.discount/100 * order.cost).toString() + 'VNĐ)') : 'Chưa tới nơi'),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Phụ thu thời tiết : ', content: getStringNumber(order.subFee) + ' VNĐ'),

                  Container(height: 15,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: width/4-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 15,),

                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: cancel_bike_order_button(order: widget.order, orderType3: order),
                  ),

                  Container(height: 10,),

                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: delete_bike_order_button(order: widget.order, orderType3: order,),
                  ),

                  Container(height: 10,),

                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: view_log_button(order: order,),
                  ),

                  Container(height: 15,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
