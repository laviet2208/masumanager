import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shipperAccount.dart';
import 'package:masumanager/MasuShipManager/Data/locationData/Location.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/utils.dart';
import 'package:masumanager/MasuShipManager/mainManager/ingredient/text_line_in_item.dart';
import 'package:masumanager/MasuShipManager/mainManager/shipper_manager/shipper_dashboard/shipper_dashboard_step_1.dart';
import 'package:masumanager/MasuShipManager/mainManager/shipper_manager/shipper_manager_main/action_dialog/lock_open_shipper_dialog.dart';
import 'package:masumanager/MasuShipManager/mainManager/shipper_manager/shipper_manager_main/ingredient/recharge_debt_button.dart';
import 'package:masumanager/MasuShipManager/mainManager/shipper_manager/shipper_manager_main/ingredient/view_current_location_details.dart';
import 'package:masumanager/MasuShipManager/mainManager/shipper_manager/shipper_manager_main/ingredient/withdraw_debt_button.dart';
import '../../../Data/areaData/Area.dart';
import 'action/recharge_money_for_shipper.dart';
import 'action/view_shipper_detail.dart';
import 'action/withdraw_money_for_shipper.dart';

class shipper_item extends StatefulWidget {
  final int index;
  final shipperAccount account;
  const shipper_item({Key? key, required this.index, required this.account}) : super(key: key);

  @override
  State<shipper_item> createState() => _shipper_itemState();
}

class _shipper_itemState extends State<shipper_item> {
  Area area = Area(id: '', name: '', money: 0, status: 0);

  void get_area_info() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").child(widget.account.area).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      area = Area.fromJson(orders);
      setState(() {

      });
    });
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

                  text_line_in_item(title: 'Tên tài xế: ', content: widget.account.name, color: Colors.black),

                  Container(height: 8,),

                  text_line_in_item(title: 'Số điện thoại: ', content: widget.account.phone, color: Colors.black),

                  Container(height: 8,),

                  text_line_in_item(title: 'Số dư: ', content: getStringNumber(widget.account.money) + '.đ', color: Colors.black),

                  Container(height: 8,),

                  text_line_in_item(title: 'Số nợ: ', content: getStringNumber(widget.account.debt) + '.đ', color: Colors.redAccent),

                  Container(height: 8,),

                  GestureDetector(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Xem chi tiết tài khoản',
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
                          return view_shipper_detail(account: widget.account);
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

                  text_line_in_item(title: 'Khu vực: ', content: area.name, color: Colors.black),

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

                  text_line_in_item(title: 'Tài khoản: ', content: (widget.account.lockStatus == 1) ? 'Đang mở' : 'Đang khóa', color: (widget.account.lockStatus == 1) ? Colors.blueAccent : Colors.redAccent),

                  Container(height: 8,),

                  text_line_in_item(title: 'Check-in: ', content: (widget.account.onlineStatus == 1) ? 'Đang check-in' : 'Đang check-out', color: (widget.account.onlineStatus == 1) ? Colors.green : Colors.redAccent),

                  Container(height: 8,),

                  text_line_in_item(title: 'Đơn đang chạy: ', content: widget.account.orderHaveStatus.toString() + ' đơn', color: Colors.black),

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
                          return lock_open_shipper_dialog(account: widget.account);
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
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  recharge_money_for_shipper(account: widget.account),

                  Container(height: 8,),

                  withdraw_money_for_shipper(account: widget.account),

                  Container(height: 8,),

                  recharge_debt_button(account: widget.account),

                  Container(height: 8,),

                  withdraw_debt_button(account: widget.account),

                  Container(height: 8,),

                  GestureDetector(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          border: Border.all(
                            width: 0.5,
                            color: Colors.black,
                          )
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Thống kê',
                        style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return shipper_dashboard_step_1(account: widget.account);
                        },
                      );
                    },
                  ),

                  Container(height: 8,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
