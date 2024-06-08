import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import 'package:masumanager/MasuShipManager/Data/firebase_interact/firebase_interact.dart';
import '../../../../Data/OrderData/catchOrder.dart';
import '../../../../Data/accountData/shipperAccount.dart';
import '../../../../Data/historyData/historyTransactionData.dart';
import '../../../../Data/otherData/Tool.dart';

class cancel_bike_order_controller {
  static Future<void> cancel_child_order_data(catchOrderType3 orderType3, motherOrder order) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    if (orderType3.status == 'B' || orderType3.status == 'C') {
      shipperAccount account = await firebase_interact.get_shipper_account(orderType3.shipper.id);
      await cancel_catch_order_type_3_discount(orderType3, account);
    }
    await databaseRef.child('Order').child(orderType3.id).child('status').set('E1');
    databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Order').child(orderType3.id).child('S4time').set(getCurrentTime().toJson());
    if (await cancel_bike_order_controller.check_if_complete_all(order)) {
      databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Order').child(order.id).child('status').set('CP');
    }
  }

  static Future<String> get_status_data(String order_id) async {
    String id = '';
    final reference = FirebaseDatabase.instance.reference();
    DatabaseEvent snapshot = await reference.child('Order').child(order_id).child('status').once();
    final dynamic orders = snapshot.snapshot.value;
    id = orders.toString();
    return id;
  }

  static Future<bool> check_if_complete_all(motherOrder order) async {
    bool check = true;
    for (int i = 0; i < order.orderList.length; i++) {
      String status = await get_status_data(order.orderList[i]);
      if (status == 'A' || status == 'B' || status == 'C') {
        check = false;
      }
    }
    return check;
  }

  static Future<void> cancel_catch_order_type_3_discount(catchOrderType3 order, shipperAccount shipper_account) async {
    double money = getShipDiscount(order.cost, order.costFee);
    shipper_account.money = shipper_account.money + money;
    shipper_account.orderHaveStatus = shipper_account.orderHaveStatus - 1;
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Account').child(shipper_account.id).set(shipper_account.toJson());
    historyTransactionData data = historyTransactionData(id: generateID(30), senderId: '', receiverId: shipper_account.id, transactionTime: getCurrentTime(), type: 6, content: 'Hoàn chiết khấu đơn: ' + order.id, money: money, area: shipper_account.area);
    await firebase_interact.push_history_data(data);
  }
}