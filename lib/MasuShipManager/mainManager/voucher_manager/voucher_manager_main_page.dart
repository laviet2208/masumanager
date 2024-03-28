import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/voucherData/Voucher.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/mainManager/voucher_manager/actions/add_new_voucher.dart';
import 'package:masumanager/MasuShipManager/mainManager/voucher_manager/item_voucher.dart';
import '../../Data/areaData/Area.dart';
import 'package:auto_size_text/auto_size_text.dart';

class voucher_manager_main_page extends StatefulWidget {
  const voucher_manager_main_page({super.key});

  @override
  State<voucher_manager_main_page> createState() => _voucher_manager_main_pageState();
}

class _voucher_manager_main_pageState extends State<voucher_manager_main_page> {
  List<Voucher> voucherList = [];
  List<Voucher> chosenList = [];
  String chosenStatus = '';
  Area chosenArea = Area(id: '', name: '', money: 0, status: 0);
  List<Area> areaList = [];
  List<String> status_list = ['Tất cả','Chưa bắt đầu', 'Đang hoạt động', 'Đã kết thúc',];
  
  final searchController = TextEditingController();
  
  void on_search_text_changed(String value) {
    setState(() {
      chosenList = voucherList.where((voucher) => voucher.eventName.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  void drop_down_status_voucher(String? selectedValue) {
    if (selectedValue is String) {
      chosenStatus = selectedValue;
      if (chosenStatus == 'Tất cả') {
        chosenList.clear();
        for(int i = 0 ; i < voucherList.length ; i++) {
          chosenList.add(voucherList.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      }

      if (chosenStatus == 'Chưa bắt đầu') {
        chosenList.clear();
        for(int i = 0 ; i < voucherList.length ; i++) {
          DateTime time = DateTime(voucherList[i].startTime.year, voucherList[i].startTime.month, voucherList[i].startTime.day, voucherList[i].startTime.hour, voucherList[i].startTime.minute, voucherList[i].startTime.second);
          if (time.isAfter(DateTime.now())) {
            chosenList.add(voucherList[i]);
          }
        }
        setState(() {

        });
      }

      if (chosenStatus == 'Đang hoạt động') {
        chosenList.clear();
        for(int i = 0 ; i < voucherList.length ; i++) {
          DateTime startTime = DateTime(voucherList[i].startTime.year, voucherList[i].startTime.month, voucherList[i].startTime.day, voucherList[i].startTime.hour, voucherList[i].startTime.minute, voucherList[i].startTime.second);
          DateTime endTime = DateTime(voucherList[i].endTime.year, voucherList[i].endTime.month, voucherList[i].endTime.day, voucherList[i].endTime.hour, voucherList[i].endTime.minute, voucherList[i].endTime.second);
          if (startTime.isBefore(DateTime.now()) && endTime.isAfter(DateTime.now())) {
            chosenList.add(voucherList[i]);
          }
        }
        setState(() {

        });
      }

      if (chosenStatus == 'Đã kết thúc') {
        chosenList.clear();
        for(int i = 0 ; i < voucherList.length ; i++) {
          DateTime time = DateTime(voucherList[i].startTime.year, voucherList[i].startTime.month, voucherList[i].startTime.day, voucherList[i].startTime.hour, voucherList[i].startTime.minute, voucherList[i].startTime.second);
          if (time.isAfter(DateTime.now())) {
            chosenList.add(voucherList[i]);
          }
        }
        setState(() {

        });
      }

    }

    setState(() {

    });
  }

  void drop_down_area(Area? selectedValue) {
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
          if (voucherList.elementAt(i).area == chosenArea.id) {
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

  void get_partner_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("VoucherStorage").onValue.listen((event) {
      voucherList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Voucher shopAccount= Voucher.fromJson(value);
        voucherList.add(shopAccount);
        chosenList.add(shopAccount);
      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chosenStatus = status_list.first;
    get_partner_data();
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
                  fontFamily: 'muli',
                ),
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm theo tên sự kiện',
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

          //Thêm voucher mới
          Positioned(
            top: 10,
            left: 300,
            child: GestureDetector(
              child: Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.yellow,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 11, bottom: 11),
                  child: Text(
                    'Tạo voucher mới',
                    style: TextStyle(
                      fontFamily: 'muli',
                      fontWeight: FontWeight.bold,
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
                    return add_new_voucher();
                  },
                );
              },
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
                onChanged: (value) { drop_down_status_voucher(value); },
                value: chosenStatus,
                iconEnabledColor: Colors.redAccent,
                isExpanded: true,
                iconDisabledColor: Colors.grey,
              ),
            ),
          ),

          //Thanh head thông tin
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Container(
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
                    width: 39,
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

                  GestureDetector(
                    child: Container(
                      width: (width - 40)/5 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Thông tin sự kiện',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'muli',
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
                    width: (width - 40)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thời gian khả dụng',
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
                    width: (width - 40)/5 - 1,
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
                    width: (width - 40)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thông tin khách hàng',
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
                    width: (width - 40)/5 - 1,
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
            top: 120,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              child: ListView.builder(
                itemCount: chosenList.length,
                itemBuilder: (context, index) {
                  return item_voucher(voucher: chosenList[index], index: index);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
