import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/expressOrder/expressOrder.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/utils.dart';
import 'package:masumanager/MasuShipManager/mainManager/express_order_manager/ingredient/cancel_express_order/cancel_express_dialog.dart';

class cancel_express_button extends StatelessWidget {
  final expressOrder order;
  const cancel_express_button({super.key, required this.order});

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
        if (order.status == 'A' || order.status == 'B' || order.status == 'C') {
          showDialog(
            context: context,
            builder: (context) {
              return cancel_express_dialog(order: order);
            },
          );
        } else {
          toastMessage('Không thể hủy');
        }

      },
    );
  }
}
