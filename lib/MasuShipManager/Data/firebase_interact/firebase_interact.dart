import 'package:firebase_database/firebase_database.dart';


import '../../../Mainmanager/Quản lý đơn đồ ăn/foodOrder.dart';
import '../accountData/shipperAccount.dart';
import '../historyData/historyTransactionData.dart';
import '../otherData/Tool.dart';

class firebase_interact {
  // static Future<void> cancel_food_order_discount(foodOrder order) async {
  //   double money = order.cost * (order.costFee.discount/100);
  //   double res_discount_money = history_controller.get_discount_cost_of_restaurant(order.shopList, order.productList, order.resCost.discount);
  //   finalData.shipper_account.money = finalData.shipper_account.money + money + res_discount_money;
  //   finalData.shipper_account.orderHaveStatus = finalData.shipper_account.orderHaveStatus - 1;
  //   final reference = FirebaseDatabase.instance.reference();
  //   await reference.child('Account').child(finalData.shipper_account.id).set(finalData.shipper_account.toJson());
  //   historyTransactionData data = historyTransactionData(id: generateID(30), senderId: '', receiverId: finalData.shipper_account.id, transactionTime: getCurrentTime(), type: 6, content: 'Hoàn chiết khấu đơn: ' + order.id, money: money, area: finalData.shipper_account.area);
  //   historyTransactionData data1 = historyTransactionData(id: generateID(30), senderId: '', receiverId: finalData.shipper_account.id, transactionTime: getCurrentTime(), type: 8, content: 'Hoàn chiết khấu đơn: ' + order.id, money: res_discount_money, area: finalData.shipper_account.area);
  //   await order_have_dialog_controller.push_history_data(data);
  //   await order_have_dialog_controller.push_history_data(data1);
  // }
  //
  // static Future<void> apart_food_order_discount(foodOrder order) async {
  //   double money = order.cost * (order.costFee.discount/100);
  //   finalData.shipper_account.money = finalData.shipper_account.money - money;
  //
  //   final reference = FirebaseDatabase.instance.reference();
  //   await reference.child('Account').child(finalData.shipper_account.id).set(finalData.shipper_account.toJson());
  //   historyTransactionData data = historyTransactionData(id: generateID(30), senderId: '', receiverId: finalData.shipper_account.id, transactionTime: getCurrentTime(), type: 5, content: 'Chiết khấu đơn : ' + order.id, money: money, area: finalData.shipper_account.area);
  //   await order_have_dialog_controller.push_history_data(data);
  // }
  static Future<void> push_history_data(historyTransactionData his) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('historyTransaction').child(his.id).set(his.toJson());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  static Future<shipperAccount> get_shipper_account(String id) async {
    final reference = FirebaseDatabase.instance.reference();
    dynamic orders;
    await reference.child("Account").child(id).once().then((DatabaseEvent event) {
      orders = event.snapshot.value;
    });
    return shipperAccount.fromJson(orders);
  }
}