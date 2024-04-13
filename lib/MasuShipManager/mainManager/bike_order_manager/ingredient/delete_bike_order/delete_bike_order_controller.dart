import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/mainManager/bike_order_manager/ingredient/cancel_bike_order/cancel_bike_order_controller.dart';

import '../../../../Data/OrderData/catch_order_type_3_data/motherOrder.dart';

class delete_bike_order_controller {
  static Future<void> delete_child_order_data(String id, motherOrder order) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    order.orderList.remove(id);
    await databaseRef.child('Order').child(order.id).set(order.toJson());
    databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Order').child(id).remove();
    if (await get_order_number_data(order.id) >= 1) {
      if (await cancel_bike_order_controller.check_if_complete_all(order)) {
        databaseRef = FirebaseDatabase.instance.reference();
        await databaseRef.child('Order').child(order.id).child('status').set('CP');
      }
    } else {
      databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Order').child(order.id).remove();
    }
  }

  static Future<int> get_order_number_data(String order_id) async {
    int number = 0;
    final reference = FirebaseDatabase.instance.reference();
    DatabaseEvent snapshot = await reference.child('Order').child(order_id).once();
    final dynamic orders = snapshot.snapshot.value;
    number = motherOrder.fromJson(orders).orderList.length;
    return number;
  }
}