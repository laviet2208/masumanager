import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:masumanager/MasuShipManager/Data/firebase_interact/firebase_interact.dart';
import '../../../../Data/accountData/shipperAccount.dart';
import '../../../../Data/historyData/historyTransactionData.dart';
import '../../../../Data/otherData/Tool.dart';
import '../../../../Data/otherData/utils.dart';

class withdraw_debt_money extends StatefulWidget {
  final shipperAccount account;
  const withdraw_debt_money({super.key, required this.account});

  @override
  State<withdraw_debt_money> createState() => _withdraw_debt_moneyState();
}

class _withdraw_debt_moneyState extends State<withdraw_debt_money> {
  bool loading = false;
  final moneyControl = TextEditingController();
  final contentControl = TextEditingController();

  Future<void> push_shipper(shipperAccount account) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Account').child(account.id).set(account.toJson());
  }

  Future<void> push_history(historyTransactionData data) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('historyTransaction').child(data.id).set(data.toJson());
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Trừ tiền ví ứng'),
      content: Container(
        width: MediaQuery.of(context).size.width/2, // Đặt kích thước chiều rộng theo ý muốn
        height: 170, // Đặt kích thước chiều cao theo ý muốn

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
                    fontFamily: 'muli',
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
                          fontFamily: 'muli',
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Số tiền cần nạp',
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

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Nội dung trừ tiền *',
                style: TextStyle(
                    fontFamily: 'muli',
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
                        controller: contentControl,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nội dung nạp ví vay',
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
              height: 20,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        !loading ? TextButton(
          child: Text('Hủy'),
          onPressed: () {
            moneyControl.clear();
            Navigator.of(context).pop();
          },
        ) : CircularProgressIndicator(color: Colors.redAccent,),

        !loading ? TextButton(
          child: loading ? CircularProgressIndicator() : Text('Lưu'),
          onPressed: loading ? null : () async {
            if (moneyControl.text.isNotEmpty && contentControl.text.isNotEmpty) {

              if (double.parse(moneyControl.text.toString()) <= widget.account.debt) {
                setState(() {
                  loading = true;
                });
                shipperAccount acc = await firebase_interact.get_shipper_account(widget.account.id);
                if (acc.debt >= double.parse(moneyControl.text.toString())) {
                  acc.debt = acc.debt - double.parse(moneyControl.text.toString());
                  await push_shipper(acc);
                  historyTransactionData data = historyTransactionData(
                    id: generateID(30),
                    senderId: 'ADMINALL',
                    receiverId: acc.id,
                    transactionTime: getCurrentTime(),
                    type: 11,
                    content: contentControl.text.toString(),
                    money: double.parse(moneyControl.text.toString()),
                    area: acc.area,
                  );
                  await push_history(data);
                  setState(() {
                    loading = false;
                  });
                  Navigator.of(context).pop();
                } else {
                  toastMessage('Số tiền không được lớn hơn ví');
                  setState(() {
                    loading = false;
                  });
                }
              } else {
                toastMessage('Số tiền không được lớn hơn ví');
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
        ) : CircularProgressIndicator(color: Colors.blueAccent,),
      ],
    );
  }
}
