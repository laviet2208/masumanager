import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20th%C3%B4ng%20b%C3%A1o/Notification.dart';
import 'package:masumanager/dataClass/FinalClass.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../dataClass/Time.dart';
import '../../dataClass/accountShop.dart';
import '../../utils/utils.dart';
import '../Quản lý khu vực và tài khoản admin/Area.dart';
import '../Quản lý khu vực và tài khoản admin/Tài khoản admin khu vực/Page tìm kiếm.dart';
import 'Droplistnguoinhan.dart';

class Itemdanhsachtb extends StatefulWidget {
  final double width;
  final notification notice;
  final Color color;
  const Itemdanhsachtb({Key? key, required this.width, required this.notice, required this.color}) : super(key: key);

  @override
  State<Itemdanhsachtb> createState() => _ItemdanhsachState();
}

class _ItemdanhsachState extends State<Itemdanhsachtb> {
  bool loading = false;
  final accountShop shop = accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '', OpenStatus: 0);
  final tieudecontrol = TextEditingController();
  final tieudephucontrol = TextEditingController();
  final noidungcontrol = TextEditingController();
  List<Area> areaList = [];
  final Area area = Area(id: '', name: '', money: 0, status: 0);
  final Area area1 = Area(id: '', name: '', money: 0, status: 0);
  String type = '';
  String status = 'Dừng thông báo';
  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area/" + widget.notice.Area).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      Area a = Area.fromJson(orders);
      area.name = a.name;
      setState(() {

      });
    });
  }

  void getData2() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").onValue.listen((event) {
      areaList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Area area= Area.fromJson(value);
        areaList.add(area);
      });
      setState(() {

      });
    });
  }

  Future<void> deleteNoti() async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Notification/' + widget.notice.id).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi xóa');
      throw error;
    }
  }

  Future<void> pushData(int type) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Notification/' + widget.notice.id + '/status').set(type);
      toastMessage('Đẩy/thu hồi thành công');
      if (widget.notice.status == 1) {
        status = 'Đẩy thông báo';
      }
      if (widget.notice.status == 2) {
        status = 'Dừng thông báo';
      }
      setState(() {

      });
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy');
      throw error;
    }
  }

  Future<void> pushData3(notification notification) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Notification').child(notification.id).set(notification.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Sửa thông báo thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushData1() async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Notification/' + widget.notice.id + '/send').set(Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year).toJson());
      toastMessage('Chuyển thời gian thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData1();
    getData2();
    tieudecontrol.text = widget.notice.Title;
    tieudephucontrol.text = widget.notice.Sub;
    noidungcontrol.text = widget.notice.Content;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.notice.object == 0) {
      type = 'Khách hàng bình thường';
    }
    if (widget.notice.object == 1) {
      type = 'Nhân viên shipper';
    }
    if (widget.notice.object == 2) {
      type = 'Nhà hàng , siêu thị';
    }

    if (widget.notice.status == 1) {
      status = 'Đẩy thông báo';
    }
    if (widget.notice.status == 2) {
      status = 'Dừng thông báo';
    }

    return Container(
      width: widget.width,
      height: 120,
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
            width: widget.width/4-1,
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
                            text: 'Tiêu đề : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.notice.Title, // Phần còn lại viết bình thường
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
                            text: widget.notice.Sub,
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
                            text: widget.notice.Content,
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
            width: widget.width/4-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
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
                                text: type,
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
            width: widget.width/4-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
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
                                text: 'Ngày khởi tạo : ',
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
                                text: 'Gửi lần cuối lúc : ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'muli',
                                  color: Colors.black,
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
            width: widget.width/4-1,
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ListView(
                children: [
                  Container(height: 15,),

                  GestureDetector(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(0),

                      ),
                      alignment: Alignment.center,
                      child: Text(
                        status,
                        style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.white
                        ),
                      ),
                    ),
                    onTap: () async {
                      if (widget.notice.status == 1) {
                        await pushData(2);
                        await pushData1();
                      } else {
                        await pushData(1);
                      }
                    },
                  ),

                  Container(height: 7,),

                  GestureDetector(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(
                          width: 1,
                          color: Colors.redAccent
                        )
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Xóa thông báo',
                        style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.redAccent
                        ),
                      ),
                    ),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Xác nhận xóa thông báo',),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () async {
                                  await deleteNoti();
                                  Navigator.of(context).pop();
                                },
                                child: Text('Xác nhận', style: TextStyle(color: Colors.redAccent)),
                              ),

                              TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Hủy', style: TextStyle(color: Colors.black)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),

                  Container(height: 7,),

                  GestureDetector(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                              width: 1,
                              color: Colors.redAccent
                          )
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Sửa thông báo',
                        style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.redAccent
                        ),
                      ),
                    ),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text('Thêm thông báo mới'),
                              content: Container(
                                width: widget.width * (1.5/3),
                                height: 400,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ListView(
                                  children: [
                                    Container(
                                      height: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Tiêu đề thông báo *',
                                        style: TextStyle(
                                            fontFamily: 'muli',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent
                                        ),
                                      ),
                                    ),

                                    Container(
                                      height: 10,
                                    ),

                                    Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10),
                                        child: Container(
                                          height: 50,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.3),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.black,
                                              )
                                          ),

                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Form(
                                              child: TextFormField(
                                                controller: tieudecontrol,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: 'muli',
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Tiêu đề thông báo',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontFamily: 'muli',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                    ),

                                    Container(
                                      height: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Tiêu đề phụ thông báo *',
                                        style: TextStyle(
                                            fontFamily: 'muli',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent
                                        ),
                                      ),
                                    ),

                                    Container(
                                      height: 10,
                                    ),

                                    Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10),
                                        child: Container(
                                          height: 50,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.3),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.black,
                                              )
                                          ),

                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Form(
                                              child: TextFormField(
                                                controller: tieudephucontrol,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: 'muli',
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Tiêu đề thông báo',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontFamily: 'muli',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                    ),

                                    Container(
                                      height: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Nội dung thông báo *',
                                        style: TextStyle(
                                            fontFamily: 'muli',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent
                                        ),
                                      ),
                                    ),

                                    Container(
                                      height: 10,
                                    ),

                                    Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10),
                                        child: Container(
                                          height: 50,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.3),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.black,
                                              )
                                          ),

                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Form(
                                              child: TextFormField(
                                                controller: noidungcontrol,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: 'muli',
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Nội dung thông báo',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontFamily: 'muli',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                    ),

                                    Container(
                                      height: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Chọn loại người nhận *',
                                        style: TextStyle(
                                            fontFamily: 'muli',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent
                                        ),
                                      ),
                                    ),

                                    Container(
                                      height: 10,
                                    ),

                                    Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10),
                                        child: Droplistnguoinhan(width: widget.width * (1.5/3), shop: shop)
                                    ),

                                    Container(
                                      height: currentAccount.provinceCode == '0' ? 10 : 0,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Chọn khu vực quản lý *',
                                        style: TextStyle(
                                            fontFamily: 'muli',
                                            fontSize: currentAccount.provinceCode == '0' ? 14 : 0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent
                                        ),
                                      ),
                                    ),

                                    Container(
                                      height: currentAccount.provinceCode == '0' ? 10 : 0,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: Container(
                                        height: currentAccount.provinceCode == '0' ? 150 : 0,
                                        child: searchPageArea(list: areaList, area: area1,),
                                      ),

                                    ),

                                    Container(
                                      height: 40,
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Hủy'),
                                  onPressed: () {
                                    tieudecontrol.clear();
                                    noidungcontrol.clear();
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: loading ? CircularProgressIndicator() : Text('Lưu'),
                                  onPressed: loading ? null : () async {
                                    setState(() {
                                      loading = true;
                                    });

                                    if (tieudecontrol.text.isNotEmpty && noidungcontrol.text.isNotEmpty && (area1.id != '' || currentAccount.provinceCode != '0')) {
                                      notification noti = notification(
                                          id: widget.notice.id,
                                          Area: currentAccount.provinceCode == '0' ? area1.id : currentAccount.provinceCode,
                                          Title: tieudecontrol.text.toString(),
                                          Sub: tieudephucontrol.text.toString(),
                                          object: widget.notice.object,
                                          create: Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year),
                                          send: widget.notice.send,
                                          status: 1,
                                          Content: noidungcontrol.text.toString()
                                      );
                                      await pushData3(noti);
                                      setState(() {
                                        loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
                                      });
                                      Navigator.of(context).pop();
                                    } else {
                                      toastMessage('Phải nhập đủ thông tin');
                                      setState(() {
                                        loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
                                      });
                                    }
                                  },
                                ),
                              ]
                          );
                        },
                      );
                    },
                  ),

                  Container(height: 20,),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
