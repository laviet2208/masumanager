import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../dataClass/FinalClass.dart';
import '../../../../utils/utils.dart';

class cancel_order extends StatefulWidget {
  final String id;
  const cancel_order({Key? key, required this.id}) : super(key: key);

  @override
  State<cancel_order> createState() => _cancel_orderState();
}

class _cancel_orderState extends State<cancel_order> {
  final passControl = TextEditingController();

  Future<void> change_order_data(String id, String status) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Order').child(id).child('status').set(status);
    toastMessage('Hủy thành công');
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
              fontFamily: 'roboto',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13
          ),
        ),
      ),
      onTap: () async {
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
                                  fontFamily: 'roboto',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Nhập mật khẩu',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: 'roboto',
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
                      await change_order_data(widget.id, 'E1');
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
      },
    );
  }
}
