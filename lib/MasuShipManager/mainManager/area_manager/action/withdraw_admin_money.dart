import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/areaData/Area.dart';
import 'package:masumanager/MasuShipManager/Data/historyData/historyTransactionData.dart';
import 'package:masumanager/dataClass/FinalClass.dart';

import '../../../Data/otherData/Tool.dart';
import '../../../Data/otherData/utils.dart';

class withdraw_admin_money extends StatefulWidget {
  final Area area;
  const withdraw_admin_money({Key? key, required this.area}) : super(key: key);

  @override
  State<withdraw_admin_money> createState() => _withdraw_admin_moneyState();
}

class _withdraw_admin_moneyState extends State<withdraw_admin_money> {
  bool loading = false;
  final moneyControl = TextEditingController();
  final noidungControl = TextEditingController();

  Future<void> push_history_data(historyTransactionData history) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('historyTransaction').child(history.id).set(history.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Thêm lịch sử thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> push_money_data(Area area, double money) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Area').child(area.id).child('money').set(money);
      setState(() {
        loading = false;
      });
      toastMessage('Thêm khu vực thành công');
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
            color: Colors.yellow,
            border: Border.all(
              width: 0.5,
              color: Colors.black,
            )
        ),
        alignment: Alignment.center,
        child: Text(
          'Trừ tiền admin',
          style: TextStyle(
              fontFamily: 'roboto',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13
          ),
        ),
      ),
      onTap: () async {
        showDialog (
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Trừ tiền khu vực'),
              content: Container(
                width: MediaQuery.of(context).size.width/2, // Đặt kích thước chiều rộng theo ý muốn
                height: 170, // Đặt kích thước chiều cao theo ý muốn
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), // màu của shadow
                      spreadRadius: 5, // bán kính của shadow
                      blurRadius: 7, // độ mờ của shadow
                      offset: Offset(0, 3), // vị trí của shadow
                    ),
                  ],
                ),

                child: ListView(
                  children: [
                    Container(
                      height: 10,
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Số tiền cần trừ *',
                        style: TextStyle(
                            fontFamily: 'arial',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent
                        ),
                      ),
                    ),

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
                                controller: moneyControl,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'arial',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Số tiền cần nạp',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: 'arial',
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

                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Nội dung trừ tiền *',
                        style: TextStyle(
                            fontFamily: 'arial',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent
                        ),
                      ),
                    ),

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
                                controller: noidungControl,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'arial',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Nội dung nạp tiền',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: 'arial',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                    ),

                    Container(
                      height: 20,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Hủy'),
                  onPressed: () {
                    moneyControl.clear();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: loading ? CircularProgressIndicator() : Text('Lưu'),
                  onPressed: loading ? null : () async {
                    setState(() {
                      loading = true;
                    });

                    if (moneyControl.text.isNotEmpty && noidungControl.text.isNotEmpty) {
                        if (int.parse(moneyControl.text.toString()) > 0) {
                          if (double.parse(moneyControl.text.toString()) <= widget.area.money) {
                            double newmoney = widget.area.money - double.parse(moneyControl.text.toString());
                            historyTransactionData history = historyTransactionData(
                              id: generateID(25),
                              senderId: currentAccount.username,
                              receiverId: widget.area.id,
                              transactionTime: getCurrentTime(),
                              type: 4,
                              content: noidungControl.text.toString(),
                              money: double.parse(moneyControl.text.toString()),
                              area: '',
                            );
                            await push_history_data(history);
                            await push_money_data(widget.area, newmoney);
                            moneyControl.clear();
                            Navigator.of(context).pop();
                          } else {
                            toastMessage('Số tiền trừ phải bé hơn bằng số tiền của tài khoản');
                          }

                        } else {
                          toastMessage('Phải nhập số lớn hơn 0');
                          setState(() {
                            loading = false;
                          });
                        }

                    } else {
                      toastMessage('Phải nhập đủ thông tin');
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
