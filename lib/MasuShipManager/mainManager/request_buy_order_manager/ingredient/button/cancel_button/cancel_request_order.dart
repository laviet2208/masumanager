import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/utils.dart';
import 'package:masumanager/MasuShipManager/mainManager/request_buy_order_manager/controller/cancel_delete_request_order_controller.dart';

import '../../../../../../dataClass/FinalClass.dart';

class cancel_request_order extends StatefulWidget {
  final requestBuyOrder order;
  const cancel_request_order({super.key, required this.order});

  @override
  State<cancel_request_order> createState() => _cancel_request_orderState();
}

class _cancel_request_orderState extends State<cancel_request_order> {
  final passControl = TextEditingController();
  bool loading = false;

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
                  !loading ? TextButton(
                    onPressed: () async {
                      if (passControl.text.toString() == currentAccount.password) {
                        await cancel_delete_request_order_controller.cancel_request_order(widget.order);
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
                  ) : CircularProgressIndicator(color: Colors.blueAccent,),

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
          toastMessage('Đơn đã bị hủy rồi');
        }
      },
    );
  }
}

