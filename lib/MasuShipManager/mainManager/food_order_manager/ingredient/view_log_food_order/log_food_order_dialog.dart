import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../Data/OrderData/foodOrder/foodOrder.dart';
import '../../../../Data/otherData/Tool.dart';

class log_food_order_dialog extends StatefulWidget {
  final foodOrder order;
  const log_food_order_dialog({super.key, required this.order});

  @override
  State<log_food_order_dialog> createState() => _log_food_order_dialogState();
}

class _log_food_order_dialogState extends State<log_food_order_dialog> {
  String finalStatus = '';
  @override
  Widget build(BuildContext context) {
    double screenWidth = 500;
    if (widget.order.status == "F") {
      finalStatus = "Đơn hàng hoàn tất";
    }
    if (widget.order.status == "G") {
      finalStatus = 'Nhà hàng không xác nhận';
    }
    if (widget.order.status == "G1") {
      finalStatus = 'Khách không xác nhận';
    }
    if (widget.order.status == "G2") {
      finalStatus = 'Khách hủy đơn';
    }
    if (widget.order.status == "G3") {
      finalStatus = 'Bị hủy bởi admin';
    }
    if (widget.order.status == "G4") {
      finalStatus = 'Khách bom hàng';
    }
    return ListView(
      children: [
        Container(height: 10,),

        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Container(
            height: 30,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 6, bottom: 6),
              child: AutoSizeText(
                'Xem log đơn',
                style: TextStyle(
                    fontFamily: 'muli',
                    color: Colors.black,
                    fontSize: 200,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),

        Container(height: 10,),

        Container(
          height: 30,
          child: Row(
            children: [
              Container(
                width: 10,
              ),

              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (widget.order.status == 'A') ? AssetImage('assets/image/redcircle.png') : AssetImage('assets/image/greycircle.png')
                    )
                ),
              ),

              Container(
                width: 10,
              ),

              Padding(
                padding: EdgeInsets.only(top: 7, bottom: 7),
                child: Container(
                  width: screenWidth - 40 - 30 - 30,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          height: 16,
                          width: screenWidth - 40 - 30 - 30,
                          child: AutoSizeText(
                            'Đang đợi đẩy đơn shipper',
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 200,
                                fontWeight: (widget.order.status == 'A') ?  FontWeight.bold : FontWeight.normal
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 16,
                          width: screenWidth - 40 - 30 - 30,
                          alignment: Alignment.centerRight,
                          child: AutoSizeText(
                            getAllTimeString(widget.order.timeList[0]),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 200,
                                fontWeight: (widget.order.status == 'A') ?  FontWeight.bold : FontWeight.normal
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                width: 10,
              ),


            ],
          ),
        ),

        Container(
          height: 20,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 25, top: 4, bottom: 4),
            child: Container(
              alignment: Alignment.centerLeft,
              width: 1,
              decoration: BoxDecoration(
                  color: Colors.grey
              ),
            ),
          ),
        ),

        Container(
          height: 30,
          child: Row(
            children: [
              Container(
                width: 10,
              ),

              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (widget.order.status == 'B') ? AssetImage('assets/image/redcircle.png') : AssetImage('assets/image/greycircle.png')
                    )
                ),
              ),

              Container(
                width: 10,
              ),

              Padding(
                padding: EdgeInsets.only(top: 7, bottom: 7),
                child: Container(
                  width: screenWidth - 40 - 30 - 30,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          height: 16,
                          width: screenWidth - 40 - 30 - 30,
                          child: AutoSizeText(
                            'Đã đẩy đơn cho shipper',
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 200,
                                fontWeight: (widget.order.status == 'A') ?  FontWeight.bold : FontWeight.normal
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 16,
                          width: screenWidth - 40 - 30 - 30,
                          alignment: Alignment.centerRight,
                          child: AutoSizeText(
                            getAllTimeString(widget.order.timeList[1]),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 200,
                                fontWeight: (widget.order.status == 'A') ?  FontWeight.bold : FontWeight.normal
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                width: 10,
              ),


            ],
          ),
        ),

        Container(
          height: 20,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 25, top: 4, bottom: 4),
            child: Container(
              alignment: Alignment.centerLeft,
              width: 1,
              decoration: BoxDecoration(
                  color: Colors.grey
              ),
            ),
          ),
        ),

        Container(
          height: 30,
          child: Row(
            children: [
              Container(
                width: 10,
              ),

              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (widget.order.status == 'C') ? AssetImage('assets/image/redcircle.png') : AssetImage('assets/image/greycircle.png')
                    )
                ),
              ),

              Container(
                width: 10,
              ),

