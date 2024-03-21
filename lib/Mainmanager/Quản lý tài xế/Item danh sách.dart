import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/FinalClass.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../dataClass/Lịch sử giao dịch.dart';
import '../../dataClass/Time.dart';
import '../../utils/utils.dart';
import '../Quản lý khu vực và tài khoản admin/Area.dart';
import '../Quản lý khách hàng/accountNormal.dart';

class ITEMdanhsachtaixe extends StatefulWidget {
  final double width;
  final double height;
  final int index;
  final accountNormal account;
  final VoidCallback onTapUpdate;
  const ITEMdanhsachtaixe({Key? key, required this.width, required this.height, required this.account, required this.onTapUpdate, required this.index}) : super(key: key);

  @override
  State<ITEMdanhsachtaixe> createState() => _ITEMdanhsachkhachhangState();
}

class _ITEMdanhsachkhachhangState extends State<ITEMdanhsachtaixe> {
  final moneyControl = TextEditingController();
  final noidungcontrol = TextEditingController();
  bool loading = false;
  final Area area = Area(id: '', name: '', money: 0, status: 0);

  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area/" + widget.account.Area).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      Area a = Area.fromJson(orders);
      area.name = a.name;
      area.money = a.money;
      area.id = a.id;
      setState(() {

      });
    });
  }

  Future<void> pushData2(accountNormal account, double money) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('normalUser/' + account.id).child('totalMoney').set(money);
      setState(() {
        loading = false;
      });
      toastMessage('Nạp tiền thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushDataAdmin(String id, double money) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Area/' + id).child('money').set(money);
      setState(() {
        loading = false;
      });
      toastMessage('Đã trừ tiền admin thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushhistoryData(historyTransaction history) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('historyTransaction').child(history.id).set(history.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Thêm lịch sử thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
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

  GestureDetector getButton(String text, Color backgroundColor, Color borderColor, Color TextColor, double borderRadius, VoidCallback event) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: backgroundColor,
            border: Border.all(
                width: 1,
                color: borderColor
            )
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'roboto',
              color: TextColor,
              fontSize: 13
          ),
        ),
      ),
      onTap: event,
    );
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
          color: Colors.white,
          border: Border.all(
              color: Colors.grey,
              width: 1
          )
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 29,
            alignment: Alignment.center,
            child: Text(
              widget.index.toString(),
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
            width: (widget.width - 20)/6 - 1 - 29,
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
                            text: dataCheckManager.getStringNumber(widget.account.totalMoney)+'đ', // Phần còn lại viết bình thường
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
            width: (widget.width - 20)/6 - 1 - 100,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                  color: statuscolor,
                  borderRadius: BorderRadius.circular(10)
                ),
                alignment: Alignment.center,
                child: Text(
                  (widget.account.status == 1) ? 'Đang kích hoạt' : 'Đã bị khóa',
                  style: TextStyle(
                    fontFamily: 'roboto',
                    fontSize: 14,
                    color:  Colors.black,
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
            width: 160,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                      color: (widget.account.WorkStatus == 0) ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    (widget.account.WorkStatus == 0) ? 'Offline' : 'Online',
                    style: TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 14,
                        color:  Colors.black,
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
            width: (widget.width - 20)/6 - 1 - 60,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 50),
                child: AutoSizeText(
                  area.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
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
            width: (widget.width - 20)/6 - 1,
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
            width: (widget.width - 20)/6 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0, // Khoảng cách giữa các item theo chiều ngang
                    mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng theo chiều dọc
                    childAspectRatio: 4.2
                ),
                itemCount: 5, // Số lượng item trong danh sách của bạn
                itemBuilder: (BuildContext context, int index) {
                  if (index == 1) {
                    return getButton('Khóa/mở', Colors.white, Colors.black, Colors.black, 0 ,() async {
                      if (widget.account.status == 1) {
                        await pushData(2);
                      } else {
                        await pushData(1);
                      }
                    },);
                  }
                  if (index == 3) {
                    return getButton('Trừ tiền', Colors.red, Colors.red, Colors.white,0,
                          () async {
                        showDialog (
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Trừ tiền tài xế'),
                              content: Container(
                                width: widget.width * (1.5/3), // Đặt kích thước chiều rộng theo ý muốn
                                height: 170, // Đặt kích thước chiều cao theo ý muốn
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2), // màu của shadow
                                      spreadRadius: 5, // bán kính của shadow
                                      blurRadius: 7, // độ mờ của shadow
                                      offset: Offset(0, 3), // vị trí của shadow
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
                                        'Số tiền cần trừ *',
                                        style: TextStyle(
                                            fontFamily: 'roboto',
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
                                                controller: moneyControl,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: 'roboto',
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Nhập số tiền cần trừ',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontFamily: 'roboto',
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
                                        'Nội dung trừ tiền *',
                                        style: TextStyle(
                                            fontFamily: 'roboto',
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
                                                  fontFamily: 'roboto',
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Nội dung trừ tiền',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontFamily: 'roboto',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                    ),

                                    Container(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Hủy'),
                                  onPressed: () {
                                    moneyControl.clear();
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: loading ? CircularProgressIndicator() : Text('Lưu'),
                                  onPressed: loading ? null : () async {
                                    setState(() {
                                      loading = true;
                                    });

                                    if (moneyControl.text.isNotEmpty && noidungcontrol.text.isNotEmpty) {
                                      if (dataCheckManager.containsOnlyDigits(moneyControl.text.toString())) {
                                        if (int.parse(moneyControl.text.toString()) > 0) {
                                          double newmoney = widget.account.totalMoney - double.parse(moneyControl.text.toString());
                                          double newAreaMoney = area.money + double.parse(moneyControl.text.toString());
                                          historyTransaction history = historyTransaction(
                                              id: dataCheckManager.generateRandomString(25),
                                              senderId: currentAccount.username,
                                              receiverId: widget.account.id,
                                              transactionTime: Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year),
                                              type: 2,
                                              content: noidungcontrol.text.toString(),
                                              money: double.parse(moneyControl.text.toString()),
                                              area: widget.account.Area,
                                          );
                                            await pushData2(widget.account, newmoney);
                                            await pushhistoryData(history);
                                            await pushDataAdmin(area.id, newAreaMoney);
                                            moneyControl.clear();
                                            Navigator.of(context).pop();
                                        } else {
                                          toastMessage('Phải nhập số lớn hơn 0');
                                          setState(() {
                                            loading = false;
                                          });
                                        }
                                      } else {
                                        toastMessage('Phải nhập đúng định dạng');
                                        setState(() {
                                          loading = false;
                                        });
                                      }

                                    } else {
                                      toastMessage('Phải nhập đủ thông tin');
                                      setState(() {
                                        loading = false;
                                      });
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  }
                  if (index == 2) {
                    return getButton('Nạp tiền', Colors.white, Colors.red, Colors.red,0,
                          () async {
                            showDialog (
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Nạp tiền tài xế'),
                                  content: Container(
                                    width: widget.width * (1.5/3), // Đặt kích thước chiều rộng theo ý muốn
                                    height: 170, // Đặt kích thước chiều cao theo ý muốn
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2), // màu của shadow
                                          spreadRadius: 5, // bán kính của shadow
                                          blurRadius: 7, // độ mờ của shadow
                                          offset: Offset(0, 3), // vị trí của shadow
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
                                            'Số tiền cần nạp *',
                                            style: TextStyle(
                                                fontFamily: 'roboto',
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
                                                    controller: moneyControl,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'roboto',
                                                    ),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: 'Số tiền cần nạp',
                                                      hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16,
                                                        fontFamily: 'roboto',
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
                                            'Nội dung nạp tiền *',
                                            style: TextStyle(
                                                fontFamily: 'roboto',
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
                                                      fontFamily: 'roboto',
                                                    ),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: 'Nội dung nạp tiền',
                                                      hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16,
                                                        fontFamily: 'roboto',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                        ),

                                        Container(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Hủy'),
                                      onPressed: () {
                                        moneyControl.clear();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: loading ? CircularProgressIndicator() : Text('Lưu'),
                                      onPressed: loading ? null : () async {
                                        setState(() {
                                          loading = true;
                                        });

                                        if (moneyControl.text.isNotEmpty && noidungcontrol.text.isNotEmpty) {
                                          if (dataCheckManager.containsOnlyDigits(moneyControl.text.toString())) {
                                            if (int.parse(moneyControl.text.toString()) > 0) {
                                              double newmoney = widget.account.totalMoney + double.parse(moneyControl.text.toString());
                                              double newAreaMoney = area.money - double.parse(moneyControl.text.toString());
                                              historyTransaction history = historyTransaction(
                                                  id: dataCheckManager.generateRandomString(25),
                                                  senderId: currentAccount.username,
                                                  receiverId: widget.account.id,
                                                  transactionTime: Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year),
                                                  type: 1,
                                                  content: noidungcontrol.text.toString(),
                                                  money: double.parse(moneyControl.text.toString()),
                                                  area: widget.account.Area,
                                              );
                                              if (area.money >= double.parse(moneyControl.text.toString())) {
                                                await pushData2(widget.account, newmoney);
                                                await pushhistoryData(history);
                                                await pushDataAdmin(area.id, newAreaMoney);
                                                moneyControl.clear();
                                                Navigator.of(context).pop();
                                              } else {
                                                toastMessage('Số tiền khu vực bé hơn số muốn nạp');
                                              }
                                            } else {
                                              toastMessage('Phải nhập số lớn hơn 0');
                                              setState(() {
                                                loading = false;
                                              });
                                            }
                                          } else {
                                            toastMessage('Phải nhập đúng định dạng');
                                            setState(() {
                                              loading = false;
                                            });
                                          }

                                        } else {
                                          toastMessage('Phải nhập đủ thông tin');
                                          setState(() {
                                            loading = false;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                      },
                    );
                  }
                  if (index == 4) {
                    return getButton('Lịch sử GD', Colors.red, Colors.red, Colors.white,0,
                          () async {

                          },
                    );
                  }
                  return getButton('Cập nhật', Colors.red, Colors.red, Colors.white,0, widget.onTapUpdate);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

