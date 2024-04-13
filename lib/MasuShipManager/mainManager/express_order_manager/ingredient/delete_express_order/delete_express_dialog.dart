import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/mainManager/express_order_manager/express_order_controller.dart';

import '../../../../Data/OrderData/expressOrder/expressOrder.dart';

class delete_express_dialog extends StatefulWidget {
  final expressOrder order;
  const delete_express_dialog({super.key, required this.order});

  @override
  State<delete_express_dialog> createState() => _delete_express_dialogState();
}

class _delete_express_dialogState extends State<delete_express_dialog> {
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
            await express_order_controller.delete_express_order_data(widget.order);
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
