import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20kh%C3%A1ch%20h%C3%A0ng/accountNormal.dart';
import 'package:masumanager/dataClass/FinalClass.dart';
import 'package:masumanager/dataClass/L%E1%BB%8Bch%20s%E1%BB%AD%20giao%20d%E1%BB%8Bch.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../../utils/utils.dart';
import '../../Quản lý khu vực và tài khoản admin/Area.dart';

class Itemgiaodich extends StatefulWidget {
  final historyTransaction transaction;
  final double width;
  final Color color;
  const Itemgiaodich({Key? key, required this.transaction, required this.width, required this.color}) : super(key: key);

  @override
  State<Itemgiaodich> createState() => _ItemgiaodichState();
}

class _ItemgiaodichState extends State<Itemgiaodich> {
  Area area = Area(id: '', name: '', money: 0, status: 0);
  String name = '';
  String phone = '';

  void getData() {
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

  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("normalUser").child(widget.transaction.receiverId).onValue.listen((event) {
      final dynamic are = event.snapshot.value;
      accountNormal acc = accountNormal.fromJson(are);
      name = acc.name;
      phone = acc.phoneNum;
      setState(() {

      });
    });
  }

  Future<void> deleteTrans(String id) async {
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
    getData();
    getData1();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: 100,
      decoration: BoxDecoration(
        color: widget.color,
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 240, 240, 240),
            width: 1.0,
          ),
        ),
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (widget.width - 20)/5 - 1,
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
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.transaction.id, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
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
            width: (widget.width - 20)/5 - 1,
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
                            text: 'Thời gian thực hiện : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: 'Ngày ' + widget.transaction.transactionTime.day.toString() + '/' + widget.transaction.transactionTime.month.toString() + '/' + widget.transaction.transactionTime.year.toString() + ' , ' + widget.transaction.transactionTime.hour.toString() + ':' + widget.transaction.transactionTime.minute.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
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
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.transaction.senderId + ' Admin',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
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
            width: (widget.width - 20)/5 - 1,
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
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: (widget.transaction.type == 1) ? ('+ ' + dataCheckManager.getStringNumber(widget.transaction.money) + 'VNĐ') : ('- ' + dataCheckManager.getStringNumber(widget.transaction.money) + 'VNĐ'),
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
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
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.transaction.content,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
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
            width: (widget.width - 20)/5 - 1,
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
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: name,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
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
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: phone[0] == '0' ? phone : '0' + phone,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
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
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: area.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
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
            width: (widget.width - 20)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 8,),

                  GestureDetector(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Xóa lịch sử',
                        style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.white
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
                                    await deleteTrans(widget.transaction.id);
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
