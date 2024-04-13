import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import '../../../../Data/otherData/Tool.dart';

class cancel_bike_order_controller {
  static Future<void> cancel_child_order_data(String id, String status, motherOrder order) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Order').child(id).child('status').set(status);
    databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Order').child(id).child('S4time').set(getCurrentTime().toJson());
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
}