import 'package:firebase_database/firebase_database.dart';

import '../../../Data/otherData/Tool.dart';

class cancel_delete_request_order_controller {
  static Future<void> cancel_request_order(String id,) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Order').child(id).child('status').set('E2');
    databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Order').child(id).child('S4time').set(getCurrentTime().toJson());
  }
}