import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../Data/areaData/Area.dart';
import '../../../../Data/historyData/historyTransactionData.dart';
import '../../../../Data/otherData/Tool.dart';
import '../../../../../dataClass/FinalClass.dart';
import '../../../../../utils/utils.dart';
import '../../../../Data/accountData/shipperAccount.dart';
import '../../../../Data/otherData/Time.dart';

class withdraw_money_for_shipper extends StatefulWidget {
  final shipperAccount account;
  const withdraw_money_for_shipper({Key? key, required this.account}) : super(key: key);

  @override
  State<withdraw_money_for_shipper> createState() => _withdraw_money_for_shipperState();
}

class _withdraw_money_for_shipperState extends State<withdraw_money_for_shipper> {
  final moneyControl = TextEditingController();
  final noidungcontrol = TextEditingController();
  bool loading = false;

  Future<void> change_shipper_money() async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Account/' + widget.account.id + '/money').set(widget.account.money);
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

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

  Area area = Area(id: '', name: '', money: 0, status: 1);

  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area/" + widget.account.area).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      area = Area.fromJson(orders);
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 30,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 0.5,
              color: Colors.black,
            )
        ),
        alignment: Alignment.center,
        child: Text(
          'Trừ tiền shipper',
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
              title: Text('Trừ tiền tài xế'),
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
                            fontFamily: 'roboto',
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
                                  fontFamily: 'roboto',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Nhập số tiền cần trừ',
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

                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Nội dung trừ tiền *',
                        style: TextStyle(
                            fontFamily: 'roboto',
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
                                controller: noidungcontrol,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'roboto',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Nội dung trừ tiền',
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

                    if (moneyControl.text.isNotEmpty && noidungcontrol.text.isNotEmpty) {
                        if (int.parse(moneyControl.text.toString()) > 0) {
                          widget.account.money = widget.account.money - double.parse(moneyControl.text.toString());
                          area.money = area.money + double.parse(moneyControl.text.toString());
                          historyTransactionData history = historyTransactionData(
                            id: generateID(15),
                            senderId: currentAccount.username,
                            receiverId: widget.account.id,
                            transactionTime: Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year),
                            type: 2,
                            content: noidungcontrol.text.toString(),
                            money: double.parse(moneyControl.text.toString()),
                            area: widget.account.area,
                          );
                          await change_shipper_money();
                          await push_history_data(history);
                          moneyControl.clear();
                          Navigator.of(context).pop();
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
