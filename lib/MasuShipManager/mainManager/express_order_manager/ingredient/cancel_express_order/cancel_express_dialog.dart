import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/expressOrder/expressOrder.dart';
import 'package:masumanager/MasuShipManager/mainManager/express_order_manager/express_order_controller.dart';

import '../../../../Data/otherData/Tool.dart';

class cancel_express_dialog extends StatefulWidget {
  final expressOrder order;
  const cancel_express_dialog({super.key, required this.order});

  @override
  State<cancel_express_dialog> createState() => _cancel_express_dialogState();
}

class _cancel_express_dialogState extends State<cancel_express_dialog> {
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
            widget.order.status = 'E1';
            widget.order.S4time = getCurrentTime();
            await express_order_controller.push_express_order_data(widget.order);
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
