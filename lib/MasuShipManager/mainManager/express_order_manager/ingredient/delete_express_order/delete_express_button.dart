import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/expressOrder/expressOrder.dart';
import 'package:masumanager/MasuShipManager/mainManager/express_order_manager/ingredient/delete_express_order/delete_express_dialog.dart';

class delete_express_button extends StatelessWidget {
  final expressOrder order;
  const delete_express_button({super.key, required this.order});

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
            return delete_express_dialog(order: order);
          },
        );
      },
    );
  }
}
