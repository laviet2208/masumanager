import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/mainManager/catch_order_manager/action/delete_order/delete_order.dart';
import 'package:masumanager/MasuShipManager/mainManager/ingredient/text_line_in_item.dart';
import 'package:masumanager/MasuShipManager/mainManager/request_buy_order_manager/ingredient/button/cancel_button/cancel_request_order.dart';
import 'package:masumanager/MasuShipManager/mainManager/request_buy_order_manager/ingredient/view_product_request_in_order/view_product_request_in_order.dart';
import '../../Data/areaData/Area.dart';
import '../../Data/otherData/Tool.dart';
import 'ingredient/button/view_log_button/view_log_request_button.dart';

class item_buy_request_order extends StatefulWidget {
  final requestBuyOrder order;
  final int index;
  const item_buy_request_order({Key? key, required this.order, required this.index}) : super(key: key);

  @override
  State<item_buy_request_order> createState() => _item_buy_request_orderState();
}

class _item_buy_request_orderState extends State<item_buy_request_order> {
  String status = '';
  double product_total_cost = 0;
  final Area area = Area(id: '', name: '', money: 0, status: 0);

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
      status = 'Giao thành công';
    }

    if (widget.order.status == 'E') {
      status = 'Bị khách hủy';
    }

    if (widget.order.status == 'E1') {
      status = 'Khách không nhận';
    }

    if (widget.order.status == 'E2') {
      status = 'Bị Admin hủy đơn';
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
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: (width - 50)/5-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 15,),

                  text_line_in_item(title: 'ID: ', content: widget.order.id),

                  Container(height: 10,),

                  text_line_in_item(title: 'Quãng đường: ', content: getDistanceByCost(widget.order.cost, widget.order.costFee).toStringAsFixed(1).toString() + ' Km'),

                  Container(height: 10,),

                  text_line_in_item(title: 'Khách hàng: ', content: widget.order.owner.name),

                  Container(height: 10,),

                  text_line_in_item(title: 'Sđt: ', content: widget.order.owner.phone),

                  Container(height: 10,),

                  text_line_in_item(title: 'Trạng thái: ', content: status),

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
            width: (width - 50)/5-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 15,),

                  text_line_in_item(title: 'Địa chỉ mua hàng: ', content: widget.order.buyLocation.length.toString() + ' Điểm'),

                  Container(height: 5,),

                  text_line_in_item(title: 'Địa chỉ giao hàng: ', content: widget.order.locationGet.mainText),

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
            width: (width - 50)/5-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 15,),

                  text_line_in_item(title: 'Số lượng sản phẩm: ', content: widget.order.productList.length.toString() + ' Món'),

                  Container(height: 15,),

                  text_line_in_item(title: 'Phụ phí số lượng: ', content: getStringNumber((10000 * ((widget.order.productList.length/3).toInt()).toDouble())) + ' VNĐ'),

                  Container(height: 10,),

                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(right: 0, left: 0),
                      child: GestureDetector(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Xem D.sách hàng hóa',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontFamily: 'muli'
                            ),
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return view_product_request_in_order(order: widget.order);
                            },
                          );
                        },
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
            width: (width - 50)/5-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 15,),

                  text_line_in_item(title: 'Chiết khấu: ', content: widget.order.costFee.discount.toString() + '% (' + getStringNumber(widget.order.costFee.discount/100 * widget.order.cost).toString() + 'VNĐ)'),

                  Container(height: 15,),

                  text_line_in_item(title: 'Phí ship gốc: ', content: getStringNumber(widget.order.cost + getVoucherSale(widget.order.voucher, widget.order.cost)).toString() + ' VNĐ'),

                  Container(height: 15,),

                  text_line_in_item(title: 'Phí ship sau KM: ', content: getStringNumber(widget.order.cost).toString() + ' VNĐ'),

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
            width: (width - 50)/5-1,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  cancel_request_order(order: widget.order),

                  Container(height: 4,),

                  delete_order(id: widget.order.id),

                  Container(height: 4,),

                  view_log_request_button(order: widget.order),

                  Container(height: 4,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
