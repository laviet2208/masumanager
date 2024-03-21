import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20%C4%91%C6%A1n%20%C4%91%E1%BA%B7t%20xe/Data/catchOrder.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../utils/utils.dart';

class ButtonDeleteCatchOrder extends StatefulWidget {
  final catchOrder order;
  const ButtonDeleteCatchOrder({Key? key, required this.order}) : super(key: key);

  @override
  State<ButtonDeleteCatchOrder> createState() => _ButtonDeleteCatchOrderState();
}

class _ButtonDeleteCatchOrderState extends State<ButtonDeleteCatchOrder> {
  bool loading = false;

  Future<void> deleteOrder() async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Order').child('catchOrder').child(widget.order.id).remove();
      setState(() {

      });
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi xóa đơn');
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
          'Xóa đơn hàng',
          style: TextStyle(
              fontFamily: 'arial',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
      ),
      onTap:() async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Bạn có chắc chắn xóa đơn không'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Hủy', style: TextStyle(color: Colors.redAccent),),
                ),

                loading ? CircularProgressIndicator(color: Colors.black,) : TextButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    if (widget.order.shipper.id != 'NA' && (widget.order.status == 'A' || widget.order.status == 'B')) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Bạn có muốn hoàn tiền cho tài xế không'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () async {
                                  await deleteOrder();
                                  toastMessage('Xóa thành công');
                                  setState(() {
                                    loading = false;
                                  });
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: Text('Không', style: TextStyle(color: Colors.redAccent),),
                              ),

                              TextButton(
                                onPressed: () async {
                                  double money = widget.order.shipper.totalMoney;
                                  money = money + widget.order.costFee.discount * widget.order.cost/100;
                                  await pushData2(widget.order.shipper.id, money);
                                  await deleteOrder();
                                  toastMessage('Xóa thành công');
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  setState(() {
                                    loading = false;
                                  });
                                },
                                child: Text('Đồng ý', style: TextStyle(color: Colors.blueAccent),),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      await deleteOrder();
                      toastMessage('Xóa thành công');
                      Navigator.of(context).pop();
                      setState(() {
                        loading = false;
                      });
                    }

                  },
                  child: Text('Đồng ý', style: TextStyle(color: Colors.blueAccent),),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
