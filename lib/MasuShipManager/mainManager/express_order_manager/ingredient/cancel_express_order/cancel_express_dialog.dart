import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/expressOrder/expressOrder.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shipperAccount.dart';
import 'package:masumanager/MasuShipManager/Data/firebase_interact/firebase_interact.dart';
import 'package:masumanager/MasuShipManager/mainManager/express_order_manager/express_order_controller.dart';
import '../../../../Data/historyData/historyTransactionData.dart';
import '../../../../Data/otherData/Tool.dart';
import 'package:firebase_database/firebase_database.dart';

class cancel_express_dialog extends StatefulWidget {
  final expressOrder order;
  const cancel_express_dialog({super.key, required this.order});

  @override
  State<cancel_express_dialog> createState() => _cancel_express_dialogState();
}

class _cancel_express_dialogState extends State<cancel_express_dialog> {
  bool loading = false;

  Future<void> cancel_express_order_discount(expressOrder order, shipperAccount shipper_account) async {
    double money = getShipDiscount(order.cost, order.costFee);
    shipper_account.money = shipper_account.money + money;
    shipper_account.orderHaveStatus = shipper_account.orderHaveStatus - 1;
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Account').child(shipper_account.id).set(shipper_account.toJson());
    historyTransactionData data = historyTransactionData(id: generateID(30), senderId: '', receiverId: shipper_account.id, transactionTime: getCurrentTime(), type: 6, content: 'Hoàn chiết khấu đơn: ' + order.id, money: money, area: shipper_account.area);
    await firebase_interact.push_history_data(data);
  }

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
            if (widget.order.status == 'B' || widget.order.status == 'C') {
              shipperAccount account = await firebase_interact.get_shipper_account(widget.order.shipper.id);
              await cancel_express_order_discount(widget.order, account);
            }
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
