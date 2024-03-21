import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20%C4%91%C6%A1n%20giao%20h%C3%A0ng/Data/T%C3%ADnh%20kho%E1%BA%A3ng%20c%C3%A1ch.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20%C4%91%C6%A1n%20giao%20h%C3%A0ng/Data/itemsendOrder.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20%C4%91%C6%A1n%20giao%20h%C3%A0ng/Xem%20log%20%C4%91%C6%A1n%20h%C3%A0ng.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';
import 'package:masumanager/utils/utils.dart';

import '../../dataClass/FinalClass.dart';
import '../../dataClass/Lịch sử giao dịch.dart';
import '../../dataClass/Time.dart';
import '../Quản lý khu vực và tài khoản admin/Area.dart';

class Itemdanhsach extends StatefulWidget {
  final double width;
  final itemsendOrder order;
  final Color color;
  const Itemdanhsach({Key? key, required this.width, required this.order, required this.color}) : super(key: key);

  @override
  State<Itemdanhsach> createState() => _ItemdanhsachState();
}

class _ItemdanhsachState extends State<Itemdanhsach> {
  final Area area = Area(id: '', name: '', money: 0, status: 0);

  Time getCurrentTime() {
    DateTime now = DateTime.now();

    Time currentTime = Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0);
    currentTime.second = now.second;
    currentTime.minute = now.minute;
    currentTime.hour = now.hour;
    currentTime.day = now.day;
    currentTime.month = now.month;
    currentTime.year = now.year;

