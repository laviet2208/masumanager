import 'package:firebase_database/firebase_database.dart';

import '../../../Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';

class start_request_order_controller {
  static bool check_if_order_can_push(requestBuyOrder order) {
    bool check = false;
    if (order.locationGet.longitude != 0) {
      if (order.buyLocation.length != 0) {
        if (order.productList.length != 0) {
          check = true;
        }
      }
    }
    return check;
  }

  static Future<void> push_buy_request_order_data(requestBuyOrder order) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Order').child(order.id).set(order.toJson());
  }

}