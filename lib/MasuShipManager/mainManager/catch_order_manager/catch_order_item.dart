import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/mainManager/ingredient/text_line_in_item.dart';
import '../catch_order_manager/action/delete_order/delete_order.dart';
import '../catch_order_manager/action/view_log_catch_order/view_log_button.dart';
import '../../Data/OrderData/catchOrder.dart';
import '../../Data/areaData/Area.dart';
import '../../Data/otherData/Tool.dart';
import 'action/cancel_order.dart';

class catch_order_item extends StatefulWidget {
  final CatchOrder order;
  final int index;
  const catch_order_item({Key? key, required this.order, required this.index}) : super(key: key);

  @override
  State<catch_order_item> createState() => _catch_order_itemState();
}

class _catch_order_itemState extends State<catch_order_item> {
  double orderDis = 0;
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

    String status = '';
    if (widget.order.status == 'A') {
      status = 'Chờ đẩy đơn cho shipper';
    }

    if (widget.order.status == 'B') {
      status = 'Đơn đã đẩy cho shipper ' + widget.order.shipper.name;
    }

    if (widget.order.status == 'C') {
      status = 'Shipper đã đón khách';
    }

    if (widget.order.status == 'D') {
      status = 'Hoàn thành';
    }

    if (widget.order.status == 'E') {
      status = 'Bị khách hủy';
    }

    if (widget.order.status == 'E1') {
      status = 'Bị admin hủy';
    }


    return Container(
      width: width,
      height: 190,
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
            width: width/5-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Mã đơn : ', content: widget.order.id),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Khoảng cách: ', content: widget.order.locationGet.longitude == 0 ? 'Chưa tới nơi' : ('~' + getStringNumber(getDistanceOfBike(widget.order.cost, widget.order.costFee)) + ' Km')),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Tên khách : ', content: widget.order.owner.name),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Sđt khách hàng : ', content: widget.order.owner.phone),

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
            width: width/5-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Điểm đón khách : ', content: widget.order.locationSet.longitude != 0 ? widget.order.locationSet.mainText : 'Hiện chưa đến nơi'),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Điểm trả khách : ', content: widget.order.locationGet.longitude != 0 ? widget.order.locationGet.mainText : 'Hiện chưa đến nơi'),

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
            width: width/5-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Giá trị đơn gốc : ', content: widget.order.cost != 0 ? (getStringNumber(widget.order.cost) + ' VNĐ') : 'Chưa tới nơi'),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Giá trị đơn thực tế : ', content: widget.order.cost != 0 ? (getStringNumber(widget.order.cost - getVoucherSale(widget.order.voucher, widget.order.cost)).toString() + ' VNĐ') : 'Chưa tới nơi'),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Chiết khấu : ', content: widget.order.cost != 0 ? (getStringNumber(getShipDiscount(widget.order.cost, widget.order.costFee)) + 'VNĐ') : 'Chưa tới nơi'),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Phụ thu thời tiết : ', content: getStringNumber(widget.order.subFee) + ' VNĐ'),

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
            width: width/5-1,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Trạng thái : ', content: status),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Tài xế : ', content: widget.order.shipper.id != '' ? widget.order.shipper.name : 'Chưa đẩy cho tài xế'),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Khu vực : ', content: area.name),

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
            width: width/5-1,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  view_log_button(order: widget.order),

                  Container(height: 4,),

                  delete_order(id: widget.order.id),

                  Container(height: 4,),

                  cancel_order(order: widget.order,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
