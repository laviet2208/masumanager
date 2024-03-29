import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20voucher/Page%20t%C3%ACm%20nh%C3%A0%20h%C3%A0ng.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20voucher/S%E1%BB%ADa%20voucher.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20voucher/Th%C3%AAm%20voucher.dart';
import 'package:masumanager/dataClass/Time.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';
import 'package:masumanager/utils/utils.dart';

import '../../dataClass/accountShop.dart';
import '../Quản lý khu vực và tài khoản admin/Area.dart';
import '../Quản lý khu vực và tài khoản admin/Tài khoản admin khu vực/Page tìm kiếm.dart';
import 'DropList chọn loại.dart';
import 'ITEMdanhsach.dart';
import 'Voucher.dart';

class Danhsachvoucher extends StatefulWidget {
  final double width;
  final double height;
  const Danhsachvoucher({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Danhsachvoucher> createState() => _DanhsachvoucherState();
}

class _DanhsachvoucherState extends State<Danhsachvoucher> {
  List<Area> areaList = [];
  final List<Voucher> voucherList = [];
  List<Voucher> chosenList = [];
  int index = 3;
  Area chosenArea = Area(id: '', name: '', money: 0, status: 0);

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("VoucherStorage").onValue.listen((event) {
      voucherList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Voucher food= Voucher.fromJson(value);
        voucherList.add(food);
        chosenList.add(food);
      });
      setState(() {

      });
    });
  }

  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").onValue.listen((event) {
      areaList.clear();
      areaList.add(Area(id: 'all', name: 'Tất cả', money: 0, status: 0));
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Area area= Area.fromJson(value);
        areaList.add(area);
      });
      setState(() {
        if (areaList.length != 0) {
          chosenArea = areaList.first;
        }
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

  void dropdownCallback(Area? selectedValue) {
    if (selectedValue is Area) {
      chosenArea = selectedValue;
      if (chosenArea.id == 'all') {
        chosenList.clear();
        for(int i = 0 ; i < voucherList.length ; i++) {
          chosenList.add(voucherList.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      } else {
        chosenList.clear();
        for(int i = 0 ; i < voucherList.length ; i++) {
          if (voucherList.elementAt(i).LocationId == chosenArea.id) {
            chosenList.add(voucherList.elementAt(i));
            setState(() {

            });
          }
        }
      }

    }

    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getData1();
    chosenData(1);
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
                        fontFamily: 'muli',
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
                        fontFamily: 'muli',
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
              right: 10,
              child: Container(
                width: 300,
                height: 40,
                child: DropdownButton<Area>(
                  items: areaList.map((e) => DropdownMenuItem<Area>(
                    value: e,
                    child: Text('Khu vực : ' + e.name),
                  )).toList(),
                  onChanged: (value) { dropdownCallback(value); },
                  value: chosenArea,
                  iconEnabledColor: Colors.redAccent,
                  isExpanded: true,
                  iconDisabledColor: Colors.grey,
                ),
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
                    fontFamily: 'muli',
                  ),
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm voucher',
                    prefixIcon: Icon(Icons.search, color: Colors.grey,),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: 'muli',
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
                        fontFamily: 'muli',
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
                        fontFamily: 'muli',
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
                        fontFamily: 'muli',
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
                                fontFamily: 'muli',
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
                                fontFamily: 'muli',
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
                                fontFamily: 'muli',
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
                                fontFamily: 'muli',
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
                                fontFamily: 'muli',
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
