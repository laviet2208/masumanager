import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import 'package:masumanager/MasuShipManager/mainManager/bike_order_manager/ingredient/view_all_child_order_page/view_log_child_order/view_child_order_log.dart';

class view_log_button extends StatefulWidget {
  final catchOrderType3 order;
  const view_log_button({Key? key, required this.order}) : super(key: key);

  @override
  State<view_log_button> createState() => _view_log_buttonState();
}

class _view_log_buttonState extends State<view_log_button> {
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
                child: view_child_order_log(order: widget.order),
              ),
            );
          },
        );
      },
    );
  }
}