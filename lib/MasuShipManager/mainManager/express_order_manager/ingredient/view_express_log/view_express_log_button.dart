import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/expressOrder/expressOrder.dart';
import 'package:masumanager/MasuShipManager/mainManager/express_order_manager/ingredient/view_express_log/express_order_log_dialog.dart';

class view_express_log_button extends StatelessWidget {
  final expressOrder order;
  const view_express_log_button({super.key, required this.order});

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
                child: express_order_log_dialog(order: order),
              ),
            );
          },
        );
      },
    );
  }
}
