import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import 'package:masumanager/MasuShipManager/mainManager/bike_order_manager/ingredient/view_all_child_order_page/view_all_child_order_page.dart';

class view_all_child_order_button extends StatefulWidget {
  final motherOrder order;
  const view_all_child_order_button({super.key, required this.order});

  @override
  State<view_all_child_order_button> createState() => _view_all_child_order_buttonState();
}

class _view_all_child_order_buttonState extends State<view_all_child_order_button> {
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
          'Xem chi tiết',
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
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              content: view_all_child_order_page(order: widget.order),
            );
          },
        );
      },
    );
  }
}
