import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:masumanager/MasuShipManager/mainManager/bike_order_manager/ingredient/view_all_child_order_button.dart';
import '../../Data/areaData/Area.dart';
import '../ingredient/text_line_in_item.dart';

class bike_order_item extends StatefulWidget {
  final motherOrder order;
  final int index;
  const bike_order_item({super.key, required this.order, required this.index});

  @override
  State<bike_order_item> createState() => _bike_order_itemState();
}

class _bike_order_itemState extends State<bike_order_item> {
  final Area area = Area(id: '', name: '', money: 0, status: 0);

  void getDataArea() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area/" + widget.order.owner.area).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      Area a = Area.fromJson(orders);
      area.name = a.name;
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataArea();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 130;
    return Container(
      width: width,
      height: 150,
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

                  text_line_in_item(title: 'Mã đơn : ', content: widget.order.id),

                  Container(height: 15,),

                  text_line_in_item(title: 'Tên khách đặt: ', content: widget.order.owner.name),

                  Container(height: 15,),

                  text_line_in_item(title: 'Sđt khách đặt đơn : 0', content: widget.order.owner.phone),

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

                  text_line_in_item(title: 'Điểm đón khách : ', content: widget.order.locationSet.longitude != 0 ? widget.order.locationSet.mainText : 'Hiện chưa đến nơi'),

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

                  text_line_in_item(title: 'Tạo đơn lúc : ', content: getAllTimeString(widget.order.createTime)),

                  Container(height: 15,),

                  text_line_in_item(title: 'Số lượng đơn đẩy : ', content: widget.order.orderList.length.toString() + ' Đơn'),

                  Container(height: 15,),

                  text_line_in_item(title: 'Trạng thái đơn : ', content: widget.order.status == 'UC' ? 'Còn đơn chưa hoàn thành' : 'Đã hoàn thành mọi đơn'),

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
                    child: view_all_child_order_button(order: widget.order),
                  ),

                  Container(height: 15,),

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
