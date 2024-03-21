import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../Quản lý khu vực và tài khoản admin/Area.dart';
import 'accountNormal.dart';

class ITEMdanhsachkhachhang extends StatefulWidget {
  final double width;
  final double height;
  final accountNormal account;
  final VoidCallback onTapUpdate;
  final Color color;
  const ITEMdanhsachkhachhang({Key? key, required this.width, required this.height, required this.account, required this.onTapUpdate, required this.color}) : super(key: key);

  @override
  State<ITEMdanhsachkhachhang> createState() => _ITEMdanhsachkhachhangState();
}

class _ITEMdanhsachkhachhangState extends State<ITEMdanhsachkhachhang> {
  final Area area = Area(id: '', name: '', money: 0, status: 0);
  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area/" + widget.account.Area).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      Area a = Area.fromJson(orders);
      area.name = a.name;
      area.id = a.id;
      setState(() {

      });
    });
  }

  Future<void> pushData(int data) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('normalUser/' + widget.account.id + '/status').set(data);
      toastMessage('Thay đổi trạng thái thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushData1(int data) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('normalUser/' + widget.account.id + '/status').set(data);
      toastMessage('Thay đổi trạng thái thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData1();
  }


@override
Widget build(BuildContext context) {
  String status = '';
  Color statuscolor = Colors.green;
  if (widget.account.status == 1) {
    status = 'Đang kích hoạt';
  } else {
    status = 'Đang khóa';
    statuscolor = Colors.red;
  }

  return Container(
    width: widget.width,
    height: widget.height,
    decoration: BoxDecoration(
        color: widget.color,
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
          width: (widget.width - 20)/6 - 1,
          height: widget.height,
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: ListView(
              children: [
                Container(height: 15,),

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
                          text: (widget.account.phoneNum == '0') ? widget.account.phoneNum : ('0' + widget.account.phoneNum), // Phần còn lại viết bình thường
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

                Container(height: 15,),

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
                            color: Colors.purple,
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
          width: (widget.width - 20)/6 - 1,
          child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
            child: ListView(
              children: [
                Container(height: 15,),

                Container(
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Vị trí hiện tại : ',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.bold, // Để in đậm
                          ),
                        ),
                        TextSpan(
                          text: widget.account.locationHis.firstText + " " + widget.account.locationHis.secondaryText, // Phần còn lại viết bình thường
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'roboto',
                            color: Colors.purple,
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
          width: (widget.width - 20)/6 - 1,
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                    color: (widget.account.status == 1) ? Colors.green.withOpacity(0.1) : Colors.redAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: (widget.account.status == 1) ? Colors.green.withOpacity(1) : Colors.redAccent.withOpacity(1),
                      width: 1
                    )
                ),
                alignment: Alignment.center,
                child: Text(
                  (widget.account.status == 1) ? 'Đang kích hoạt' : 'Đã bị khóa',
                  style: TextStyle(
                      fontFamily: 'roboto',
                      fontSize: 14,
                      color:  (widget.account.status == 1) ? Colors.green.withOpacity(1) : Colors.redAccent.withOpacity(1),
                      fontWeight: FontWeight.bold
                  ),
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
          height: widget.height,
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: ListView(
              children: [
                Container(height: 15,),

                Container(
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Tên khu vực : ',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.bold, // Để in đậm
                          ),
                        ),
                        TextSpan(
                          text: area.name, // Phần còn lại viết bình thường
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'roboto',
                            color: Colors.purple,
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
          width: (widget.width - 20)/6 - 1,
          height: widget.height,
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
                          text: widget.account.createTime.hour.toString() + ":" + (widget.account.createTime.minute < 10 ? '0' + widget.account.createTime.minute.toString() : widget.account.createTime.minute.toString()) + ":" + (widget.account.createTime.second < 10 ? '0' + widget.account.createTime.second.toString() : widget.account.createTime.second.toString()),
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
          width: (widget.width - 20)/6 - 1,
          child: ListView(
            children: [
              Container(height: 10,),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                  child: GestureDetector(
                    child: Container(
                      width: ((widget.width - 20)/6 - 30)/2,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.redAccent ,
                              width: 1
                          ),
                          borderRadius: BorderRadius.circular(0)
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Khóa/Mở tài khoản',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                            color: Colors.redAccent
                        ),
                      ),
                    ),
                    onTap: () async {
                      if (widget.account.status == 1) {
                        await pushData(2);
                      } else {
                        await pushData(1);
                      }
                    },
                  )
              ),

              Container(height: 10,),

              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: GestureDetector(
                    child: Container(
                      width: ((widget.width - 20)/6 - 30)/2,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          border: Border.all(
                              color: Colors.redAccent,
                              width: 1
                          ),
                          borderRadius: BorderRadius.circular(0)
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Cập nhật',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                            color: Colors.white
                        ),
                      ),
                    ),
                    onTap: widget.onTapUpdate,
                  )
              ),

            ],
          ),
        ),
      ],
    ),
  );
}
}

