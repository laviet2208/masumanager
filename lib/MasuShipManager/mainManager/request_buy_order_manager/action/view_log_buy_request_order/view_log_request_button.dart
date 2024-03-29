import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';

import 'view_log_buy_request_order.dart';

class view_log_request_button extends StatefulWidget {
  final requestBuyOrder order;
  const view_log_request_button({Key? key, required this.order}) : super(key: key);

  @override
  State<view_log_request_button> createState() => _view_log_buttonState();
}

class _view_log_buttonState extends State<view_log_request_button> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: Colors.yellow,
          border: Border.all(
            width: 0.5,
            color: Colors.black
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          'Xem log đơn',
          style: TextStyle(
              fontFamily: 'muli',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13
          ),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                width: 500,
                height: 400,
                child: view_log_buy_request_order(order: widget.order),
              ),
            );
          },
        );
      },
    );
  }
}
