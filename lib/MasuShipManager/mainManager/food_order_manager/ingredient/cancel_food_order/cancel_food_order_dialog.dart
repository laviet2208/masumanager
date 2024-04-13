import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:masumanager/MasuShipManager/mainManager/food_order_manager/ingredient/view_food_list/delete_food_controller.dart';

class cancel_food_order_dialog extends StatefulWidget {
  final foodOrder order;
  const cancel_food_order_dialog({super.key, required this.order});

  @override
  State<cancel_food_order_dialog> createState() => _cancel_food_order_dialogState();
}

class _cancel_food_order_dialogState extends State<cancel_food_order_dialog> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Bạn có chắc chắn hủy đơn không?'),
      actions: <Widget>[
        !loading ? TextButton(
          onPressed: () async {
            setState(() {
              loading = true;
            });
            widget.order.status = 'G3';
            widget.order.timeList[5] = getCurrentTime();
            await delete_food_controller.push_food_order_data(widget.order);
            setState(() {
              loading = false;
            });
            Navigator.of(context).pop();
          },
          child: Text(
            'Xác nhận',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ) : CircularProgressIndicator(color: Colors.blueAccent,),
      ],
    );
  }
}
