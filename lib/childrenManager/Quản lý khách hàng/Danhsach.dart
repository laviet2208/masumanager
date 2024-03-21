import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/FinalClass.dart';

import '../../Mainmanager/Quản lý khu vực và tài khoản admin/Area.dart';
import '../../Mainmanager/Quản lý khu vực và tài khoản admin/Tài khoản admin khu vực/Page tìm kiếm.dart';
import '../../Mainmanager/Quản lý khách hàng/ITEMdskhachhang.dart';
import '../../Mainmanager/Quản lý khách hàng/accountNormal.dart';
import '../../utils/utils.dart';


class Danhsachkhachhang extends StatefulWidget {
  final double width;
  final double height;
  const Danhsachkhachhang({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Danhsachkhachhang> createState() => _DanhsachkhachhangState();
}

class _DanhsachkhachhangState extends State<Danhsachkhachhang> {
  List<accountNormal> accountList = [];
  final TextEditingController name = TextEditingController();
  List<Area> areaList = [];
  Area area = Area(id: '', name: '', money: 0, status: 0);

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("normalUser").onValue.listen((event) {
      accountList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        accountNormal food= accountNormal.fromJson(value);
        if (food.Area == currentAccount.provinceCode) {
          accountList.add(food);
        }
      });
      setState(() {

      });
    });
  }

  Future<void> pushData(accountNormal account) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('normalUser').child(account.id).set(account.toJson());
      toastMessage('Thay đổi thông tin thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
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
    getData();
    getData1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              left: 10,
              child: GestureDetector(
                child: Container(
                  width: 200,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    'Xuất danh sách Excel',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontFamily: 'arial',
                        fontSize: 14
                    ),
                  ),
                ),
                onTap: () {

                },
              ),
            ),

          Positioned(
            top: 70,
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
                    width: (widget.width - 20)/6 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thông tin tài khoản',
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
                    width: (widget.width - 20)/6 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Vị trí hiện tại trong app',
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
                        color: Color.fromARGB(255, 225,  225, 226)
                    ),
                  ),

                  Container(
                    width: (widget.width - 20)/6 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Trạng thái tài khoản',
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
                    width: (widget.width - 20)/6 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thuộc khu vực',
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
                    width: (widget.width - 20)/6 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Ngày khởi tạo',
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
                    width: (widget.width - 20)/6 - 1,
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
                ],
              ),
            ),
          ),

            Positioned(
              top: 125,
              left: 10,
              child: Container(
                width: widget.width - 20,
                height: widget.height - 130,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255)
                ),
                child: ListView.builder(
                    itemCount: accountList.length,
                    itemBuilder: (context, index) {
                      return ITEMdanhsachkhachhang(width: widget.width, height: 150, account: accountList[index], color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255),
                        onTapUpdate: () async {
                          name.text = accountList[index].name.toString();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Cập nhật thông tin tài xế'),
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
                                            'Tên trong app',
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
                                                    controller: name,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'arial',
                                                    ),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: 'Tên trong app',
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
                                            'Chọn khu vực',
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

                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Hủy'),
                                      onPressed: () {
                                        area.id = '';
                                        name.clear();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child:Text('Lưu'),
                                      onPressed: () async {
                                        if (name.text.isNotEmpty && area.id != '') {
                                          accountList[index].name = name.text.toString();
                                          accountList[index].Area = area.id;
                                          await pushData(accountList[index]);
                                          area.id = '';
                                          name.clear();
                                          Navigator.of(context).pop();
                                        } else {
                                          toastMessage('Điền đủ các mục rồi tiếp tục');
                                        }
                                      },
                                    ),
                                  ],
                                );
                              }
                          );
                        },
                      );
                    }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
