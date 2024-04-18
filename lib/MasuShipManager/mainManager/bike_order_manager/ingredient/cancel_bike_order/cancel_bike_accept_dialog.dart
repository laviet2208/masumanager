import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/mainManager/bike_order_manager/ingredient/cancel_bike_order/cancel_bike_order_controller.dart';

import '../../../../../dataClass/FinalClass.dart';
import '../../../../Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import '../../../../Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import '../../../../Data/otherData/utils.dart';

class cancel_bike_accept_dialog extends StatefulWidget {
  final motherOrder order;
  final catchOrderType3 orderType3;
  const cancel_bike_accept_dialog({super.key, required this.order, required this.orderType3,});

  @override
  State<cancel_bike_accept_dialog> createState() => _cancel_bike_accept_dialogState();
}

class _cancel_bike_accept_dialogState extends State<cancel_bike_accept_dialog> {
  bool loading = false;
  final passControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              setState(() {
                loading = true;
              });
              await cancel_bike_order_controller.cancel_child_order_data(widget.orderType3, widget.order);
              toastMessage('Hủy thành công');
              setState(() {
                loading = false;
              });
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
  }
}
