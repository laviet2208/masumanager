import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import 'package:masumanager/MasuShipManager/mainManager/bike_order_manager/ingredient/cancel_bike_order/cancel_bike_accept_dialog.dart';
import '../../../../Data/otherData/utils.dart';

class cancel_bike_order_button extends StatefulWidget {
  final motherOrder order;
  final catchOrderType3 orderType3;
  const cancel_bike_order_button({super.key, required this.order, required this.orderType3});

  @override
  State<cancel_bike_order_button> createState() => _cancel_bike_order_buttonState();
}

class _cancel_bike_order_buttonState extends State<cancel_bike_order_button> {

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
      onTap: () async {
        if (widget.orderType3.status == 'A' || widget.orderType3.status == 'B' || widget.orderType3.status == 'C') {
          showDialog(
            context: context,
            builder: (context) {
              return cancel_bike_accept_dialog(order: widget.order, orderType3: widget.orderType3,);
            },
          );
        } else {
          toastMessage('Đơn đã hoàn thành hoặc bị hủy rồi');
        }
      },
    );
  }
}
