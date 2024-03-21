import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/FinalClass.dart';
import 'package:masumanager/dataClass/Time.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';
import 'package:masumanager/utils/utils.dart';

import '../../Mainmanager/Quản lý khu vực và tài khoản admin/Area.dart';
import '../../Mainmanager/Quản lý khu vực và tài khoản admin/Tài khoản admin khu vực/Page tìm kiếm.dart';
import '../../Mainmanager/Quản lý voucher/DropList chọn loại.dart';
import '../../Mainmanager/Quản lý voucher/ITEMdanhsach.dart';
import '../../Mainmanager/Quản lý voucher/Page tìm nhà hàng.dart';
import '../../Mainmanager/Quản lý voucher/Sửa voucher.dart';
import '../../Mainmanager/Quản lý voucher/Thêm voucher.dart';
import '../../Mainmanager/Quản lý voucher/Voucher.dart';
import '../../dataClass/accountShop.dart';

class Danhsachvoucher extends StatefulWidget {
  final double width;
  final double height;
  const Danhsachvoucher({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Danhsachvoucher> createState() => _DanhsachvoucherState();
}

class _DanhsachvoucherState extends State<Danhsachvoucher> {
  final accountShop shop = accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '', OpenStatus: 0);

  List<Area> areaList = [];
  List<accountShop> shopList = [];
  Area area = Area(id: '', name: '', money: 0, status: 0);
  bool loading = false;
  final List<Voucher> voucherList = [];
  List<Voucher> chosenList = [];
  int index = 3;

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("VoucherStorage").onValue.listen((event) {
      voucherList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Voucher voucher= Voucher.fromJson(value);
        if (voucher.LocationId == currentAccount.provinceCode) {
          voucherList.add(voucher);
          chosenList.add(voucher);
        }
      });
      setState(() {

      });
    });
  }

  Future<void> pushData(Voucher voucher) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('VoucherStorage').child(voucher.id).set(voucher.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('đăng voucher thành công');
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

  void getData2() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Restaurant").onValue.listen((event) {
      shopList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        accountShop area= accountShop.fromJson(value);
        shopList.add(area);
      });
      setState(() {

      });
    });
  }

  void chosenData(int init) {
    if (init == 1) {
      chosenList.clear();
      for (Voucher vou in voucherList) {
        if (vou.Otype == '1') {
          chosenList.add(vou);
        }
      }
    }

    if (init == 2) {
      chosenList.clear();
      for (Voucher vou in voucherList) {
        if (vou.Otype != '1') {
          chosenList.add(vou);
        }
      }
    }

    if (init == 3) {
      chosenList.clear();
      for (Voucher vou in voucherList) {
        chosenList.add(vou);
      }
    }
  }

  TextEditingController searchController = TextEditingController();

  void onSearchTextChanged(String value) {
    setState(() {
      chosenList = voucherList
          .where((account) =>
      account.id.toLowerCase().contains(value.toLowerCase()) ||
          account.tenchuongtrinh.toLowerCase().contains(value.toLowerCase()) ||
          account.id.toLowerCase().contains(value.toLowerCase()) ||
          account.totalmoney.toString().toLowerCase().contains(value.toLowerCase()) ||
          account.mincost.toString().toLowerCase().contains(value.toLowerCase()) ||
          account.maxCount.toString().toLowerCase().contains(value.toLowerCase()) ||
          account.useCount.toString().toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getData1();
    getData2();
    chosenData(3);
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
                    '+ Thêm mới voucher khách',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontFamily: 'roboto',
                        fontSize: 14
                    ),
                  ),
                ),
                onTap: () {
                  showDialog (
                    context: context,
                    builder: (BuildContext context) {
                      return Themvoucher(width: widget.width, height: widget.height, type: 1);
                    },
                  );
                },
              ),
            ),

            Positioned(
              top: 10,
              left: 240,
              child: GestureDetector(
                child: Container(
                  width: 240,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    '+ Thêm mới voucher nhà hàng',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontFamily: 'roboto',
                        fontSize: 14
                    ),
                  ),
                ),
                onTap: () {
                  showDialog (
                    context: context,
                    builder: (BuildContext context) {
                      return Themvoucher(width: widget.width, height: widget.height, type: 2);
                    },
                  );
                },
              ),
            ),

            Positioned(
              top: 60,
              left: 650,
              child: Container(
                width: 400,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                ),
                child: TextFormField(
                  controller: searchController,
                  onChanged: onSearchTextChanged,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'roboto',
                  ),
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm voucher',
                    prefixIcon: Icon(Icons.search, color: Colors.grey,),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: 'roboto',
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 60,
              left: 10,
              child: GestureDetector(
                child: Container(
                  width: 200,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: (index == 1) ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1.5,
                          color: Colors.blue
                      )
                  ),
                  child: Text(
                    '+ Voucher khách hàng',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: (index == 1) ? Colors.white : Colors.blue,
                        fontFamily: 'roboto',
                        fontSize: 14
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    index = 1;
                    chosenData(1);
                  });
                },
              ),
            ),

            Positioned(
              top: 60,
              left: 230,
              child: GestureDetector(
                child: Container(
                  width: 200,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: (index == 2) ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1.5,
                          color: Colors.blue
                      )
                  ),
                  child: Text(
                    '+ Voucher nhà hàng',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: (index == 2) ? Colors.white : Colors.blue,
                        fontFamily: 'roboto',
                        fontSize: 14
                    ),
                  ),
                ),
                onTap: () {
                  index = 2;
                  chosenData(2);
                  setState(() {

                  });
                },
              ),
            ),

            Positioned(
              top: 60,
              left: 450,
              child: GestureDetector(
                child: Container(
                  width: 150,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: (index == 3) ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1.5,
                          color: Colors.blue
                      )
                  ),
                  child: Text(
                    '+ Tất cả',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: (index == 3) ? Colors.white : Colors.blue,
                        fontFamily: 'roboto',
                        fontSize: 14
                    ),
                  ),
                ),
                onTap: () {
                  index = 3;
                  chosenData(3);
                  setState(() {

                  });
                },
              ),
            ),

            Positioned(
              top: 130,
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
                      width: (widget.width - 20)/5 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Tên sự kiện',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'roboto',
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
                      width: (widget.width - 20)/5 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Thời gian',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'roboto',
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
                      width: (widget.width - 20)/5 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Giá trị voucher',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'roboto',
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
                      width: (widget.width - 20)/5 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Lượt sử dụng',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'roboto',
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
                      width: (widget.width - 20)/5 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Thao tác',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'roboto',
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
              top: 190,
              left: 10,
              child: Container(
                width: widget.width - 20,
                height: widget.height - 205,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255)
                ),
                alignment: Alignment.center,
                child: (chosenList.length == 0) ? Text('Danh sách trống') : ListView.builder(
                    itemCount: chosenList.length,
                    itemBuilder: (context, index) {
                      return ITEMdanhsach(width: widget.width - 20, height: 120, voucher: chosenList[index], color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255),
                        onTapUpdate: () {
                          showDialog (
                            context: context,
                            builder: (BuildContext context) {
                              return Capnhatvoucher(width: widget.width, height: widget.height, voucher: chosenList[index], type: int.parse(chosenList[index].Otype));
                            },
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
