import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/adminaccount.dart';

import '../../../dataClass/Time.dart';
import '../../../utils/utils.dart';
import '../Area.dart';
import 'Droplist quyền hạn.dart';
import 'Page tìm kiếm.dart';

class SuaTKadmin extends StatefulWidget {
  final AdminAccount adminAccount;
  const SuaTKadmin({Key? key, required this.adminAccount}) : super(key: key);

  @override
  State<SuaTKadmin> createState() => _SuaTKadminState();
}

class _SuaTKadminState extends State<SuaTKadmin> {
  final matkhauController = TextEditingController();
  Time time = Time(second: 1, minute: 0, hour: 0, day: 0, month: 0, year: 0);
  Area area = Area(id: '', name: '', money: 0, status: 0);
  bool loading = false;
  List<Area> areaList = [];



  Future<void> pushData(AdminAccount account) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('ADMINaccount').child(account.username).set(account.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Thêm tài khoản thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").onValue.listen((event) {
      areaList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Area area= Area.fromJson(value);
        areaList.add(area);
      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    matkhauController.text = widget.adminAccount.password;
    if(widget.adminAccount.provinceCode == '0') {
      time.second = 1;
    } else {
      time.second = 2;
    }
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thông tin tài khoản Admin'),
      content: Container(
        width: 450, // Đặt kích thước chiều rộng theo ý muốn
        height: 500, // Đặt kích thước chiều cao theo ý muốn
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
                'Mật khẩu tài khoản admin *',
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
                        controller: matkhauController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'mật khẩu',
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
                'Quyền hạn của tài khoản *',
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
                child: Droplistquyenhan(width: 450, time: time)
            ),

            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Chọn khu vực quản lý *',
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
                height: 150,
                child: searchPageArea(list: areaList, area: area,),
              ),

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
            matkhauController.clear();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: loading ? CircularProgressIndicator() : Text('Lưu'),
          onPressed: loading ? null : () async {
            setState(() {
              loading = true;
            });

            if (matkhauController.text.isNotEmpty && area.id.length != 0) {
              AdminAccount admin = AdminAccount(
                  username: widget.adminAccount.username,
                  password: matkhauController.text.toString(),
                  isBlock: 0,
                  permission: time.second,
                  provinceCode: area.id,
                  createTime: Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year)
              );
              await pushData(admin);
              setState(() {
                loading = false;
              });

              matkhauController.clear();
              Navigator.of(context).pop();
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
  }
}
