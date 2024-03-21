import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../Data/areaData/Area.dart';
import '../../../../Data/otherData/Tool.dart';
import '../../../catch_order_manager/action/delete_order/delete_order.dart';
import '../cancel_order.dart';
import '../view_log_buy_request_order/view_log_request_button.dart';

class item_buy_request_order extends StatefulWidget {
  final requestBuyOrder order;
  final int index;
  const item_buy_request_order({Key? key, required this.order, required this.index}) : super(key: key);

  @override
  State<item_buy_request_order> createState() => _item_buy_request_orderState();
}

class _item_buy_request_orderState extends State<item_buy_request_order> {
  String status = '';
  double orderDis = 0;
  double product_total_cost = 0;
  final Area area = Area(id: '', name: '', money: 0, status: 0);

  void getDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) async {
    final url = Uri.parse("https://rsapi.goong.io/DistanceMatrix?origins=$startLatitude,$startLongitude&destinations=$endLatitude,$endLongitude&vehicle=bike&api_key=3u7W0CAOa9hi3SLC6RI3JWfBf6k8uZCSUTCHKOLf");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final distance = data['rows'][0]['elements'][0]['distance']['value'];
        orderDis = distance.toDouble()/1000;
        setState(() {

        });
      } else {
        throw Exception('Lỗi khi gửi yêu cầu tới Goong API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi khi xử lý dữ liệu: $e');
    }
  }

  void getDataArea() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area/" + widget.order.owner.area).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      Area a = Area.fromJson(orders);
      area.name = a.name;
      setState(() {

      });
    });
  }

  void get_total_cost() {
    for(int i = 0; i < widget.order.productList.length; i++) {
      product_total_cost = product_total_cost + (widget.order.productList[i].cost * widget.order.productList[i].number);
      setState(() {

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataArea();
    getDistance(widget.order.locationSet.latitude, widget.order.locationSet.longitude, widget.order.locationGet.latitude, widget.order.locationGet.longitude);
    get_total_cost();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 80;

    if (widget.order.status == 'A') {
      status = 'Chờ đẩy đơn cho shipper';
    }

    if (widget.order.status == 'B') {
      status = 'Đơn đã đẩy cho shipper ' + widget.order.shipper.name;
    }

    if (widget.order.status == 'C') {
      status = 'Shipper đã mua xong hàng';
    }

    if (widget.order.status == 'D') {
      status = 'Đơn được giao thành công';
    }

    if (widget.order.status == 'E') {
      status = 'Bị hủy khi shipper chưa đến';
    }

    if (widget.order.status == 'E1') {
      status = 'Khách không nhận';
    }

    if (widget.order.status == 'E2') {
      status = 'Bị ADMIN hủy đơn';
    }

    return Container(
      width: width,
      height: 190,
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
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: Center(
                child: Text(
                  (widget.index + 1).toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'roboto',
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
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: width/6-1-30,
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
                            text: orderDis.toStringAsFixed(1).toString() + ' Km',
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
                            text: 'Khách hàng: ',
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
                              color: Colors.red,
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
                            text: 'SĐT: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.order.owner.phone, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              color: Colors.red,
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
                              color: Colors.red,
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
                            text: area.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              color: Colors.blueAccent,
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
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: width/6-1,
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
                            text: 'Địa chỉ mua hàng: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.order.locationSet.mainText + ' , ' + widget.order.locationSet.secondaryText, // Phần còn lại viết bình thường
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

                  Container(height: 5,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Địa chỉ giao hàng: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.order.locationGet.mainText + ' , ' + widget.order.locationGet.secondaryText, // Phần còn lại viết bình thường
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
                    child: Padding(
                      padding: EdgeInsets.only(right: 0, left: 0),
                      child: GestureDetector(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Xem chi tiết cửa hàng>>',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontFamily: 'roboto'
                            ),
                          ),
                        ),
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
            width: width/6-1,
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
                                text: 'Phí ship gốc: ',
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
                                text: getStringNumber(widget.order.cost + widget.order.voucher.Money).toString() + ' VNĐ',
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
                                text: 'Phí ship thực : ',
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
                                text: getStringNumber(widget.order.cost).toString() + ' VNĐ',
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
                                text: 'Giá trị hàng hóa : ',
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
                                text: getStringNumber(product_total_cost).toString() + ' VNĐ',
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
                    child: Padding(
                      padding: EdgeInsets.only(right: 0, left: 0),
                      child: GestureDetector(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Xem chi tiết hàng hóa>>',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontFamily: 'roboto'
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(height: 15,),
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
            width: width/6-1,
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
                                text: getStringNumber(widget.order.costFee.departCost).toString() + ' VNĐ',
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
                                text: 'Chiết khấu : ',
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
                                text: widget.order.costFee.discount.toString() + '% (' + getStringNumber(widget.order.costFee.discount/100 * widget.order.cost).toString() + 'VNĐ)',
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
                                text: getStringNumber(widget.order.costFee.perKMcost).toString() + ' VNĐ',
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
            width: width/6-1,
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
                            text: (widget.order.S1time.hour >= 10 ? widget.order.S1time.hour.toString() : '0' + widget.order.S1time.hour.toString()) + ':' + (widget.order.S1time.minute >= 10 ? widget.order.S1time.minute.toString() : '0' + widget.order.S1time.minute.toString()),
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
            width: width/6-1,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  view_log_request_button(order: widget.order),

                  Container(height: 4,),

                  delete_order(id: widget.order.id),

                  Container(height: 4,),

                  cancel_order(id: widget.order.id),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