    return currentTime;
  }

  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area/" + widget.order.owner.Area).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      Area a = Area.fromJson(orders);
      area.name = a.name;
      setState(() {

      });
    });
  }

  Future<void> changeStatus(String status) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Order/itemsendOrder/" + widget.order.id + "/status").set(status);
  }

  Future<void> pushData2(String id, double money) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('normalUser/' + id).child('totalMoney').set(money);
      toastMessage('Nạp tiền thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushhistoryData(historyTransaction history) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('historyTransaction').child(history.id).set(history.toJson());
      toastMessage('Thêm lịch sử thành công');
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
    Color statusColor = Colors.black;
    if (widget.order.status == "A") {
      status = "Đang đợi tài xế nhận đơn";
      statusColor = Colors.orange;
    }

    if (widget.order.status == "B") {
      status = "Shipper " + widget.order.shipper.name + " đang tới nhận hàng";
      statusColor = Color.fromARGB(255, 0, 177, 79);
    }

    if (widget.order.status == "C") {
      status = "Shipper " + widget.order.shipper.name + " đang giao tới người nhận";
      statusColor = Color.fromARGB(255, 0, 177, 79);
    }

    if (widget.order.status == "D") {
      status = "Đơn đã được giao tới nơi thành công";
      statusColor = Color.fromARGB(255, 0, 177, 79);
    }

    if (widget.order.status == "E") {
      status = 'Đơn bị hủy bởi người đặt ' + widget.order.owner.name + ' trước khi tài xế nhận';
      statusColor = Colors.redAccent;
    }

    if (widget.order.status == "F") {
      status = 'Đơn bị hủy bởi người đặt ' + widget.order.owner.name;
      statusColor = Colors.redAccent;
    }

    if (widget.order.status == "G") {
      status = 'Bị hủy bởi Shipper ' + widget.order.shipper.name;
      statusColor = Colors.redAccent;
    }

    if (widget.order.status == "H") {
      status = 'Người nhận' + widget.order.owner.name + ' - ' + widget.order.owner.phoneNum + ' không lấy';
      statusColor = Colors.redAccent;
    }

    if (widget.order.status == "H1") {
      status = 'Bị hủy bởi Admin';
      statusColor = Colors.redAccent;
    }

    if (widget.order.status == "H2") {
      status = 'Bị hủy bởi Admin';
      statusColor = Colors.redAccent;
    }

    return Container(
      width: widget.width,
      height: 210,
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
            width: widget.width/6-1,
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
                            text: 'Mã đơn: ',
                            style: TextStyle(
                              fontSize: 16, 
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.order.id, // Phần còn lại viết bình thường
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

                  Container(height: 10,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Khoảng cách : ',
                            style: TextStyle(
                              fontSize: 16, 
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: CaculateDistance.calculateDistance(widget.order.locationset.Latitude, widget.order.locationset.Longitude, widget.order.receiver.location.Latitude, widget.order.receiver.location.Longitude).toStringAsFixed(2).toString() + ' Km', // Phần còn lại viết bình thường
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

                  Container(height: 10,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Khu vực : ',
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
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold, // Để viết bình thường
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
                            text: 'Tài khoản : ',
                            style: TextStyle(
                              fontSize: 16, 
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.order.owner.name, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold, // Để viết bình thường
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
                            text: 'Số điện thoại : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: (widget.order.owner.phoneNum[0] == '0') ? widget.order.owner.phoneNum : ('0' + widget.order.owner.phoneNum), // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold, // Để viết bình thường
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
                            text: 'Trạng thái : ',
                            style: TextStyle(
                              fontSize: 16, 
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: status, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              color: statusColor,
                              fontWeight: FontWeight.bold, // Để viết bình thường
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
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: widget.width/6-1,
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
                            text: 'Điểm lấy hàng: ',
                            style: TextStyle(
                              fontSize: 16, 
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.order.locationset.firstText + ' , ' + widget.order.locationset.secondaryText, // Phần còn lại viết bình thường
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
                            text: 'Điểm giao hàng: ',
                            style: TextStyle(
                              fontSize: 16, 
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.order.receiver.location.firstText + ' , ' + widget.order.receiver.location.secondaryText, // Phần còn lại viết bình thường
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
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: widget.width/6-1,
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
                                text: 'Khối lượng: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'roboto',
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
                                text: widget.order.itemdetails.weight.toString() + ' Kg',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'roboto',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

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
                                text: 'Phí thu hộ: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'roboto',
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
                                text: dataCheckManager.getStringNumber(widget.order.itemdetails.codFee.toDouble()).toString() + ' VNĐ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'roboto',
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
                                text: 'Phí ship : ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'roboto',
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
                                text: dataCheckManager.getStringNumber(widget.order.cost).toString() + ' VNĐ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'roboto',
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
                                text: 'Phí ship gốc : ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'roboto',
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
                                text: dataCheckManager.getStringNumber(widget.order.cost + widget.order.voucher.totalmoney).toString() + '.đ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'roboto',
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
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: widget.width/6-1,
            alignment: Alignment.center,
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
                                text: 'Chiết khấu ship: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'roboto',
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
                                text: widget.order.costFee.discount.toString() + '% (' + dataCheckManager.getStringNumber(widget.order.costFee.discount/100 * widget.order.cost).toString() + 'đ)',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'roboto',
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
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
                                text: 'Phí đề pa : ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'roboto',
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
                                text: dataCheckManager.getStringNumber(widget.order.costFee.departCost).toString() + ' Vnđ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'roboto',
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
                                text: 'Số km đề pa : ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'roboto',
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
                                text: widget.order.costFee.departKM.toString() + ' Km',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'roboto',
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
                                text: 'Phí mỗi km : ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'roboto',
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
                                text: dataCheckManager.getStringNumber(widget.order.costFee.perKMcost).toString() + ' Vnđ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'roboto',
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
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: widget.width/6-1,
            alignment: Alignment.center,
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
                            text: 'Thời gian tạo : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: ((widget.order. S1time.hour < 10) ? '0' + widget.order. S1time.hour.toString() : widget.order. S1time.hour.toString()) + ':' + ((widget.order. S1time.minute < 10) ? '0' + widget.order. S1time.minute.toString() : widget.order. S1time.minute.toString()),
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
                            text: 'Ngày tạo đơn : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: 'Ngày ' + (widget.order.S1time.day >= 10 ? widget.order.S1time.day.toString() : '0' + widget.order.S1time.day.toString()) + '/' + (widget.order.S1time.month >= 10 ? widget.order.S1time.month.toString() : '0' + widget.order.S1time.month.toString()) + '/' + widget.order.S1time.year.toString(),
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
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: widget.width/6-1,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 15,),

                  GestureDetector(
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Hủy đơn hàng',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.white
                        ),
                      ),
                    ),
                    onTap:() async {
                      if (widget.order.status == 'D' || widget.order.status == 'E' || widget.order.status == 'F' || widget.order.status == 'G' || widget.order.status == 'H' || widget.order.status == 'H1' || widget.order.status == 'H2') {
                        toastMessage('Đơn bị hủy rồi');
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Xác nhận'),
                                content: Text('Bạn có chắc chắn hủy đơn này không'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Không', style: TextStyle(color: Colors.redAccent),),
                                  ),

                                  TextButton(
                                    onPressed: () async {
                                      if (widget.order.status == 'A') {
                                        await changeStatus('H1');
                                        toastMessage('Bạn đã hủy đơn');
                                        Navigator.of(context).pop();
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Xác nhận hoàn tiền'),
                                              content: Text('Bạn có muốn hoàn chiết khấu cho tài khoản này không'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () async {
                                                    await changeStatus('H1');
                                                    toastMessage('Bạn đã hủy đơn');
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Không', style: TextStyle(color: Colors.redAccent),),
                                                ),

                                                TextButton(
                                                  onPressed: () async {
                                                    historyTransaction his = historyTransaction(id: dataCheckManager.generateRandomString(10), senderId: '', receiverId: widget.order.shipper.id, transactionTime: getCurrentTime(), type: 6, content: widget.order.id, money: (widget.order.cost * widget.order.costFee.discount)/100, area: currentAccount.provinceCode);
                                                    await pushData2(widget.order.shipper.id, widget.order.shipper.totalMoney);
                                                    toastMessage('Đã cộng tiền tài xế');
                                                    await pushhistoryData(his);
                                                    toastMessage('Đẩy lịch sử thành công');
                                                    await changeStatus('H1');
                                                    toastMessage('Bạn đã hủy đơn');
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Đồng ý', style: TextStyle(color: Colors.blueAccent),),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: Text('Đồng ý' , style: TextStyle(color: Colors.blueAccent),),
                                  )
                                ],
                              );
                            }
                        );
                      }

                    },
                  ),

                  Container(height: 15,),

                  GestureDetector(
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: Colors.redAccent
                        )
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Xem log đơn',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.redAccent
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Container(
                                width: 500,
                                height: 400,
                                child: ViewLogItemSend(screenWidth: 500, thiscatch: widget.order),
                              ),
                            );
                          }
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
