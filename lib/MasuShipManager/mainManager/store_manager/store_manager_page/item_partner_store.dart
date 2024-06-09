import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/mainManager/store_manager/actions/partner_store_actions/product_directory_manager/product_directory_manager.dart';
import 'package:masumanager/MasuShipManager/mainManager/store_manager/actions/partner_store_actions/product_manager/product_manager.dart';
import '../../../Data/accountData/shopData/shopAccount.dart';
import '../../../Data/otherData/Tool.dart';
import '../actions/partner_store_actions/edit_actions/edit_location_area.dart';
import '../actions/partner_store_actions/edit_actions/edit_open_close_time.dart';
import '../actions/partner_store_actions/edit_actions/edit_partner_name_phone_pass.dart';
import '../actions/partner_store_actions/edit_actions/lock_unlock_partner.dart';


class item_partner_store extends StatefulWidget {
  final ShopAccount account;
  final int index;
  const item_partner_store({super.key, required this.account, required this.index});

  @override
  State<item_partner_store> createState() => _item_partner_storeState();
}

class _item_partner_storeState extends State<item_partner_store> {
  List<String> type_list = ['Thực phẩm', 'Rau củ', 'Mẹ và bé', 'Gia vị', 'Gia dụng', 'Đồ khô', 'Đồ hộp', 'Trứng sữa', 'Đồ nhậu'];
  String area_name = '';

  void get_area_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").child(widget.account.area).onValue.listen((event) {
      final dynamic area = event.snapshot.value;
      area_name = area['name'].toString();
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_area_data();
    widget.account.openTime.second = 0;
    widget.account.closeTime.second = 0;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    return Container(
      width: width,
      height: 170,
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
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: Center(
                child: Text(
                  (widget.index + 1).toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'muli',
                    color: Colors.black,
                    fontWeight: FontWeight.bold, // Để in đậm
                  ),
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
            width: (width - 50)/5 - 1,
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
                            text: 'Tên shop: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.account.name, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
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
                            text: 'Tài khoản: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.account.phone, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
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
                            text: 'Mật khẩu: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.account.password, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 8,),

                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      child: Text('Cập nhật thông tin', style: TextStyle(color: Colors.blueAccent, fontSize: 14),),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return edit_partner_name_phone_pass(account: widget.account);
                          },
                        );
                      },
                    ),
                  ),

                  Container(height: 10,),
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
            width: (width - 50)/5 - 1,
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
                            text: 'Giờ mở cửa: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),

                          TextSpan(
                            text: getTimeStringType1(widget.account.openTime), // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
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
                            text: 'Giờ đóng cửa: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),

                          TextSpan(
                            text: getTimeStringType1(widget.account.closeTime), // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
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
                            text: 'Thời gian tạo: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),

                          TextSpan(
                            text: getAllTimeString(widget.account.createTime), // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 8,),

                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      child: Text('Cập nhật thời gian', style: TextStyle(color: Colors.blueAccent, fontSize: 14),),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return edit_open_close_time(account: widget.account);
                          },
                        );
                      },
                    ),
                  ),

                  Container(height: 10,),
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
            width: (width - 50)/5 - 1,
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
                            text: 'Địa chỉ: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),

                          TextSpan(
                            text: widget.account.location.mainText + ' ' + widget.account.location.secondaryText, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
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
                            text: 'Thuộc khu vực: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),

                          TextSpan(
                            text: area_name, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 8,),

                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      child: Text('Cập nhật địa chỉ', style: TextStyle(color: Colors.blueAccent, fontSize: 14),),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return edit_location_area(account: widget.account);
                          },
                        );
                      },
                    ),
                  ),

                  Container(height: 10,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 225, 225, 226),
            ),
          ),

          Container(
            width: (width - 50)/5 - 1,
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
                            text: 'Phân loại: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: type_list[widget.account.type], // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
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
                            text: 'T.thái t.khoản: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),

                          TextSpan(
                            text: widget.account.lockStatus == 0 ? 'Đang khóa' : 'Đang mở', // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              color: widget.account.lockStatus == 0 ? Colors.redAccent : Colors.green,
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
                            text: 'T.thái mở cửa: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),

                          TextSpan(
                            text: widget.account.openStatus == 0 ? 'Đang đóng cửa' : 'Đang mở cửa', // Phần còn lại viết bình thường
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'muli',
                                fontWeight: FontWeight.normal,
                                color: widget.account.openStatus == 0 ? Colors.red : Colors.green
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 8,),

                  Container(
                    alignment: Alignment.centerLeft,
                    child: lock_unlock_partner(account: widget.account),
                  ),

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
            width: (width - 50)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 20,),
              child: ListView(
                children: [
                  Container(height: 4,),

                  GestureDetector(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          border: Border.all()
                      ),
                      child: Center(
                        child: Text(
                          'Quản lý danh mục',
                          style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return product_directory_manager(account: widget.account);
                        },
                      );
                    },
                  ),

                  Container(height: 8,),

                  GestureDetector(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all()
                      ),
                      child: Center(
                        child: Text(
                          'Quản lý sản phẩm',
                          style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return product_manager(account: widget.account);
                        },
                      );
                    },
                  ),

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
        ],
      ),
    );
  }
}
