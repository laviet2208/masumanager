import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/utils.dart';
import 'package:masumanager/MasuShipManager/mainManager/food_order_manager/ingredient/cancel_food_order/cancel_food_order_button.dart';
import 'package:masumanager/MasuShipManager/mainManager/food_order_manager/ingredient/delete_food_order/delete_food_order_button.dart';
import 'package:masumanager/MasuShipManager/mainManager/food_order_manager/ingredient/view_food_list/delete_food_dialog.dart';
import 'package:masumanager/MasuShipManager/mainManager/food_order_manager/ingredient/view_food_list/view_food_list_dialog.dart';

import '../../Data/otherData/Tool.dart';
import '../ingredient/text_line_in_item.dart';
import 'ingredient/view_log_food_order/view_log_food_order_button.dart';

class item_food_order extends StatefulWidget {
  final foodOrder order;
  final int index;
  const item_food_order({super.key, required this.order, required this.index});

  @override
  State<item_food_order> createState() => _item_food_orderState();
}

class _item_food_orderState extends State<item_food_order> {
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
      status = 'Shipper đã xác nhận với khách';
    }

    if (widget.order.status == 'D') {
      status = 'Shipper đã xác nhận với nhà hàng';
    }

    if (widget.order.status == 'E') {
      status = 'Shipper đã lấy món';
    }

    if (widget.order.status == 'F') {
      status = 'Đơn hoàn thành';
    }

    if (widget.order.status == 'E2') {
      status = 'Bị Admin hủy đơn';
    }

    if (widget.order.status == 'G') {
      status = 'Nhà hàng không xác nhận';
    }

    if (widget.order.status == 'G1') {
      status = 'Khách không xác nhận';
    }

    if (widget.order.status == 'G2') {
      status = 'Bị khách hủy đơn';
    }

    if (widget.order.status == 'G3') {
      status = 'Bị Admin hủy đơn';
    }

    if (widget.order.status == 'G4') {
      status = 'Khách boom hàng';
    }
    double width = MediaQuery.of(context).size.width - 80;

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
            width: (width - 50)/5-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'ID: ', content: widget.order.id),

                  Container(height: 10,),

                  text_line_in_item(color: Colors.black,title: 'Quãng đường: ', content: getDistanceOfBike(widget.order.cost, widget.order.costFee).toStringAsFixed(1).toString() + ' Km'),

                  Container(height: 10,),

                  text_line_in_item(color: Colors.black,title: 'Khách hàng: ', content: widget.order.owner.name),

                  Container(height: 10,),

                  text_line_in_item(color: Colors.black,title: 'Sđt: ', content: widget.order.owner.phone),

                  Container(height: 10,),

                  text_line_in_item(color: Colors.black,title: 'Trạng thái: ', content: status),

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
            width: (width - 50)/5-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Điểm giao hàng: ', content: widget.order.locationGet.mainText),

                  Container(height: 10,),

                  text_line_in_item(color: Colors.black,title: 'Điểm mua hàng: ', content: widget.order.shopList.length.toString() + ' Điểm'),

                  Container(height: 10,),

                  text_line_in_item(color: Colors.black,title: 'Phí mua thêm điểm: ', content: getStringNumber((widget.order.shopList.length - 1) * 5000) + ' VNĐ'),

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
            width: (width - 50)/5-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Số lượng món: ', content: widget.order.productList.length.toString() + ' Món'),

                  Container(height: 10,),

                  text_line_in_item(color: Colors.black,title: 'Tổng tiền món ăn: ', content: getStringNumber(get_total_cart_money(widget.order.productList)) + ' VNĐ'),

                  Container(height: 10,),

                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(right: 0, left: 0),
                      child: GestureDetector(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Xem dsách món ăn',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontFamily: 'muli'
                            ),
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return view_food_list_dialog(order: widget.order);
                            },
                          );
                        },
                      ),
                    ),
                  ),

                  Container(height: 10,),

                  // Container(
                  //   child: Padding(
                  //     padding: EdgeInsets.only(right: 0, left: 0),
                  //     child: GestureDetector(
                  //       child: Container(
                  //         alignment: Alignment.centerLeft,
                  //         child: Text(
                  //           'Xem dsách nhà hàng',
                  //           style: TextStyle(
                  //               color: Colors.blueAccent,
                  //               fontFamily: 'muli'
                  //           ),
                  //         ),
                  //       ),
                  //       onTap: () {
                  //         showDialog(
                  //             context: context,
                  //             builder: (context) {
                  //               return delete_food_dialog(order: widget.order, index: widget.index);
                  //             }
                  //         );
                  //
                  //       },
                  //     ),
                  //   ),
                  // ),

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
            width: (width - 50)/5-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Phí vận chuyển: ', content: getStringNumber(widget.order.cost) + ' VNĐ'),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Phí thời tiết: ', content: getStringNumber(widget.order.weatherFee) + ' VNĐ'),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Phí chờ món: ', content: getStringNumber(widget.order.waitFee) + ' VNĐ'),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Chiết khấu tài xế: ', content: getStringNumber(widget.order.cost * widget.order.costFee.discount/100) + ' VNĐ'),

                  Container(height: 15,),

                  text_line_in_item(color: Colors.black,title: 'Chiết khấu quán: ', content: getStringNumber(get_total_cart_money(widget.order.productList) * widget.order.resCost.discount/100) + ' VNĐ'),

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
            width: (width - 50)/5-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 8,),

                  cancel_food_order_button(order: widget.order),

                  Container(height: 8,),

                  delete_food_order_button(order: widget.order),

                  Container(height: 8,),

                  view_log_food_order_button(order: widget.order),

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
