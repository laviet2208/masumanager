import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/FinalClass.dart';

import '../../dataClass/Time.dart';
import '../../dataClass/accountShop.dart';
import '../../utils/utils.dart';
import '../Quản lý khu vực và tài khoản admin/Area.dart';
import '../Quản lý khu vực và tài khoản admin/Tài khoản admin khu vực/Page tìm kiếm.dart';
import '../Quản lý store danh mục/DropList chọn icon.dart';
import 'Danh mục.dart';

class Capnhatdanhmuc extends StatefulWidget {
  final RestaurantDirectory directory;
  final String data;
  const Capnhatdanhmuc({Key? key, required this.directory, required this.data}) : super(key: key);

  @override
  State<Capnhatdanhmuc> createState() => _CapnhatdanhmucState();
}

class _CapnhatdanhmucState extends State<Capnhatdanhmuc> {
  final mainContent = TextEditingController();
  final subContent = TextEditingController();
  bool loading = false;
  Area area = Area(id: '', name: '', money: 0, status: 0);
  List<Area> areaList = [];
  final accountShop shop = accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '', OpenStatus: 0);

  Future<void> pushDataMainContent(String data) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child(widget.data + '/' + widget.directory.id + '/mainContent').set(data);
      toastMessage('Sửa thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushDataSubContent(String data) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child(widget.data + '/' + widget.directory.id + '/subContent').set(data);
      toastMessage('Sửa thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushDataMainIcon(String data) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child(widget.data + '/' + widget.directory.id + '/mainIcon').set(data);
      toastMessage('Sửa thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushDataSubIcon(String data) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child(widget.data + '/' + widget.directory.id + '/subIcon').set(data);
      toastMessage('Sửa thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushDataArea(String data) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child(widget.data + '/' + widget.directory.id + '/Area').set(data);
      toastMessage('Sửa thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> deleteProduct(String idshop) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child(widget.data + '/' + idshop).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi xóa: $error');
      throw error;
    }
  }

  void getData1() {
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
    getData1();
    mainContent.text = widget.directory.mainContent;
    subContent.text = widget.directory.subContent;
    shop.id = widget.directory.mainIcon;
    shop.phoneNum = widget.directory.subIcon;
    if (currentAccount.provinceCode != '0') {
      area.id = currentAccount.provinceCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cập nhật thông tin danh mục'),
      content: Container(
        width: 500,
        height: 400,
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
                'Tên danh mục *',
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
                        controller: mainContent,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tên danh mục',
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

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Tên danh mục phụ bên dưới',
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
                        controller: subContent,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tên danh mục phụ',
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

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Chọn icon cho tiêu đề chính',
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
                child: Droplisticon(width: 500, shop: shop, type: 1,)
            ),

            Container(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Chọn icon cho tiêu đề phụ',
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
                child: Droplisticon(width:  500 , shop: shop, type: 2,)
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
                    fontSize: currentAccount.provinceCode == '0' ? 14 : 0,
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
                height: currentAccount.provinceCode == '0' ? 150 : 0,
                child: searchPageArea(list: areaList, area: area,),
              ),

            ),

            Container(
              height: 40,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: loading ? CircularProgressIndicator() : Text('Lưu'),
          onPressed: loading ? null : () async {
            setState(() {
              loading = true;
            });

            if (mainContent.text.isNotEmpty && subContent.text.isNotEmpty && area.id != '') {
              if (shop.phoneNum != '' && shop.id != '') {
                await pushDataMainContent(mainContent.text.toString());
                await pushDataSubContent(subContent.text.toString());
                await pushDataMainIcon(shop.id);
                await pushDataSubIcon(shop.phoneNum);
                if (currentAccount.provinceCode == '0') {
                  await pushDataArea(area.id);
                }

                toastMessage('thành công');
                Navigator.of(context).pop();
              }
            } else {
              toastMessage('Phải nhập đủ thông tin');
              setState(() {
                loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
              });
            }
          },
        ),

        TextButton(
          child: Text('Thoát'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        TextButton(
          child: Text('Xóa danh mục', style: TextStyle(color: Colors.redAccent),),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Bạn có chắc chắn xóa'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Hủy'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),

                      TextButton(
                        child: Text('Đồng ý'),
                        onPressed: () async {
                          await deleteProduct(widget.directory.id);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }
            );
          },
        ),
      ],
    );
  }
}
