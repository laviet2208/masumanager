import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/mainManager/ingredient/text_line_in_item.dart';
import '../../../Data/accountData/userAccount.dart';
import '../../../Data/areaData/Area.dart';
import '../../../Data/locationData/Location.dart';
import '../../../Data/otherData/Tool.dart';
import '../../../Data/otherData/utils.dart';
import '../../shipper_manager/shipper_manager_main/ingredient/view_current_location_details.dart';
import '../ingredient/lock_open_user_dialog.dart';

class customer_item extends StatefulWidget {
  final UserAccount account;
  final int index;
  const customer_item({super.key, required this.account, required this.index});

  @override
  State<customer_item> createState() => _customer_itemState();
}

class _customer_itemState extends State<customer_item> {
  final Area area = Area(id: '', name: '', money: 0, status: 0);

  void get_area_info() {
    if (widget.account.area != "") {
      final reference = FirebaseDatabase.instance.reference();
      reference.child("Area").child(widget.account.area).onValue.listen((event) {
        final dynamic orders = event.snapshot.value;
        Area a = Area.fromJson(orders);
        area.name = a.name;
        area.money = a.money;
        area.id = a.id;
        setState(() {

        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_area_info();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 80;

    return Container(
      width: width,
      height: 130,
      decoration: BoxDecoration(
        color: widget.index % 2 == 0 ? Colors.white : Color.fromARGB(255, 247, 250, 255),
        border: Border.all(
          color: Color.fromARGB(255, 240, 240, 240),
          width: 1.0,
        ),
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 49,
            alignment: Alignment.center,
            child: Text(
              (widget.index + 1).toString(),
              style: TextStyle(
                fontFamily: 'arial',
                color: Colors.black,

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
            width: (width - 50)/4 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 8,),

                  text_line_in_item(title: 'Số điện thoại: ', content: '0' + widget.account.phone, color: Colors.black),

                  Container(height: 8,),

                  text_line_in_item(title: 'Tên khách hàng: ', content: widget.account.name, color: Colors.black),

                  Container(height: 8,),
                ],
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
            width: (width - 50)/4 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 8,),

                  text_line_in_item(title: 'Kinh độ: ', content: widget.account.location.longitude.toString(), color: Colors.black),

                  Container(height: 8,),

                  text_line_in_item(title: 'Vĩ độ: ', content: widget.account.location.latitude.toString(), color: Colors.black),

                  Container(height: 8,),

                  text_line_in_item(title: 'Khu vực: ', content: area.name, color: Colors.purple),

                  Container(height: 8,),

                  GestureDetector(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Xem vị trí cụ thể',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'muli',
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    onTap: () async {
                      Location location = Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: '');
                      location.longitude = widget.account.location.longitude;
                      location.latitude = widget.account.location.latitude;
                      toastMessage('Vui lòng chờ');
                      location.mainText = await fetchLocationName(location);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return view_current_location_details(location: location);
                        },
                      );
                    },
                  ),

                  Container(height: 20,),
                ],
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
            width: (width - 50)/4 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 8,),

                  text_line_in_item(title: 'Trạng thái: ', content: widget.account.lockStatus == 0 ? 'Đang khóa' : 'Đang mở', color: widget.account.lockStatus == 0 ? Colors.red : Colors.green),

                  Container(height: 8,),

                  text_line_in_item(title: 'Ngày tạo: ', content: getAllTimeString(widget.account.createTime), color: Colors.black),

                  Container(height: 8,),

                  GestureDetector(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Khóa/mở tài khoản',
                        style: TextStyle(
                          fontFamily: 'muli',
                          fontSize: 14,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return lock_open_user_dialog(account: widget.account);
                        },
                      );
                    },
                  ),

                  Container(height: 20,),
                ],
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
            width: (width - 20)/4 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),
                ],
              ),
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
    );
  }
}
