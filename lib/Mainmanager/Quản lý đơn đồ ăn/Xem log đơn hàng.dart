import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20%C4%91%C6%A1n%20%C4%91%E1%BB%93%20%C4%83n/foodOrder.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20%C4%91%C6%A1n%20giao%20h%C3%A0ng/Data/itemsendOrder.dart';

class ViewLogFood extends StatefulWidget {
  final double screenWidth;
  final foodOrder thiscatch;
  const ViewLogFood({Key? key, required this.screenWidth, required this.thiscatch}) : super(key: key);

  @override
  State<ViewLogFood> createState() => _ViewLogItemSendState();
}

class _ViewLogItemSendState extends State<ViewLogFood> {
  String finalStatus = 'Hoàn thành';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.thiscatch.status == "D1") {
      finalStatus = "Đơn hàng hoàn tất";
    }
    if (widget.thiscatch.status == "I") {
      finalStatus = 'Bị hủy bởi shipper';
    }
    if (widget.thiscatch.status == "F") {
      finalStatus = 'Quán không xác nhận';
    }
    if (widget.thiscatch.status == "E" || widget.thiscatch.status == "G" || widget.thiscatch.status == "H") {
      finalStatus = 'Bị hủy bởi khách hàng';
    }
    if (widget.thiscatch.status == "J") {
      finalStatus = 'Bị bom bởi khách hàng';
    }
    if (widget.thiscatch.status == "H1") {
      finalStatus = 'Bị hủy bởi admin tổng';
    }
    if (widget.thiscatch.status == "H2") {
      finalStatus = 'Bị hủy bởi admin khu vực';
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  'Tình trạng đơn',
                  style: TextStyle(
                      fontFamily: 'arial',
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
                          image: (widget.thiscatch.status == 'A') ? AssetImage('assets/image/redcircle.png') : AssetImage('assets/image/greycircle.png')
                      )
                  ),
                ),

                Container(
                  width: 10,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: Container(
                    width: widget.screenWidth - 40 - 30 - 30,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            height: 16,
                            width: widget.screenWidth - 40 - 30 - 30,
                            child: AutoSizeText(
                              'Đợi nhà hàng xác nhận',
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  color: Colors.black,
                                  fontSize: 200,
                                  fontWeight: (widget.thiscatch.status == 'A') ?  FontWeight.bold : FontWeight.normal
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            height: 16,
                            width: widget.screenWidth - 40 - 30 - 30,
                            alignment: Alignment.centerRight,
                            child: AutoSizeText(
                              ((widget.thiscatch. S1time.hour < 10) ? '0' + widget.thiscatch. S1time.hour.toString() : widget.thiscatch. S1time.hour.toString()) + ':' + ((widget.thiscatch. S1time.minute < 10) ? '0' + widget.thiscatch. S1time.minute.toString() : widget.thiscatch. S1time.minute.toString()) + ' , ngày ' + ((widget.thiscatch.S1time.day < 10) ? '0' + widget.thiscatch. S1time.day.toString() : widget.thiscatch. S1time.day.toString()) + '/' + ((widget.thiscatch.S1time.month < 10) ? '0' + widget.thiscatch. S1time.month.toString() : widget.thiscatch. S1time.month.toString()),
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  color: Colors.black,
                                  fontSize: 200,
                                  fontWeight: (widget.thiscatch.status == 'A') ?  FontWeight.bold : FontWeight.normal
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
                          image: (widget.thiscatch.status == 'B') ? AssetImage('assets/image/redcircle.png') : AssetImage('assets/image/greycircle.png')
                      )
                  ),
                ),

                Container(
                  width: 10,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: Container(
                    width: widget.screenWidth - 40 - 30 - 30,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            height: 16,
                            width: widget.screenWidth - 40 - 30 - 30,
                            child: AutoSizeText(
                              'Đã xác nhận , đợi tài xế lấy',
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  color: Colors.black,
                                  fontSize: 200,
                                  fontWeight: (widget.thiscatch.status == 'B') ?  FontWeight.bold : FontWeight.normal
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            height: 16,
                            width: widget.screenWidth - 40 - 30 - 30,
                            alignment: Alignment.centerRight,
                            child: AutoSizeText(
                              ((widget.thiscatch. S2time.hour < 10) ? '0' + widget.thiscatch. S2time.hour.toString() : widget.thiscatch. S2time.hour.toString()) + ':' + ((widget.thiscatch. S2time.minute < 10) ? '0' + widget.thiscatch. S2time.minute.toString() : widget.thiscatch. S2time.minute.toString()) + ' , ngày ' + ((widget.thiscatch.S2time.day < 10) ? '0' + widget.thiscatch. S2time.day.toString() : widget.thiscatch. S2time.day.toString()) + '/' + ((widget.thiscatch.S2time.month < 10) ? '0' + widget.thiscatch. S2time.month.toString() : widget.thiscatch. S2time.month.toString()),
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  color: Colors.black,
                                  fontSize: 200,
                                  fontWeight: (widget.thiscatch.status == 'B') ?  FontWeight.bold : FontWeight.normal
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
                          image: (widget.thiscatch.status == 'C') ? AssetImage('assets/image/redcircle.png') : AssetImage('assets/image/greycircle.png')
                      )
                  ),
                ),

                Container(
                  width: 10,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: Container(
                    width: widget.screenWidth - 40 - 30 - 30,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            height: 16,
                            width: widget.screenWidth - 40 - 30 - 30,
                            child: AutoSizeText(
                              'Tài xế đang tới quán lấy đồ',
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  color: Colors.black,
                                  fontSize: 200,
                                  fontWeight: (widget.thiscatch.status == 'C') ?  FontWeight.bold : FontWeight.normal
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            height: 16,
                            width: widget.screenWidth - 40 - 30 - 30,
                            alignment: Alignment.centerRight,
                            child: AutoSizeText(
                              ((widget.thiscatch. S3time.hour < 10) ? '0' + widget.thiscatch. S3time.hour.toString() : widget.thiscatch. S3time.hour.toString()) + ':' + ((widget.thiscatch. S3time.minute < 10) ? '0' + widget.thiscatch. S3time.minute.toString() : widget.thiscatch. S3time.minute.toString()) + ' , ngày ' + ((widget.thiscatch.S3time.day < 10) ? '0' + widget.thiscatch. S3time.day.toString() : widget.thiscatch. S3time.day.toString()) + '/' + ((widget.thiscatch.S3time.month < 10) ? '0' + widget.thiscatch. S3time.month.toString() : widget.thiscatch. S3time.month.toString()),
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  color: Colors.black,
                                  fontSize: 200,
                                  fontWeight: (widget.thiscatch.status == 'C') ?  FontWeight.bold : FontWeight.normal
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
                          image: (widget.thiscatch.status == 'D') ? AssetImage('assets/image/redcircle.png') : AssetImage('assets/image/greycircle.png')
                      )
                  ),
                ),

                Container(
                  width: 10,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: Container(
                    width: widget.screenWidth - 40 - 30 - 30,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            height: 16,
                            width: widget.screenWidth - 40 - 30 - 30,
                            child: AutoSizeText(
                              'Tài xế đang giao tới bạn',
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  color: Colors.black,
                                  fontSize: 200,
                                  fontWeight: (widget.thiscatch.status == 'D') ?  FontWeight.bold : FontWeight.normal
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            height: 16,
                            width: widget.screenWidth - 40 - 30 - 30,
                            alignment: Alignment.centerRight,
                            child: AutoSizeText(
                              ((widget.thiscatch. S4time.hour < 10) ? '0' + widget.thiscatch. S4time.hour.toString() : widget.thiscatch. S4time.hour.toString()) + ':' + ((widget.thiscatch. S4time.minute < 10) ? '0' + widget.thiscatch. S4time.minute.toString() : widget.thiscatch. S4time.minute.toString()) + ' , ngày ' + ((widget.thiscatch.S4time.day < 10) ? '0' + widget.thiscatch. S4time.day.toString() : widget.thiscatch. S4time.day.toString()) + '/' + ((widget.thiscatch.S4time.month < 10) ? '0' + widget.thiscatch. S4time.month.toString() : widget.thiscatch. S4time.month.toString()),
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  color: Colors.black,
                                  fontSize: 200,
                                  fontWeight: (widget.thiscatch.status == 'D') ?  FontWeight.bold : FontWeight.normal
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
                          image: (widget.thiscatch.status == 'E' || widget.thiscatch.status == 'F' || widget.thiscatch.status == 'G' || widget.thiscatch.status == 'H' || widget.thiscatch.status == 'I' || widget.thiscatch.status == 'J' || widget.thiscatch.status == 'D1' || widget.thiscatch.status == 'H1' || widget.thiscatch.status == 'H2') ? AssetImage('assets/image/redcircle.png') : AssetImage('assets/image/greycircle.png')
                      )
                  ),
                ),

                Container(
                  width: 10,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: Container(
                    width: widget.screenWidth - 40 - 30 - 30,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            height: 16,
                            width: widget.screenWidth - 40 - 30 - 30,
                            child: AutoSizeText(
                              finalStatus,
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  color: Colors.black,
                                  fontSize: 200,
                                  fontWeight: (widget.thiscatch.status == 'E' || widget.thiscatch.status == 'F' || widget.thiscatch.status == 'G' || widget.thiscatch.status == 'H' || widget.thiscatch.status == 'I' || widget.thiscatch.status == 'J' || widget.thiscatch.status == 'D1' || widget.thiscatch.status == 'H1' || widget.thiscatch.status == 'H2') ?  FontWeight.bold : FontWeight.normal
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            height: 16,
                            width: widget.screenWidth - 40 - 30 - 30,
                            alignment: Alignment.centerRight,
                            child: AutoSizeText(
                              ((widget.thiscatch. S5time.hour < 10) ? '0' + widget.thiscatch. S5time.hour.toString() : widget.thiscatch. S5time.hour.toString()) + ':' + ((widget.thiscatch. S5time.minute < 10) ? '0' + widget.thiscatch. S5time.minute.toString() : widget.thiscatch. S5time.minute.toString()) + ' , ngày ' + ((widget.thiscatch.S5time.day < 10) ? '0' + widget.thiscatch. S5time.day.toString() : widget.thiscatch. S5time.day.toString()) + '/' + ((widget.thiscatch.S5time.month < 10) ? '0' + widget.thiscatch. S5time.month.toString() : widget.thiscatch. S5time.month.toString()),
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontFamily: 'arial',
                                  color: Colors.black,
                                  fontSize: 200,
                                  fontWeight: (widget.thiscatch.status == 'E' || widget.thiscatch.status == 'F' || widget.thiscatch.status == 'G' || widget.thiscatch.status == 'H' || widget.thiscatch.status == 'I' || widget.thiscatch.status == 'J' || widget.thiscatch.status == 'D1' || widget.thiscatch.status == 'H1' || widget.thiscatch.status == 'H2') ?  FontWeight.bold : FontWeight.normal
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
