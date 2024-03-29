import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20khu%20v%E1%BB%B1c%20v%C3%A0%20t%C3%A0i%20kho%E1%BA%A3n%20admin/Area.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20nh%C3%A0%20h%C3%A0ng/Th%C3%AAm%20c%E1%BB%ADa%20h%C3%A0ng.dart';
import 'package:masumanager/dataClass/accountShop.dart';
import '../../dataClass/Time.dart';
import 'Chỉnh sửa shop.dart';
import 'ITEMinPage.dart';

class PageQuanlyshop extends StatefulWidget {
  final double width;
  final double height;
  const PageQuanlyshop({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<PageQuanlyshop> createState() => _PageQuanlyshopState();
}

class _PageQuanlyshopState extends State<PageQuanlyshop> {
  Uint8List? registrationImage;
  final List<accountShop> shopList = [];
  List<accountShop> chosenList = [];
  List<String> items = ['5 sao','Ăn vặt','Bún phở','Cơm','Khuyến mãi','Món nhậu','Nước uống','Thức ăn nhanh','Trà sữa'];
  final accountShop shop = accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '', OpenStatus: 0);
  int selectIndex = 0;
  bool loading = false;
  String Downloadurl = 'https://firebasestorage.googleapis.com/v0/b/xekoship-a0057.appspot.com/o/favicon.png?alt=media&token=4c3d22bf-971b-45af-9ebe-9561bd74d469';
  List<Area> areaList = [];
  List<String> areaText = [];
  List<Area> areaList1 = [];
  Area chosenArea = Area(id: '', name: '', money: 0, status: 0);


  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Restaurant").onValue.listen((event) {
      shopList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        accountShop food= accountShop.fromJson(value);
        shopList.add(food);
        chosenList.add(food);
        sortChosenListByCreateTime(chosenList);
      });
      setState(() {

      });
    });
  }

  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").onValue.listen((event) {
      areaList.clear();
      areaList1.clear();
      areaList1.add(Area(id: 'all', name: 'Tất cả', money: 0, status: 0));
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Area area= Area.fromJson(value);
        areaList.add(area);
        areaList1.add(area);
      });
      setState(() {
        if (areaList1.length != 0) {
          chosenArea = areaList1.first;
        }
      });
    });
  }

  TextEditingController searchController = TextEditingController();

  void onSearchTextChanged(String value) {
    setState(() {
      chosenList = shopList
          .where((account) =>
          account.name.toLowerCase().contains(value.toLowerCase()) ||
          account.phoneNum.toLowerCase().contains(value.toLowerCase()) ||
          account.id.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  void dropdownCallback(Area? selectedValue) {
    if (selectedValue is Area) {
      chosenArea = selectedValue;
      if (chosenArea.id == 'all') {
        chosenList.clear();
        for(int i = 0 ; i < shopList.length ; i++) {
            chosenList.add(shopList.elementAt(i));
            setState(() {

            });
        }
        setState(() {

        });
      } else {
        chosenList.clear();
        for(int i = 0 ; i < shopList.length ; i++) {
          if (shopList.elementAt(i).Area == chosenArea.id) {
            chosenList.add(shopList.elementAt(i));
            setState(() {

            });
          }
        }
      }

    }

      setState(() {

      });
  }

  void sortChosenListByCreateTime(List<accountShop> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
      return b.createTime.year.compareTo(a.createTime.year) != 0
          ? b.createTime.year.compareTo(a.createTime.year)
          : (b.createTime.month.compareTo(a.createTime.month) != 0
          ? b.createTime.month.compareTo(a.createTime.month)
          : (b.createTime.day.compareTo(a.createTime.day) != 0
          ? b.createTime.day.compareTo(a.createTime.day)
          : (b.createTime.hour.compareTo(a.createTime.hour) != 0
          ? b.createTime.hour.compareTo(a.createTime.hour)
          : (b.createTime.minute.compareTo(a.createTime.minute) != 0
          ? b.createTime.minute.compareTo(a.createTime.minute)
          : b.createTime.second.compareTo(a.createTime.second)))));
    });
  }

  void sortChosenListAZ(List<accountShop> chosenList) {
    chosenList.sort((a, b) => a.name.compareTo(b.name));
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
      height: widget.height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            left: 10,
            child: GestureDetector(
              child: Container(
                width: 120,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text(
                  '+ Thêm mới',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontFamily: 'arial',
                      fontSize: 14
                  ),
                ),
              ),
              onTap: () async {
                showDialog (
                  context: context,
                  builder: (BuildContext context) {
                    return Themcuahang(width: widget.width, height: widget.height);
                  },
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
                    width: (widget.width - 20)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                      child: Container(
                        width: (widget.width - 20)/5 - 1 - 20,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                height: 18,
                                width: (widget.width - 20)/5 - 1 - 20,
                                child: AutoSizeText(
                                  'Tên nhà hàng',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'muli',
                                      color: Colors.black,
                                      fontSize: 100
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                child: Icon(
                                  Icons.arrow_downward_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                onTap: () {
                                  sortChosenListAZ(chosenList);
                                  setState(() {

                                  });
                                },
                              ),
                            )
                          ],
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
                    width: (widget.width - 20)/5 - 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                      child: Container(
                        width: (widget.width - 20)/5 - 1 - 20,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                height: 18,
                                width: (widget.width - 20)/5 - 1 - 20,
                                child: AutoSizeText(
                                    'Thời gian tạo',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'muli',
                                        color: Colors.black,
                                        fontSize: 100
                                    ),
                                  ),
                              ),
                            ),

                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                child: Icon(
                                  Icons.arrow_downward_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                onTap: () {
                                  sortChosenListByCreateTime(chosenList);
                                  setState(() {

                                  });
                                },
                              ),
                            )
                          ],
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
                    width: (widget.width - 20)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thời gian hoạt động',
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
                    width: (widget.width - 20)/5 - 60,
                    alignment: Alignment.center,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Trạng thái tài khoản',
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
                    width: (widget.width - 20)/5 - 1 + 60,
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
            top: 20,
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
            top: 130,
            left: 10,
            child: Container(
              width: widget.width - 20,
              height: widget.height - 155,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
              ),
              alignment: Alignment.center,
              child: (chosenList.length == 0) ? Text('không có nhà hàng nào') : ListView.builder(
                itemCount: chosenList.length,
                itemBuilder: (context, index) {
                  return ITEMshop(width: widget.width - 20, height: 120, shop: chosenList[index],
                    updateEvent: () {
                        showDialog (
                          context: context,
                          builder: (BuildContext context) {
                            return Chinhsuashop(width: widget.width, height: widget.height, shop: chosenList[index], data: 'Restaurant',);
                          },
                        );
                    }, color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255), data: 'Restaurant',);
                },
              ),
            ),
          ),

          Positioned(
            top: 20,
            left: 150,
            child: Container(
              width: 500,
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
                  hintText: 'Tìm kiếm nhà hàng',
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
        ],
      ),
    );
  }
}
