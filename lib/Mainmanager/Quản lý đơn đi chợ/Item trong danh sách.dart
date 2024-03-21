import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20%C4%91%C6%A1n%20%C4%91%E1%BB%93%20%C4%83n/foodOrder.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20%C4%91%C6%A1n%20giao%20h%C3%A0ng/Data/T%C3%ADnh%20kho%E1%BA%A3ng%20c%C3%A1ch.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../Quản lý khu vực và tài khoản admin/Area.dart';


class Itemdanhsach extends StatefulWidget {
  final double width;
  final foodOrder order;
  final Color color;
  const Itemdanhsach({Key? key, required this.width, required this.order, required this.color}) : super(key: key);

  @override
  State<Itemdanhsach> createState() => _ItemdanhsachState();
}

class _ItemdanhsachState extends State<Itemdanhsach> {
  final Area area = Area(id: '', name: '', money: 0, status: 0);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData1();
  }

  @override
  Widget build(BuildContext context) {
    String status = '';
    String cartList = '';
    for (int i = 0 ; i < widget.order.productList.length ; i++) {
      cartList = cartList + '+ ' + widget.order.productList[i].name + '\n';
    }

    if (widget.order.status == 'A') {
      status = 'Chờ nhà hàng ' + widget.order.productList[0].owner.name + ' xác nhận';
    }

    if (widget.order.status == 'B') {
      status = 'Nhà hàng ' + widget.order.productList[0].owner.name + ' đã xác nhận , đợi shipper lấy';
    }

    if (widget.order.status == 'C') {
      status = 'Shipper ' + widget.order.shipper.name + ' đã lấy được hàng';
    }

    if (widget.order.status == 'D') {
      status = 'Shipper ' + widget.order.shipper.name + ' đã giao hàng thành công';
    }

    if (widget.order.status == 'E') {
      status = 'Bị hủy bởi khách hàng';
    }

    if (widget.order.status == 'G') {
      status = 'Quán ' + widget.order.productList[0].owner.name + ' hủy xác nhận đơn';
    }

    if (widget.order.status == 'H') {
      status = 'Shipper ' + widget.order.shipper.name + ' đang đến lấy thì nhà hàng hủy';
    }

    return Container(
      width: widget.width,
      height: 190,
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
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.order.id, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
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
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: CaculateDistance.calculateDistance(widget.order.locationSet.Latitude, widget.order.locationSet.Longitude, widget.order.locationGet.Latitude, widget.order.locationGet.Longitude).toStringAsFixed(2).toString() + ' Km',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
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
                            text: 'Tài khoản đặt : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.order.owner.name + ' - ' + widget.order.owner.phoneNum, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
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
                            text: 'Khu vực : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: area.name, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
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
                            text: 'Trạng thái : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: status,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
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
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Điểm lấy hàng: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.order.productList[0].owner.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
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
                              fontFamily: 'arial',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.order.locationGet.firstText + ' , ' + widget.order.locationGet.secondaryText,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'arial',
                              fontWeight: FontWeight.normal,
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
                    child: Text(
                      'Danh sách đơn đi chợ',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'arial',
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold, // Để in đậm
                      ),
                    ),
                  ),

                  Container(height: 3,),

                  Padding(
                    padding: EdgeInsets.only(right: widget.width/20),
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                          color: Colors.deepPurple
                      ),
                    ),
                  ),

                  Container(height: 7,),

                  Container(
                    child: Text(
                      cartList,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'arial',
                        color: Colors.black,
                        fontWeight: FontWeight.normal, // Để in đậm
                      ),
                    ),
                  )
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
                                text: 'Phí ship gốc : ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'arial',
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
                                text: dataCheckManager.getStringNumber(widget.order.shipcost + widget.order.voucher.totalmoney).toString() + '.đ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'arial',
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
                                text: 'Phí ship : ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'arial',
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
                                text: dataCheckManager.getStringNumber(widget.order.shipcost).toString() + '.đ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'arial',
                                  color: Colors.deepOrange,
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
                                text: 'Giá trị đơn : ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'arial',
                                  fontWeight: FontWeight.bold, // Để in đậm
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
                                text: dataCheckManager.getStringNumber(widget.order.cost).toString() + '.đ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'arial',
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.normal, // Để viết bình thường
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
                                text: 'Chiết khấu quán: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'arial',
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
                                text: widget.order.costFee.discount.toString() + '% (' + dataCheckManager.getStringNumber(widget.order.costFee.discount/100 * widget.order.cost).toString() + '.đ)',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'arial',
                                  color: Colors.deepPurple,
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
                                text: 'Chiết khấu ship: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'arial',
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
                                text: widget.order.costBiker.discount.toString() + '% (' + dataCheckManager.getStringNumber(widget.order.costBiker.discount/100 * widget.order.shipcost).toString() + '.đ)',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'arial',
                                  color: Colors.deepPurple,
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
                          text: widget.order.S1time.hour.toString() + ':' + widget.order.S1time.minute.toString(),
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
                          text: 'Ngày ' + widget.order.S1time.day.toString() + '/' + widget.order.S1time.month.toString() + '/' + widget.order.S1time.year.toString(),
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
        ],
      ),
    );
  }
}