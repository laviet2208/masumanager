import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20khu%20v%E1%BB%B1c%20v%C3%A0%20t%C3%A0i%20kho%E1%BA%A3n%20admin/Area.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/mainManager/notice_manager/actions/delete_notice.dart';
import 'package:masumanager/MasuShipManager/mainManager/notice_manager/actions/edit_notice.dart';
import '../../Data/noticeData/noticeData.dart';

class item_notice extends StatefulWidget {
  final noticeData notice;
  final int index;
  const item_notice({super.key, required this.notice, required this.index});

  @override
  State<item_notice> createState() => _item_noticeState();
}

class _item_noticeState extends State<item_notice> {
  Area area = Area(id: '', name: '', money: 0, status: 0);

  void get_data_area() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area/" + widget.notice.area).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      Area a = Area.fromJson(orders);
      area.name = a.name;
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_data_area();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 80;
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
                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Tiêu đề : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.notice.title, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 10,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Tiêu đề phụ : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.notice.sub,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 10,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Nội dung : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.notice.content,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
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
            width: (width - 50)/4 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 15,),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Khu vực : ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'muli',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: area.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'muli',
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(height: 10,),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Đối tượng : ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'muli',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: widget.notice.object == 0 ? 'Thông báo khách hàng' : 'Thông báo shipper',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'muli',
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
            width: (width - 50)/4 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Ngày khởi tạo : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: (widget.notice.create.hour >= 10 ? widget.notice.create.hour.toString() : '0' + widget.notice.create.hour.toString()) + " giờ " + (widget.notice.create.minute >= 10 ? widget.notice.create.minute.toString() : '0' + widget.notice.create.minute.toString()) + ", " + "Ngày " + (widget.notice.create.day >= 10 ? widget.notice.create.day.toString() : '0' + widget.notice.create.day.toString()) + "/" + (widget.notice.create.month >= 10 ? widget.notice.create.month.toString() : '0' + widget.notice.create.month.toString()) + "/" + widget.notice.create.year.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 10,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Gửi lần cuối lúc : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: (widget.notice.send.hour >= 10 ? widget.notice.send.hour.toString() : '0' + widget.notice.send.hour.toString()) + " giờ " + (widget.notice.send.minute >= 10 ? widget.notice.send.minute.toString() : '0' + widget.notice.send.minute.toString()) + ", " + "Ngày " + (widget.notice.send.day >= 10 ? widget.notice.send.day.toString() : '0' + widget.notice.send.day.toString()) + "/" + (widget.notice.send.month >= 10 ? widget.notice.send.month.toString() : '0' + widget.notice.send.month.toString()) + "/" + widget.notice.send.year.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
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
            width: (width - 50)/4 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 10,),

                  GestureDetector(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                              width: 1,
                              color: Colors.black
                          )
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Sửa thông báo',
                        style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return edit_notice(data: widget.notice);
                        },
                      );
                    },
                  ),

                  Container(height: 10,),

                  GestureDetector(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                              width: 1,
                              color: Colors.black
                          )
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Xóa thông báo',
                        style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return delete_notice(data: widget.notice);
                        },
                      );
                    },
                  ),

                  Container(height: 10,),

                  GestureDetector(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                              width: 1,
                              color: Colors.black
                          )
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Đẩy/dừng thông báo',
                        style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
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
        ],
      ),
    );
  }
}
