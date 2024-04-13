import '../../../../Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import '../../../../Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import '../../../../Data/locationData/Location.dart';
import 'package:firebase_database/firebase_database.dart';

class add_bike_order_controller {
  static bool check_if_fill_all_location(List<Location> list) {
    for (Location location in list) {
      if (location.longitude == 0) {
        return false;
      }
    }
    return true;
  }

  static Future<void> push_mother_order_data(motherOrder order) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Order').child(order.id).set(order.toJson());
  }

  static Future<void> push_child_order_data(catchOrderType3 order) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Order').child(order.id).set(order.toJson());
  }
}