import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../Data/costData/Cost.dart';
import '../../../../Data/otherData/Tool.dart';
import 'change_order_fee.dart';

class item_configuration extends StatefulWidget {
  final int index;
  final double width;
  final String id;
  final Cost cost;
  const item_configuration({Key? key, required this.index, required this.width, required this.id, required this.cost}) : super(key: key);

  @override
  State<item_configuration> createState() => _item_configurationState();
}

class _item_configurationState extends State<item_configuration> {
  String type = 'Xe máy';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.index == 1) {
      type = 'Mua hộ tự do';
    }
    if (widget.index == 2) {
      type = 'Ô tô';
    }
    if (widget.index == 3) {
      type = 'Đồ ăn';
    }
    if (widget.index == 4) {
      type = 'Giao hàng';
    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/2;

    return Container(
      width: widget.width,
      height: 60,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 240, 240, 240),
            width: 1.0,
          ),
        ),
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),


          Container(
            width: width/6 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                child: AutoSizeText(
                  type,
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
            width: width/6 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                child: AutoSizeText(
                  widget.cost.departKM.toString() + ' Km',
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
            width: width/6 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                child: AutoSizeText(
                  getStringNumber(widget.cost.departCost),
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
            width: width/6 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                child: AutoSizeText(
                  getStringNumber(widget.cost.perKMcost),
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
            width: width/6 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                child: AutoSizeText(
                  widget.cost.discount.toString(),
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
            width: width/6 - 1,
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
                  return change_configuration(id: widget.id, index: widget.index, cost: widget.cost);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
