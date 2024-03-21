import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../dataClass/FinalClass.dart';
import '../../../dataClass/Lịch sử giao dịch.dart';
import '../../../utils/utils.dart';
import '../Data/catchOrder.dart';

class ButtonCancelCatchOrder extends StatefulWidget {
  final catchOrder order;
  const ButtonCancelCatchOrder({Key? key, required this.order}) : super(key: key);

  @override
  State<ButtonCancelCatchOrder> createState() => _ButtonCancelCatchOrderState();
}

class _ButtonCancelCatchOrderState extends State<ButtonCancelCatchOrder> {
  Future<void> updateData(String status) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Order/catchOrder/' + widget.order.id + "/status").set(status);
      databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Order/catchOrder/' + widget.order.id + "/S4time").set(getCurrentTime().toJson());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushData2(String id, double money) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('normalUser/' + id).child('totalMoney').set(money);
      toastMessage('Nạp tiền thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushhistoryData(historyTransaction history) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('historyTransaction').child(history.id).set(history.toJson());
      toastMessage('Thêm lịch sử thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: Colors.yellow.shade700,
          borderRadius: BorderRadius.circular(0),
        ),
        alignment: Alignment.center,
        child: Text(
          'Hủy đơn hàng',
          style: TextStyle(
              fontFamily: 'arial',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
      ),
      onTap:() async {
        if (widget.order.status == 'A' || widget.order.status == 'B' || widget.order.status == 'C') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Xác nhận'),
                  content: Text('Bạn có chắc chắn hủy đơn này không'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Không', style: TextStyle(color: Colors.redAccent),),
                    ),

                    TextButton(
                      onPressed: () async {
                        if (widget.order.status == 'A') {
                          await updateData('H1');
                          toastMessage('Bạn đã hủy đơn');
                          Navigator.of(context).pop();
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Xác nhận hoàn tiền'),
                                content: Text('Bạn có muốn hoàn chiết khấu cho tài khoản này không'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () async {
                                      await updateData('H1');
                                      toastMessage('Bạn đã hủy đơn');
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Không', style: TextStyle(color: Colors.redAccent),),
                                  ),

                                  TextButton(
                                    onPressed: () async {
                                      historyTransaction his = historyTransaction(id: dataCheckManager.generateRandomString(10), senderId: '', receiverId: widget.order.shipper.id, transactionTime: getCurrentTime(), type: 6, content: widget.order.id, money: (widget.order.cost * widget.order.costFee.discount)/100, area: currentAccount.provinceCode);
                                      await pushData2(widget.order.shipper.id, widget.order.shipper.totalMoney);
                                      toastMessage('Đã cộng tiền tài xế');
                                      await pushhistoryData(his);
                                      toastMessage('Đẩy lịch sử thành công');
                                      await updateData('H1');
                                      toastMessage('Bạn đã hủy đơn');
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Đồng ý', style: TextStyle(color: Colors.blueAccent),),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text('Đồng ý' , style: TextStyle(color: Colors.blueAccent),),
                    )
                  ],
                );
              }
          );
        } else {
          toastMessage('Đơn bị hủy rồi');
        }

      },
    );
  }
}
