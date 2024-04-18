import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:masumanager/MasuShipManager/Data/firebase_interact/firebase_interact.dart';

import '../../../Data/accountData/shipperAccount.dart';
import '../../../Data/historyData/historyTransactionData.dart';
import '../../../Data/otherData/Tool.dart';

class cancel_delete_request_order_controller {
  static Future<void> cancel_request_order(requestBuyOrder order) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    if (order.status == 'B' || order.status == 'C') {
      shipperAccount account = await firebase_interact.get_shipper_account(order.shipper.id);
      await cancel_request_order_discount(order, account);
    }
    await databaseRef.child('Order').child(order.id).child('status').set('E2');
    databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Order').child(order.id).child('S4time').set(getCurrentTime().toJson());
  }

  static Future<void> cancel_request_order_discount(requestBuyOrder order, shipperAccount shipper_account) async {
    double money = order.cost * (order.costFee.discount/100);
    shipper_account.money = shipper_account.money + money;
    shipper_account.orderHaveStatus = shipper_account.orderHaveStatus - 1;
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Account').child(shipper_account.id).set(shipper_account.toJson());
    historyTransactionData data = historyTransactionData(id: generateID(30), senderId: '', receiverId: shipper_account.id, transactionTime: getCurrentTime(), type: 6, content: 'Hoàn chiết khấu đơn: ' + order.id, money: money, area: shipper_account.area);
    await firebase_interact.push_history_data(data);
  }
}