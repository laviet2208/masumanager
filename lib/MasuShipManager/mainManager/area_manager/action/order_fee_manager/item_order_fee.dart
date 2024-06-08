import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../Data/costData/Cost.dart';
import '../../../../Data/otherData/Tool.dart';
import '../../../ingredient/text_line_in_item.dart';
import 'change_order_fee.dart';

class item_configuration extends StatefulWidget {
  final int index;
  final String id;
  final Cost cost;
  const item_configuration({Key? key, required this.index, required this.id, required this.cost,}) : super(key: key);

  @override
  State<item_configuration> createState() => _item_configurationState();
}

class _item_configurationState extends State<item_configuration> {
  String typeName = 'Phí chở người';
  String type = 'bikeShipCost';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.index == 0) {
      type = 'bikeShipCost';
      typeName = 'Phí chở người';
    }
    if (widget.index == 1) {
      type = 'expressShipCost';
      typeName = 'Phí express';
    }
    if (widget.index == 2) {
      type = 'foodShipCost';
      typeName = 'Phí đồ ăn';
    }
    if (widget.index == 3) {
      type = 'requestBuyShipCost';
      typeName = 'Phí mua hộ';
    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/4*3;
    double height = 100;
    return Container(
      width: width,
      height: height,
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
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (width - 50)/7-1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 40),
                child: AutoSizeText(
                  typeName,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'arial',
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
            width: (width - 50)/7-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 5,),

                  text_line_in_item(color: Colors.black,title: 'Km đề pa: ', content: widget.cost.departKM.toString() + 'Km'),

                  Container(height: 5,),

                  text_line_in_item(color: Colors.black,title: 'Phí: ', content: getStringNumber(widget.cost.departCost) + '.đ'),

                  Container(height: 15,),
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
            width: (width - 50)/7-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 5,),

                  text_line_in_item(color: Colors.black,title: 'Km mốc 1: ', content: widget.cost.milestoneKM1.toString() + 'Km'),

                  Container(height: 5,),

                  text_line_in_item(color: Colors.black,title: 'Phí: ', content: getStringNumber(widget.cost.perKMcost1) + '.đ'),

                  Container(height: 15,),
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
            width: (width - 50)/7-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 5,),

                  text_line_in_item(color: Colors.black,title: 'Km mốc 2: ', content: widget.cost.milestoneKM2.toString() + 'Km'),

                  Container(height: 5,),

                  text_line_in_item(color: Colors.black,title: 'Phí: ', content: getStringNumber(widget.cost.perKMcost2) + '.đ'),

                  Container(height: 15,),
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
            width: (width - 50)/7-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 5,),

                  text_line_in_item(color: Colors.black,title: 'Phí: ', content: getStringNumber(widget.cost.perKMcost3) + '.đ'),

                  Container(height: 15,),
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
            width: (width - 50)/7-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 5,),

                  text_line_in_item(color: Colors.black,title: 'Giới hạn: ', content: getStringNumber(widget.cost.discountLimit) + '.đ'),

                  Container(height: 5,),

                  text_line_in_item(color: Colors.black,title: 'Cố định: ', content: getStringNumber(widget.cost.discountMoney) + '.đ'),

                  Container(height: 5,),

                  text_line_in_item(color: Colors.black,title: 'Phần trăm: ', content: getStringNumber(widget.cost.discountPercent) + '%'),

                  Container(height: 15,),
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
            width: (width - 50)/7-1,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 0.5,
                  color: Colors.grey
                )
              )
            ),
            alignment: Alignment.center,
            child: TextButton(
              child: Text('Cập nhật', style: TextStyle(fontFamily: 'muli', color: Colors.blueAccent, fontSize: 13),),
              onPressed: () {
                showDialog(context: context, builder: (context) {
                  return change_configuration(id: widget.id, cost: widget.cost, type: type,);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
