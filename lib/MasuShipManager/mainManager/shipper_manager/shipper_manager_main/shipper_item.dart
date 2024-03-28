import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shipperAccount.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
  final Area area = Area(id: '', name: '', money: 0, status: 0);
  String locationName = '';
  void get_area_info() {
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

  void fetchLocationName(double latitude, double longitude) async {
    final Uri uri = Uri.parse('https://rsapi.goong.io/Geocode?latlng=$latitude,$longitude&api_key=3u7W0CAOa9hi3SLC6RI3JWfBf6k8uZCSUTCHKOLf');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        locationName = data['results'][0]['formatted_address'];
        setState(() {

        });
      });
    } else {
      throw Exception('Failed to load location');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_area_info();
    fetchLocationName(widget.account.location.latitude, widget.account.location.longitude);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    
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
            width: 29,
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
            width: (width - 20)/6 - 1 - 29 + 80,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Số điện thoại : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: (widget.account.phone[0] == '0') ? widget.account.phone : ('0' + widget.account.phone), // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Tên trong app : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.account.name, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Số dư : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: getStringNumber(widget.account.money)+'đ', // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              color: Colors.black,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
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
            width: (width - 20)/6 - 1 + 80,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Đang ở gần : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: locationName, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
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
            width: (width - 20)/6 - 1 - 100,
            alignment: Alignment.center,
            child: ListView(
              children: [
                Container(height: 5,),

                Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(
                          width: 0.5,
                          color: widget.account.lockStatus == 0 ? Colors.red : Colors.green,
                        )
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        (widget.account.lockStatus == 1) ? 'Đang mở' : 'Đang khóa',
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontSize: 13,
                            color: widget.account.lockStatus == 0 ? Colors.red : Colors.green,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                ),

                Container(height: 5,),

                Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                            width: 0.5,
                            color: widget.account.onlineStatus == 0 ? Colors.red : Colors.blueAccent,
                          )
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        (widget.account.onlineStatus == 1) ? 'Đang check-in' : 'Đang check-out',
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontSize: 13,
                            color:  widget.account.onlineStatus == 0 ? Colors.red : Colors.blueAccent,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                ),

                Container(height: 5,),

                Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                            width: 0.5,
                            color: widget.account.orderHaveStatus == 0 ? Colors.black : Colors.green,
                          )
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        (widget.account.orderHaveStatus == 1) ? 'Đang chạy đơn' : 'Chưa có đơn',
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontSize: 13,
                            color:  widget.account.orderHaveStatus == 0 ? Colors.black : Colors.green,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                ),

                Container(height: 5,),
              ],
            )
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
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
                padding: EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 50),
                child: Text(
                  area.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'roboto',
                      color: Colors.black,
                      fontSize: 13
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
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Giờ khởi tạo : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.account.createTime.hour.toString() + ":" + widget.account.createTime.minute.toString() + ":" + widget.account.createTime.second.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              color: Colors.black,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Ngày : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: "Ngày " + widget.account.createTime.day.toString() + "/" + widget.account.createTime.month.toString() + "/" + widget.account.createTime.year.toString(), // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              color: Colors.black,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
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
            width: (width - 20)/6 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  recharge_money_for_shipper(account: widget.account),

                  Container(height: 8,),

                  withdraw_money_for_shipper(account: widget.account),

                  Container(height: 8,),

                  view_shipper_detail(account: widget.account)
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
