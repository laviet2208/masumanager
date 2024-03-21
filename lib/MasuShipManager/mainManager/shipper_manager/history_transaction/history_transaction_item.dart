import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shipperAccount.dart';
import 'package:masumanager/MasuShipManager/Data/historyData/historyTransactionData.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../dataClass/FinalClass.dart';
import '../../../Data/areaData/Area.dart';
import '../../../Data/otherData/Tool.dart';
import '../../../Data/otherData/utils.dart';

class history_transaction_item extends StatefulWidget {
  final historyTransactionData transaction;
  final int index;
  const history_transaction_item({super.key, required this.transaction, required this.index});

  @override
  State<history_transaction_item> createState() => _history_transaction_itemState();
}

class _history_transaction_itemState extends State<history_transaction_item> {
  Area area = Area(id: '', name: '', money: 0, status: 0);
  String name = '';
  String phone = '';

  void get_area_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").child(widget.transaction.area).onValue.listen((event) {
      final dynamic are = event.snapshot.value;
      Area areas = Area.fromJson(are);
      area.name = areas.name;
      area.id = areas.id;
      area.status = areas.status;
      setState(() {

      });
    });
  }

  void get_shipper_info() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Account").child(widget.transaction.receiverId).onValue.listen((event) {
      final dynamic are = event.snapshot.value;
      shipperAccount acc = shipperAccount.fromJson(are);
      name = acc.name;
      phone = acc.phone;
      setState(() {

      });
    });
  }

  Future<void> delete_transaction(String id) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('historyTransaction/' + id).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_area_data();
    get_shipper_info();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 61;
    return Container(
      width: width,
      height: 100,
      decoration: BoxDecoration(
        color: widget.index % 2 == 0 ? Colors.white : Color.fromARGB(255, 247, 250, 255),
        border: Border.all(
          color: Color.fromARGB(255, 240, 240, 240),
          width: 1.0,
        ),
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: width/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Mã giao dịch : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.transaction.id, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 20,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: width/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Thời gian : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: getAllTimeString(widget.transaction.transactionTime),
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Người thực hiện : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.transaction.senderId + ' Admin',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 20,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: width/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Số tiền : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: (widget.transaction.type == 1) ? ('+ ' + getStringNumber(widget.transaction.money) + 'VNĐ') : ('- ' + getStringNumber(widget.transaction.money) + 'VNĐ'),
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.normal,
                              color: (widget.transaction.type == 1) ? Colors.green : Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Nội dung giao dịch : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.transaction.content,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 20,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: width/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Tên trong app : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: name,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Số điện thoại : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: phone[0] == '0' ? phone : '0' + phone,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Khu vực : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: area.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 20,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: width/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 15,),
              child: ListView(
                children: [
                  Container(height: 4,),

                  GestureDetector(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Xóa lịch sử',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black
                        ),
                      ),
                    ),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Xác nhận đồng ý'),
                            content: Text('Bạn có chắc chắn xóa không.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Hủy',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (currentAccount.provinceCode == '0') {
                                    await delete_transaction(widget.transaction.id);
                                    Navigator.of(context).pop();
                                  } else {
                                    toastMessage('Tài khoản không đủ thẩm quyền');
                                  }

                                },
                                child: Text(
                                  'Đồng ý',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );

                    },
                  ),

                  Container(height: 20,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
