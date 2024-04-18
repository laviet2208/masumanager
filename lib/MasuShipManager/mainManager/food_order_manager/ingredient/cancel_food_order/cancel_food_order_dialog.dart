import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shipperAccount.dart';
import 'package:masumanager/MasuShipManager/Data/firebase_interact/firebase_interact.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:masumanager/MasuShipManager/mainManager/food_order_manager/ingredient/view_food_list/delete_food_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../Data/accountData/shopData/cartProduct.dart';
import '../../../../Data/accountData/shopData/shopAccount.dart';
import '../../../../Data/historyData/historyTransactionData.dart';

class cancel_food_order_dialog extends StatefulWidget {
  final foodOrder order;
  const cancel_food_order_dialog({super.key, required this.order});

  @override
  State<cancel_food_order_dialog> createState() => _cancel_food_order_dialogState();
}

class _cancel_food_order_dialogState extends State<cancel_food_order_dialog> {
  bool loading = false;

  Future<void> cancel_food_order_discount(foodOrder order) async {
    double money = order.cost * (order.costFee.discount/100);
    double res_discount_money = get_discount_cost_of_restaurant(order.shopList, order.productList, order.resCost.discount);
    shipperAccount account = await firebase_interact.get_shipper_account(order.shipper.id);
    account.money = account.money + money + res_discount_money;
    account.orderHaveStatus = account.orderHaveStatus - 1;
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Account').child(account.id).set(account.toJson());
    historyTransactionData data = historyTransactionData(id: generateID(30), senderId: '', receiverId: account.id, transactionTime: getCurrentTime(), type: 6, content: 'Hoàn chiết khấu đơn: ' + order.id, money: money, area: account.area);
    historyTransactionData data1 = historyTransactionData(id: generateID(30), senderId: '', receiverId: account.id, transactionTime: getCurrentTime(), type: 8, content: 'Hoàn chiết khấu đơn: ' + order.id, money: res_discount_money, area: account.area);
    await firebase_interact.push_history_data(data);
    await firebase_interact.push_history_data(data1);
  }

  double get_discount_cost_of_restaurant(List<ShopAccount> shops, List<cartProduct> products, double discount) {
    double money = 0;
    ShopAccount accountS = shops.first;
    accountS.discount_type = 1;
    for (cartProduct product in products) {
      double total_food_money = product.product.cost * product.number.toDouble();
      ShopAccount account = shops.firstWhere((item) => item.id == product.product.owner, orElse: () => accountS);
      print(account.name);
      if (account.discount_type == 1) {
        money = money + total_food_money * discount/100;
      }
    }
    return money;
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
            await cancel_food_order_discount(widget.order);
            widget.order.status = 'G3';
            widget.order.timeList[5] = getCurrentTime();
            await delete_food_controller.push_food_order_data(widget.order);
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
