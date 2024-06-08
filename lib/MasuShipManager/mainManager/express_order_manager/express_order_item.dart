import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/expressOrder/expressOrder.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:masumanager/MasuShipManager/mainManager/catch_order_manager/action/view_express_order_image.dart';
import 'package:masumanager/MasuShipManager/mainManager/express_order_manager/ingredient/cancel_express_order/cancel_express_button.dart';
import 'package:masumanager/MasuShipManager/mainManager/express_order_manager/ingredient/delete_express_order/delete_express_button.dart';
import 'package:masumanager/MasuShipManager/mainManager/express_order_manager/ingredient/view_express_log/view_express_log_button.dart';
import '../ingredient/text_line_in_item.dart';

class express_order_item extends StatefulWidget {
  final expressOrder order;
  final int index;
  const express_order_item({super.key, required this.order, required this.index});

  @override
  State<express_order_item> createState() => _express_order_itemState();
}

class _express_order_itemState extends State<express_order_item> {
  String status = '';

  @override
  Widget build(BuildContext context) {
    if (widget.order.status == 'A') {
      status = 'Chờ đẩy đơn cho shipper';
    }

    if (widget.order.status == 'B') {
      status = 'Đơn đã đẩy cho shipper ' + widget.order.shipper.name;
    }

    if (widget.order.status == 'C') {
      status = 'Shipper đã lấy được hàng';
    }

    if (widget.order.status == 'D') {
      status = 'Đơn hoàn thành';
    }

    if (widget.order.status == 'E') {
      status = 'Bị khách hủy';
    }

    if (widget.order.status == 'E1') {
      status = 'Bị admin hủy';
    }

    double width = MediaQuery.of(context).size.width - 130;
    return Container(
      width: width,
      height: 180,
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

                  Container(height: 10,),

                  text_line_in_item(color: Colors.black,title: 'Người gửi : ', content: widget.order.sender.name + '-' + widget.order.sender.phone ),

                  Container(height: 10,),

                  text_line_in_item(color: Colors.black,title: 'Người nhận : ', content: widget.order.receiver.name + '-' + widget.order.receiver.phone),

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

                  text_line_in_item(color: Colors.black,title: 'Điểm nhận hàng : ', content: widget.order.locationSet.longitude != 0 ? widget.order.locationSet.mainText : 'Hiện chưa đến nơi'),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Điểm trả hàng : ', content: widget.order.locationGet.longitude != 0 ? widget.order.locationGet.mainText : 'Hiện chưa đến nơi'),

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

                  text_line_in_item(color: Colors.black,title: 'Tên hàng hóa : ', content: widget.order.item),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Khối lượng : ', content: widget.order.weightType == 1 ? 'Từ 10-20Kg' : (widget.order.weightType == 2 ? 'Trên 20Kg' : 'Dưới 10Kg')),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Người trả cước : ', content: widget.order.payer == 1 ? 'Người gửi' : 'Người nhận'),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Phí thu hộ : ', content: widget.order.codMoney == 0 ? 'Không có' : (getStringNumber(widget.order.codMoney) + '.đ')),

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

                  text_line_in_item(color: Colors.black,title: 'Chi phí vận chuyển : ', content: getStringNumber(widget.order.cost) + '.đ'),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Phụ thu cân nặng : ', content: getStringNumber(widget.order.weightType == 1 ? 10000 : (widget.order.weightType == 2 ? 20000 : 0)) + '.đ'),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Phụ thu thời tiết : ', content: getStringNumber(widget.order.subFee) + '.đ'),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Chiết khấu : ', content: getStringNumber(getShipDiscount(widget.order.cost, widget.order.costFee)) + '.đ'),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Trạng thái : ', content: status),

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

                  cancel_express_button(order: widget.order),

                  Container(height: 8,),

                  delete_express_button(order: widget.order),

                  Container(height: 8,),

                  view_express_log_button(order: widget.order),

                  Container(height: 8,),

                  view_express_order_image(order: widget.order),

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
