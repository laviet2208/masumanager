import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20c%E1%BA%A5u%20h%C3%ACnh/Danh%20s%C3%A1ch%20c%E1%BA%A5u%20h%C3%ACnh.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20khu%20v%E1%BB%B1c%20v%C3%A0%20t%C3%A0i%20kho%E1%BA%A3n%20admin/Area.dart';
import 'package:masumanager/dataClass/FinalClass.dart';
import 'package:masumanager/dataClass/L%E1%BB%8Bch%20s%E1%BB%AD%20giao%20d%E1%BB%8Bch.dart';
import 'package:masumanager/dataClass/Time.dart';
import 'package:masumanager/dataClass/adminaccount.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../utils/utils.dart';

class Itemkhuvuc extends StatefulWidget {
  final double width;
  final Area area;
  final Color color;
  const Itemkhuvuc({Key? key, required this.width, required this.area, required this.color}) : super(key: key);

  @override
  State<Itemkhuvuc> createState() => _ItemkhuvucState();
}

class _ItemkhuvucState extends State<Itemkhuvuc> {

  final moneyControl = TextEditingController();
  final noidungcontrol = TextEditingController();
  List<AdminAccount> adminList = [];
  bool loading = false;
  String getStringNumber(double number) {
    String result = number.toStringAsFixed(0); // làm tròn số
    result = result.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},'); // chuyển đổi phân tách hàng nghìn
    return result;
  }

  Future<void> pushData(Area area, double money) async {
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

  Future<void> pushhistoryData(historyTransaction history) async {
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

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("ADMINaccount").onValue.listen((event) {
      adminList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        AdminAccount adminAccount = AdminAccount.fromJson(value);
        if (adminAccount.provinceCode == widget.area.id) {
          adminList.add(adminAccount);
        }
      });
      setState(() {

      });
    });
  }

  GestureDetector getButton(String text, Color backgroundColor, Color borderColor, Color TextColor, double borderRadius, VoidCallback event) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: backgroundColor,
            border: Border.all(
                width: 1,
                color: borderColor
            )
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'roboto',
              color: TextColor,
              fontSize: 13
          ),
        ),
      ),
      onTap: event,
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width-20,
      height: 120,
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
            width: (widget.width-20)/5 - 1,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 5,right: 5),
              child: Text(
                widget.area.id,
                style: TextStyle(
                    fontFamily: 'arial',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16
                ),
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
            width: (widget.width-20)/5 - 1,
            alignment: Alignment.center,
            child:Padding(
              padding: EdgeInsets.only(left: 5,right: 5),
              child: Text(
                widget.area.name,
                style: TextStyle(
                    fontFamily: 'arial',
                    fontWeight: FontWeight.normal,
                    color: Colors.purple,
                    fontSize: 16
                ),
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: (widget.width-20)/5 - 1,
            alignment: Alignment.center,
            child:Padding(
              padding: EdgeInsets.only(left: 5,right: 5),
              child: Text(
                getStringNumber(widget.area.money) + ' VNĐ',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 16
                ),
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: (widget.width-20)/5 - 1,
            alignment: Alignment.center,
            child:Padding(
              padding: EdgeInsets.only(right: 5, left: 5),
              child: Text(
                adminList.length.toString() + ' Tài khoản',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 16
                ),
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: (widget.width-20)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(top: 8, left: 15, right: 15, bottom: 10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 5.5
                ),
                itemCount: 3, // Số lượng item trong danh sách của bạn
                itemBuilder: (BuildContext context, int index) {
                  if (index == 1) {
                    return getButton('Trừ tiền', Colors.white, Colors.redAccent, Colors.redAccent, 0 ,() async {
                      showDialog (
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Trừ tiền khu vực'),
                            content: Container(
                              width: widget.width * (1.5/3), // Đặt kích thước chiều rộng theo ý muốn
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
                                              controller: noidungcontrol,
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

                                  if (moneyControl.text.isNotEmpty && noidungcontrol.text.isNotEmpty) {
                                    if (dataCheckManager.containsOnlyDigits(moneyControl.text.toString())) {
                                      if (int.parse(moneyControl.text.toString()) > 0) {
                                        if (double.parse(moneyControl.text.toString()) <= widget.area.money) {
                                          double newmoney = widget.area.money - double.parse(moneyControl.text.toString());
                                          historyTransaction history = historyTransaction(
                                            id: dataCheckManager.generateRandomString(25),
                                            senderId: currentAccount.username,
                                            receiverId: widget.area.id,
                                            transactionTime: Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year),
                                            type: 4,
                                            content: noidungcontrol.text.toString(),
                                            money: double.parse(moneyControl.text.toString()),
                                            area: '',
                                          );
                                          await pushhistoryData(history);
                                          await pushData(widget.area, newmoney);
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
                                      toastMessage('Phải nhập đúng định dạng');
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
                    },);
                  }
                  if (index == 2) {
                    return getButton('Cấu hình', Colors.white, Colors.redAccent, Colors.redAccent,0,
                          () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Xem cấu hình khu vực'),
                                    content: Danhsachcauhinh(width: widget.width, height: 450, id: widget.area.id),
                                  );
                                }
                            );
                          },
                    );
                  }

                  return getButton('Nạp tiền', Colors.redAccent, Colors.redAccent, Colors.white,0, () async {
                    showDialog (
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Nạp tiền khu vực'),
                          content: Container(
                            width: widget.width * (1.5/3), // Đặt kích thước chiều rộng theo ý muốn
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
                                    'Số tiền cần nạp *',
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
                                    'Nội dung nạp tiền *',
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
                                            controller: noidungcontrol,
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

                                if (moneyControl.text.isNotEmpty && noidungcontrol.text.isNotEmpty) {
                                  if (dataCheckManager.containsOnlyDigits(moneyControl.text.toString())) {
                                    if (int.parse(moneyControl.text.toString()) > 0) {
                                      double newmoney = widget.area.money + double.parse(moneyControl.text.toString());
                                      historyTransaction history = historyTransaction(
                                        id: dataCheckManager.generateRandomString(25),
                                        senderId: currentAccount.username,
                                        receiverId: widget.area.id,
                                        transactionTime: Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year),
                                        type: 3,
                                        content: noidungcontrol.text.toString(),
                                        money: double.parse(moneyControl.text.toString()),
                                        area: '',
                                      );
                                      await pushhistoryData(history);
                                      await pushData(widget.area, newmoney);
                                      moneyControl.clear();
                                      Navigator.of(context).pop();
                                    } else {
                                      toastMessage('Phải nhập số lớn hơn 0');
                                      setState(() {
                                        loading = false;
                                      });
                                    }
                                  } else {
                                    toastMessage('Phải nhập đúng định dạng');
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
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
