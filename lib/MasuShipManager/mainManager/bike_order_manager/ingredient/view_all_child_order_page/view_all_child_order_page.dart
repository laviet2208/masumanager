import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import 'package:masumanager/MasuShipManager/mainManager/bike_order_manager/ingredient/view_all_child_order_page/item_child_order.dart';
import 'package:masumanager/MasuShipManager/mainManager/ingredient/heading_title.dart';

class view_all_child_order_page extends StatefulWidget {
  final motherOrder order;
  const view_all_child_order_page({super.key, required this.order});

  @override
  State<view_all_child_order_page> createState() => _view_all_child_order_pageState();
}

class _view_all_child_order_pageState extends State<view_all_child_order_page> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/4*3;
    double height = MediaQuery.of(context).size.height/4*3;
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: heading_title(numberColumn: 4, listTitle: ['Thông tin đơn', 'Chi tiết đơn', 'Trạng thái đơn', 'Thao tác'], width: width - 20, height: 70),
          ),

          Positioned(
            top: 80,
            left: 10,
            right: 10,
            bottom: 10,
            child: Container(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.order.orderList.length,
                itemBuilder: (context, index) {
                  return item_child_order(order: widget.order, index: index);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
