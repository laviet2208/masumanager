import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import 'package:masumanager/MasuShipManager/mainManager/bike_order_manager/ingredient/delete_bike_order/delete_bike_order_dialog.dart';

class delete_bike_order_button extends StatefulWidget {
  final catchOrderType3 orderType3;
  final motherOrder order;
  const delete_bike_order_button({super.key, required this.orderType3, required this.order});

  @override
  State<delete_bike_order_button> createState() => _delete_bike_order_buttonState();
}

class _delete_bike_order_buttonState extends State<delete_bike_order_button> {
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
          'Xóa đơn này',
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
            return delete_bike_order_dialog(order: widget.order, orderType3: widget.orderType3,);
          },
        );
      },
    );
  }
}