              Padding(
                padding: EdgeInsets.only(top: 7, bottom: 7),
                child: Container(
                  width: screenWidth - 40 - 30 - 30,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          height: 16,
                          width: screenWidth - 40 - 30 - 30,
                          child: AutoSizeText(
                            'Shipper đã xác nhận với khách',
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 200,
                                fontWeight: (widget.order.status == 'A') ?  FontWeight.bold : FontWeight.normal
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 16,
                          width: screenWidth - 40 - 30 - 30,
                          alignment: Alignment.centerRight,
                          child: AutoSizeText(
                            getAllTimeString(widget.order.timeList[2]),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 200,
                                fontWeight: (widget.order.status == 'A') ?  FontWeight.bold : FontWeight.normal
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                width: 10,
              ),


            ],
          ),
        ),

        Container(
          height: 20,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 25, top: 4, bottom: 4),
            child: Container(
              alignment: Alignment.centerLeft,
              width: 1,
              decoration: BoxDecoration(
                  color: Colors.grey
              ),
            ),
          ),
        ),

        Container(
          height: 30,
          child: Row(
            children: [
              Container(
                width: 10,
              ),

              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (widget.order.status == 'D') ? AssetImage('assets/image/redcircle.png') : AssetImage('assets/image/greycircle.png')
                    )
                ),
              ),

              Container(
                width: 10,
              ),

              Padding(
                padding: EdgeInsets.only(top: 7, bottom: 7),
                child: Container(
                  width: screenWidth - 40 - 30 - 30,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          height: 16,
                          width: screenWidth - 40 - 30 - 30,
                          child: AutoSizeText(
                            'Shipper đã xác nhận nhà hàng',
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 200,
                                fontWeight: (widget.order.status == 'A') ?  FontWeight.bold : FontWeight.normal
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 16,
                          width: screenWidth - 40 - 30 - 30,
                          alignment: Alignment.centerRight,
                          child: AutoSizeText(
                            getAllTimeString(widget.order.timeList[3]),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 200,
                                fontWeight: (widget.order.status == 'A') ?  FontWeight.bold : FontWeight.normal
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                width: 10,
              ),


            ],
          ),
        ),

        Container(
          height: 20,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 25, top: 4, bottom: 4),
            child: Container(
              alignment: Alignment.centerLeft,
              width: 1,
              decoration: BoxDecoration(
                  color: Colors.grey
              ),
            ),
          ),
        ),

        Container(
          height: 30,
          child: Row(
            children: [
              Container(
                width: 10,
              ),

              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (widget.order.status == 'E') ? AssetImage('assets/image/redcircle.png') : AssetImage('assets/image/greycircle.png')
                    )
                ),
              ),

              Container(
                width: 10,
              ),

              Padding(
                padding: EdgeInsets.only(top: 7, bottom: 7),
                child: Container(
                  width: screenWidth - 40 - 30 - 30,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          height: 16,
                          width: screenWidth - 40 - 30 - 30,
                          child: AutoSizeText(
                            'Shipper đã mua xong, đang giao',
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 200,
                                fontWeight: (widget.order.status == 'A') ?  FontWeight.bold : FontWeight.normal
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 16,
                          width: screenWidth - 40 - 30 - 30,
                          alignment: Alignment.centerRight,
                          child: AutoSizeText(
                            getAllTimeString(widget.order.timeList[4]),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 200,
                                fontWeight: (widget.order.status == 'A') ?  FontWeight.bold : FontWeight.normal
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                width: 10,
              ),


            ],
          ),
        ),

        Container(
          height: 20,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 25, top: 4, bottom: 4),
            child: Container(
              alignment: Alignment.centerLeft,
              width: 1,
              decoration: BoxDecoration(
                  color: Colors.grey
              ),
            ),
          ),
        ),

        Container(
          height: 30,
          child: Row(
            children: [
              Container(
                width: 10,
              ),

              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (widget.order.status == 'F') ? AssetImage('assets/image/redcircle.png') : AssetImage('assets/image/greycircle.png')
                    )
                ),
              ),

              Container(
                width: 10,
              ),

              Padding(
                padding: EdgeInsets.only(top: 7, bottom: 7),
                child: Container(
                  width: screenWidth - 40 - 30 - 30,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          height: 16,
                          width: screenWidth - 40 - 30 - 30,
                          child: AutoSizeText(
                            finalStatus,
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 200,
                                fontWeight: (widget.order.status == 'A') ?  FontWeight.bold : FontWeight.normal
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 16,
                          width: screenWidth - 40 - 30 - 30,
                          alignment: Alignment.centerRight,
                          child: AutoSizeText(
                            getAllTimeString(widget.order.timeList[5]),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 200,
                                fontWeight: (widget.order.status == 'A') ?  FontWeight.bold : FontWeight.normal
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                width: 10,
              ),


            ],
          ),
        ),

        Container(height: 20,),
      ],
    );
  }
}
