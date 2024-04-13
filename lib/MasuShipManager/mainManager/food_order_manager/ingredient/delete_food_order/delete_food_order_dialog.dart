import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masumanager/MasuShipManager/mainManager/food_order_manager/ingredient/view_food_list/delete_food_controller.dart';

class delete_food_order_dialog extends StatefulWidget {
  final foodOrder order;
  const delete_food_order_dialog({super.key, required this.order});

  @override
  State<delete_food_order_dialog> createState() => _delete_food_order_dialogState();
}

class _delete_food_order_dialogState extends State<delete_food_order_dialog> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Bạn có chắc chắn xóa đơn không?'),
      actions: <Widget>[
        !loading ? TextButton(
          onPressed: () async {
            setState(() {
              loading = true;
            });
            await delete_food_controller.remove_food_order_data(widget.order);
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
