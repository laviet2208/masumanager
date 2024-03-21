import 'package:flutter/material.dart';
import '../../../Data/accountData/shipperAccount.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../Data/areaData/Area.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'shipper_item.dart';
import 'action_dialog/add_new_driver_dialog.dart';

class shipper_manager_main_page extends StatefulWidget {
  const shipper_manager_main_page({Key? key}) : super(key: key);

  @override
  State<shipper_manager_main_page> createState() => _shipper_manager_main_pageState();
}

class _shipper_manager_main_pageState extends State<shipper_manager_main_page> {
  List<shipperAccount> shipperList = [];
  List<shipperAccount> chosenList = [];
  List<String> status_list = ['Tất cả','Đang check-in', 'Đang check-out', 'Đang có đơn', 'Chưa có đơn',];
  String chosenStatus = '';
  List<Area> areaList = [];
  TextEditingController searchController = TextEditingController();
  Area chosenArea = Area(id: '', name: '', money: 0, status: 0);

  void get_shipper_list() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Account").onValue.listen((event) {
      shipperList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        if (value['license'] != null) {
          shipperAccount account = shipperAccount.fromJson(value);
          shipperList.add(account);
          chosenList.add(account);
        }
      });
      setState(() {

      });
    });
  }

  void get_area_data() {
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

  void on_search_text_changed(String value) {
    setState(() {
      chosenList = shipperList.where((account) => account.phone.toLowerCase().contains(value.toLowerCase()) || account.name.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  void drop_down_area(Area? selectedValue) {
    if (selectedValue is Area) {
      chosenArea = selectedValue;
      if (chosenArea.id == 'all') {
        chosenList.clear();
        for(int i = 0 ; i < shipperList.length ; i++) {
          chosenList.add(shipperList.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      } else {
        chosenList.clear();
        for(int i = 0 ; i < shipperList.length ; i++) {
          if (shipperList.elementAt(i).area == chosenArea.id) {
            chosenList.add(shipperList.elementAt(i));
            setState(() {

            });
          }
        }
      }

    }

    setState(() {

    });
  }

  Future<void> push_new_driver(String id) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Account').child(id).child('orderHaveStatus').set(0);
      await databaseRef.child('Account').child(id).child('onlineStatus').set(0);
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy tài xế mới');
      throw error;
    }
  }

  void drop_down_status_account(String? selectedValue) {
    if (selectedValue is String) {
      chosenStatus = selectedValue;
      if (chosenStatus == 'Tất cả') {
        chosenList.clear();
        for(int i = 0 ; i < shipperList.length ; i++) {
          chosenList.add(shipperList.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      }

      if (chosenStatus == 'Đang check-out') {
        chosenList.clear();
        for(int i = 0 ; i < shipperList.length ; i++) {
          if (shipperList.elementAt(i).onlineStatus == 0) {
            chosenList.add(shipperList.elementAt(i));
            setState(() {

            });
          }
        }
        setState(() {

        });
      }

      if (chosenStatus == 'Đang check-in') {
        chosenList.clear();
        for(int i = 0 ; i < shipperList.length ; i++) {
          if (shipperList.elementAt(i).onlineStatus == 1) {
            chosenList.add(shipperList.elementAt(i));
            setState(() {

            });
          }
        }
        setState(() {

        });
      }

      if (chosenStatus == 'Đang có đơn') {
        chosenList.clear();
        for(int i = 0 ; i < shipperList.length ; i++) {
          if (shipperList.elementAt(i).orderHaveStatus == 1) {
            chosenList.add(shipperList.elementAt(i));
            setState(() {

            });
          }
        }
        setState(() {

        });
      }

      if (chosenStatus == 'Chưa có đơn') {
        chosenList.clear();
        for(int i = 0 ; i < shipperList.length ; i++) {
          if (shipperList.elementAt(i).orderHaveStatus == 0) {
            chosenList.add(shipperList.elementAt(i));
            setState(() {

            });
          }
        }
        setState(() {

        });
      }
    }

    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chosenStatus = status_list.first;
    get_shipper_list();
    get_area_data();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    double height = MediaQuery.of(context).size.height - 60;
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          //tìm kiếm
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              width: 280,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
              ),
              child: TextFormField(
                controller: searchController,
                onChanged: on_search_text_changed,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'roboto',
                ),
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm theo tên và số điện thoại',
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

          //chọn theo khu vực
          Positioned(
            top: 10,
            right: 0,
            child: Container(
              width: 250,
              height: 40,
              child: DropdownButton<Area>(
                items: areaList.map((e) => DropdownMenuItem<Area>(
                  value: e,
                  child: Text('Khu vực : ' + e.name),
                )).toList(),
                onChanged: (value) { drop_down_area(value); },
                value: chosenArea,
                iconEnabledColor: Colors.redAccent,
                isExpanded: true,
                iconDisabledColor: Colors.grey,
              ),
            ),
          ),

          //chọn theo trạng thái
          Positioned(
            top: 10,
            right: 270,
            child: Container(
              width: 250,
              height: 40,
              child: DropdownButton<String>(
                items: status_list.map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                )).toList(),
                onChanged: (value) { drop_down_status_account(value); },
                value: chosenStatus,
                iconEnabledColor: Colors.redAccent,
                isExpanded: true,
                iconDisabledColor: Colors.grey,
              ),
            ),
          ),

          //tạo tài xế mới
          Positioned(
            top: 10,
            left: 300,
            child: GestureDetector(
              child: Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.yellow.shade700,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 11, bottom: 11),
                  child: Text(
                    'Tạo tài xế mới',
                    style: TextStyle(
                      fontFamily: 'arial',
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return add_new_driver_dialog();
                  },
                );
              },
            ),
          ),

          //Thanh head thông tin
          Positioned(
            top: 70,
            left: 10,
            child: Container(
              width: width - 20,
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

                  GestureDetector(
                    child: Container(
                      width: (width - 20)/6 - 1 - 30 + 80,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Tài khoản',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'roboto',
                                color: Colors.black,
                                fontSize: 100
                            ),
                          )
                      ),
                    ),
                    // onTap: () async {
                    //   for(int i = 0; i < shipperList.length; i++) {
                    //     await push_new_driver(shipperList[i].id);
                    //   }
                    // },
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),

                  Container(
                    width: (width - 20)/6 - 1 + 80,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Vị trí được chọn',
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
                    width: (width - 20)/6 - 1 - 100,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Trạng thái',
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
                    width: (width - 20)/6 - 1 - 60,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thuộc khu vực',
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
                    width: (width - 20)/6 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Ngày khởi tạo',
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
                    width: (width - 20)/6 - 1,
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
                ],
              ),
            ),
          ),

          Positioned(
            top: 125,
            bottom: 10,
            left: 10,
            child: Container(
              width: width - 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
              ),
              child: (chosenList.length == 0) ? Text('Danh sách trống') : ListView.builder(
                  itemCount: chosenList.length,
                  itemBuilder: (context, index) {
                    return shipper_item(index: index, account: chosenList[index]);
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
