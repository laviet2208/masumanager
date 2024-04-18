import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/catchOrder.dart';
import 'package:masumanager/MasuShipManager/Data/firebase_interact/firebase_interact.dart';
import '../../../../dataClass/FinalClass.dart';
import '../../../Data/accountData/shipperAccount.dart';
import '../../../Data/historyData/historyTransactionData.dart';
import '../../../Data/otherData/Tool.dart';
import '../../../Data/otherData/utils.dart';

class cancel_order extends StatefulWidget {
  final CatchOrder order;
  const cancel_order({Key? key, required this.order}) : super(key: key);

  @override
  State<cancel_order> createState() => _cancel_orderState();
}

class _cancel_orderState extends State<cancel_order> {
  final passControl = TextEditingController();

  Future<void> cancel_order(CatchOrder order) async {
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    if (order.status == 'B' || order.status == 'C') {
      shipperAccount account = await firebase_interact.get_shipper_account(order.shipper.id);
      await cancel_catch_order_discount(order, account);
    }
    order.status = 'E1';
    order.S4time = getCurrentTime();
    await reference.child('Order').child(order.id).set(order.toJson());
  }

  static Future<void> cancel_catch_order_discount(CatchOrder order, shipperAccount shipper_account) async {
    double money = order.cost * (order.costFee.discount/100);
    shipper_account.money = shipper_account.money + money;
    shipper_account.orderHaveStatus = shipper_account.orderHaveStatus - 1;
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Account').child(shipper_account.id).set(shipper_account.toJson());
    historyTransactionData data = historyTransactionData(id: generateID(30), senderId: '', receiverId: shipper_account.id, transactionTime: getCurrentTime(), type: 6, content: 'Hoàn chiết khấu đơn: ' + order.id, money: money, area: shipper_account.area);
    await firebase_interact.push_history_data(data);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: Colors.yellow,
          border: Border.all(
            width: 0.5,
            color: Colors.black
          )
        ),
        alignment: Alignment.center,
        child: Text(
          'Hủy đơn',
          style: TextStyle(
              fontFamily: 'muli',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13
          ),
        ),
      ),
      onTap: () async {
        if (widget.order.status == 'A' || widget.order.status == 'B' || widget.order.status == 'C') {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Nhập mật khẩu để xác nhận xóa'),
                content: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width/3,
                  child: ListView(
                    children: [
                      Container(
                        height: 10,
                      ),

                      Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            height: 50,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                )
                            ),

                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Form(
                                child: TextFormField(
                                  controller: passControl,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'muli',
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Nhập mật khẩu',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontFamily: 'muli',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                      ),

                      Container(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      if (passControl.text.toString() == currentAccount.password) {
                        await cancel_order(widget.order);
                        toastMessage('Hủy thành công');
                        Navigator.of(context).pop();
                      } else {
                        toastMessage('Sai mật khẩu');
                      }
                    },
                    child: Text(
                      'Xác nhận',
                      style: TextStyle(
                          color: Colors.blueAccent
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Hủy',
                      style: TextStyle(
                          color: Colors.redAccent
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          toastMessage('Đơn đã hoàn thành hoặc bị hủy rồi');
        }
      },
    );
  }
}
