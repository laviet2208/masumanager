import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/mainManager/food_order_manager/ingredient/view_log_food_order/log_food_order_dialog.dart';
import '../../../../Data/OrderData/foodOrder/foodOrder.dart';

class view_log_food_order_button extends StatelessWidget {
  final foodOrder order;
  const view_log_food_order_button({super.key, required this.order});

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
                child: log_food_order_dialog(order: order,),
              ),
            );
          },
        );
      },
    );
  }
}
