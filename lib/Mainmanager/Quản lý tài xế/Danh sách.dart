import 'dart:html';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20t%C3%A0i%20x%E1%BA%BF/Th%C3%AAm%20t%C3%A0i%20x%E1%BA%BF%20test/Th%C3%AAm%20t%C3%A0i%20x%E1%BA%BF.dart';
import 'package:masumanager/childrenManager/Qu%E1%BA%A3n%20l%C3%BD%20t%C3%A0i%20x%E1%BA%BF/C%E1%BA%ADp%20nh%E1%BA%ADt%20t%C3%A0i%20x%E1%BA%BF.dart';
import 'package:masumanager/utils/utils.dart';

import '../Quản lý khu vực và tài khoản admin/Area.dart';
import '../Quản lý khu vực và tài khoản admin/Tài khoản admin khu vực/Page tìm kiếm.dart';
import '../Quản lý khách hàng/accountNormal.dart';
import 'Item danh sách.dart';

class danhsachtaixe extends StatefulWidget {
  final double width;
  final double height;
  const danhsachtaixe({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<danhsachtaixe> createState() => _danhsachtaixeState();
}

class _danhsachtaixeState extends State<danhsachtaixe> {
  List<accountNormal> accountList = [];
  List<accountNormal> chosenList = [];
  List<Area> areaList1 = [];
  Area chosenArea = Area(id: '', name: '', money: 0, status: 0);

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("normalUser").onValue.listen((event) {
      accountList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        accountNormal food= accountNormal.fromJson(value);
        if (food.type == 2) {
          accountList.add(food);
          chosenList.add(food);
        }
      });
      setState(() {

      });
    });
  }

  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").onValue.listen((event) {
      areaList1.clear();
      areaList1.add(Area(id: 'all', name: 'Tất cả', money: 0, status: 0));
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Area area= Area.fromJson(value);
        areaList1.add(area);
      });
      setState(() {
        if (areaList1.length != 0) {
          chosenArea = areaList1.first;
        }
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

  TextEditingController searchController = TextEditingController();

  void onSearchTextChanged(String value) {
    setState(() {
      chosenList = accountList
          .where((account) =>
      account.phoneNum.toLowerCase().contains(value.toLowerCase()) || account.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void dropdownCallback(Area? selectedValue) {
    if (selectedValue is Area) {
      chosenArea = selectedValue;
      if (chosenArea.id == 'all') {
        chosenList.clear();
        for(int i = 0 ; i < accountList.length ; i++) {
          chosenList.add(accountList.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      } else {
        chosenList.clear();
        for(int i = 0 ; i < accountList.length ; i++) {
          if (accountList.elementAt(i).Area == chosenArea.id) {
            chosenList.add(accountList.elementAt(i));
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
              child: Container(
                width: 350,
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
                    hintText: 'Tìm kiếm theo tên và số điện thoại',
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
              top: 10,
              left: 370,
              child: GestureDetector(
                child: Container(
                  height: 40,
                  width: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.yellow.shade700,
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: 11, bottom: 11),
                    child: AutoSizeText(
                      'Tạo tài xế mới',
                      style: TextStyle(
                        fontFamily: 'arial',
                        color: Colors.black,
                        fontSize: 100,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DialogAddDriver();
                    },
                  );
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
                      width: 29,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            '',
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
                      width: (widget.width - 20)/6 - 1 - 30,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Tài khoản',
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
                      width: (widget.width - 20)/6 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Vị trí được chọn',
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
                      width: (widget.width - 20)/6 - 1 - 100,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Trạng thái',
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
                      width: 160,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Online',
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
                      width: (widget.width - 20)/6 - 1 - 60,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Thuộc khu vực',
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
                      width: (widget.width - 20)/6 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Ngày khởi tạo',
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
                      width: (widget.width - 20)/6 - 1,
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
                  ],
                ),
              ),
            ),

            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 400,
                height: 40,
                child: DropdownButton<Area>(
                  items: areaList1.map((e) => DropdownMenuItem<Area>(
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
              top: 125,
              bottom: 0,
              left: 10,
              child: Container(
                width: widget.width - 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255)
                ),
                child: (chosenList.length == 0) ? Text('Danh sách trống') : ListView.builder(
                    itemCount: chosenList.length,
                    itemBuilder: (context, index) {
                      return ITEMdanhsachtaixe(width: widget.width, height: 120, account: chosenList[index], index: index + 1,
                        onTapUpdate: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return UpdateDriver(driver: chosenList[index]);
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
