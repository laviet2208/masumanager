import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/utils.dart';
import 'package:masumanager/MasuShipManager/mainManager/food_order_manager/ingredient/cancel_food_order/cancel_food_order_dialog.dart';

import '../../../../Data/OrderData/foodOrder/foodOrder.dart';

class cancel_food_order_button extends StatefulWidget {
  final foodOrder order;
  const cancel_food_order_button({super.key, required this.order});

  @override
  State<cancel_food_order_button> createState() => _cancel_food_order_buttonState();
}

class _cancel_food_order_buttonState extends State<cancel_food_order_button> {
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
            )
        ),
        alignment: Alignment.center,
        child: Text(
          'Hủy đơn',
          style: TextStyle(
              fontFamily: 'muli',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13
          ),
        ),
      ),
      onTap: () {
        if (widget.order.status == 'A' || widget.order.status == 'B' || widget.order.status == 'C' || widget.order.status == 'D') {
          showDialog(
            context: context,
            builder: (context) {
              return cancel_food_order_dialog(order: widget.order);
            },
          );
        } else {
          toastMessage('Không thể hủy');
        }
      },
    );
  }
}
