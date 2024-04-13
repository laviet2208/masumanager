import 'package:flutter/material.dart';

import '../../../../Data/OrderData/foodOrder/foodOrder.dart';
import '../cancel_food_order/cancel_food_order_dialog.dart';

class delete_food_order_button extends StatelessWidget {
  final foodOrder order;
  const delete_food_order_button({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 30,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                width: 0.5,
                color: Colors.black
            )
        ),
        alignment: Alignment.center,
        child: Text(
          'Xóa đơn',
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
            return cancel_food_order_dialog(order: order);
          },
        );
      },
    );
  }
}
