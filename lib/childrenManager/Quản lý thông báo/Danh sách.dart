import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20th%C3%B4ng%20b%C3%A1o/Item%20trong%20danh%20s%C3%A1ch.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20th%C3%B4ng%20b%C3%A1o/Notification.dart';
import 'package:masumanager/dataClass/FinalClass.dart';
import '../../Mainmanager/Quản lý khu vực và tài khoản admin/Area.dart';
import '../../Mainmanager/Quản lý khu vực và tài khoản admin/Tài khoản admin khu vực/Page tìm kiếm.dart';
import '../../Mainmanager/Quản lý thông báo/Droplistnguoinhan.dart';
import '../../dataClass/Time.dart';
import '../../dataClass/accountShop.dart';
import '../../utils/utils.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

class Pagequanlythongbao extends StatefulWidget {
  final double width;
  final double height;
  const Pagequanlythongbao({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Pagequanlythongbao> createState() => _PagequanlythongbaoState();
}

class _PagequanlythongbaoState extends State<Pagequanlythongbao> {
  bool loading = false;
  final accountShop shop = accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '', OpenStatus: 0);
  final tieudecontrol = TextEditingController();
  final noidungcontrol = TextEditingController();
  final tieudephucontrol = TextEditingController();
  Area area = Area(id: '', name: '', money: 0, status: 0);
  List<notification> list = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Notification").onValue.listen((event) {
      list.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        notification noti = notification.fromJson(value);
        if(noti.Area == currentAccount.provinceCode) {
          list.add(noti);
        }
      });
      setState(() {

      });
    });
  }


  Future<void> pushData(notification notification) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Notification').child(notification.id).set(notification.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Thêm thông báo thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
              child: Container(
                width: 220,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text(
                  '+ Thêm thông báo mới',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontFamily: 'arial',
                      fontSize: 14
                  ),
                ),
              ),
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Thêm thông báo mới'),
                        content: Container(
                          width: widget.width * (1.5/3),
                          height: widget.height * (2/3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
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
                                  'Tiêu đề thông báo *',
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
                                          controller: tieudecontrol,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'arial',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Tiêu đề thông báo',
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
                                  'Tiêu đề phụ thông báo *',
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
                                          controller: tieudephucontrol,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'arial',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Tiêu đề phụ thông báo',
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
                                  'Nội dung thông báo *',
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
                                            hintText: 'Nội dung thông báo',
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
                                  'Chọn loại người nhận *',
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
                                  child: Droplistnguoinhan(width: widget.width * (1.5/3), shop: shop)
                              ),

                              Container(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Hủy'),
                              onPressed: () {
                                tieudecontrol.clear();
                                noidungcontrol.clear();
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: loading ? CircularProgressIndicator() : Text('Lưu'),
                              onPressed: loading ? null : () async {
                                setState(() {
                                  loading = true;
                                });

                                if (tieudecontrol.text.isNotEmpty && noidungcontrol.text.isNotEmpty) {
                                  notification noti = notification(
                                      id: dataCheckManager.generateRandomString(20),
                                      Area: currentAccount.provinceCode,
                                      Title: tieudecontrol.text.toString(),
                                      Sub: tieudephucontrol.text.toString(),
                                      object: shop.Type,
                                      create: Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year),
                                      send: Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year),
                                      status: 1,
                                      Content: noidungcontrol.text.toString()
                                  );
                                  await pushData(noti);
                                  setState(() {
                                    loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
                                  });

                                  tieudecontrol.clear();
                                  noidungcontrol.clear();
                                  Navigator.of(context).pop();
                                } else {
                                  toastMessage('Phải nhập đủ thông tin');
                                  setState(() {
                                    loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
                                  });
                                }
                              },
                            ),
                          ]
                      );
                    }
                    );
              },
              ),
            ),

          Positioned(
            top: 80,
            left: 10,
            child: Container(
              width: widget.width - 20,
              height: 50,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 250, 255),
                  border: Border.all(
                      width: 1,
                      color: Color.fromARGB(255, 225, 225, 226)
                  )
              ),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: (widget.width - 20)/4 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Tiêu đề và nội dung',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        )
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),

                  Container(
                    width: (widget.width - 20)/4 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Đối tượng nhận',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        )
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),

                  Container(
                    width: (widget.width - 20)/4 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thời gian',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        )
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),

                  Container(
                    width: (widget.width - 20)/4 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thao tác',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        )
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 130,
            left: 10,
            child: Container(
              width: widget.width - 20,
              height: widget.height - 140,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
              ),
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Itemdanhsachtb(width: widget.width - 20, notice: list[index], color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
