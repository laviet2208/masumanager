import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/expressOrder/expressOrder.dart';

class express_order_controller {
  static Future<void> push_express_order_data(expressOrder order) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Order').child(order.id).set(order.toJson());
  }

  static Future<void> delete_express_order_data(expressOrder order) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Order').child(order.id).remove();
  }
}