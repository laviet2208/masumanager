import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';

class view_log_request_order extends StatefulWidget {
  final requestBuyOrder order;
  const view_log_request_order({Key? key, required this.order}) : super(key: key);

  @override
  State<view_log_request_order> createState() => _view_log_request_orderState();
}

class _view_log_request_orderState extends State<view_log_request_order> {
  String finalStatus = 'Hoàn thành';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.order.status == "D") {
      finalStatus = "Đơn hàng hoàn tất";
    }
    if (widget.order.status == "E") {
      finalStatus = 'Bị hủy bởi khách';
    }
    if (widget.order.status == "E1") {
      finalStatus = 'Khách không lấy';
    }
    if (widget.order.status == "E2") {
      finalStatus = 'Bị hủy bới Admin';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = 500;
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
                            getAllTimeString(widget.order.S1time),
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
                  height: 30,
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
                            'Tài xế ' + widget.order.shipper.name + ' đang mua',
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 200,
                                fontWeight: (widget.order.status == 'B') ?  FontWeight.bold : FontWeight.normal
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
                            getAllTimeString(widget.order.S2time),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 200,
                                fontWeight: (widget.order.status == 'B') ?  FontWeight.bold : FontWeight.normal
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
                            'Tài xế mua xong, đang giao',
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 200,
                                fontWeight: (widget.order.status == 'C') ?  FontWeight.bold : FontWeight.normal
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
                            getAllTimeString(widget.order.S3time),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 200,
                                fontWeight: (widget.order.status == 'C') ?  FontWeight.bold : FontWeight.normal
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
                        image: (widget.order.status == 'E' || widget.order.status == 'F' || widget.order.status == 'G' || widget.order.status == 'D' || widget.order.status == 'H1' || widget.order.status == 'H2') ? AssetImage('assets/image/redcircle.png') : AssetImage('assets/image/greycircle.png')
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
                                fontWeight: (widget.order.status == 'E' || widget.order.status == 'F' || widget.order.status == 'G' || widget.order.status == 'D' || widget.order.status == 'H1' || widget.order.status == 'H2') ?  FontWeight.bold : FontWeight.normal
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
                            getAllTimeString(widget.order.S4time),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 200,
                                fontWeight: (widget.order.status == 'C') ?  FontWeight.bold : FontWeight.normal
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
