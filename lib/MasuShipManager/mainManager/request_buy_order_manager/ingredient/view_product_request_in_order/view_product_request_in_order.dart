import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/requestBuyOrderData/requestProduct.dart';
import 'package:masumanager/MasuShipManager/mainManager/request_buy_order_manager/ingredient/view_product_request_in_order/add_new_product_after_order.dart';

import '../buy_location_item.dart';
import '../request_product_item.dart';
import 'request_product_item_after_order.dart';

class view_product_request_in_order extends StatefulWidget {
  final requestBuyOrder order;
  const view_product_request_in_order({super.key, required this.order});

  @override
  State<view_product_request_in_order> createState() => _view_product_request_in_orderState();
}

class _view_product_request_in_orderState extends State<view_product_request_in_order> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/3;
    return AlertDialog(
      content: Container(
        width: width,
        child: ListView.builder(
          itemCount: widget.order.productList.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: request_product_item_after_order(order: widget.order, callback: () {setState(() {});}, index: index),
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return add_new_product_after_order(order: widget.order, event: (){
                  setState(() {

                  });
                });
              },
            );
          },
          child: Text(
            'Thêm sản phẩm',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ),
      ],
    );
  }
}
