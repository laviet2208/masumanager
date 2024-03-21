import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20c%E1%BA%A5u%20h%C3%ACnh/Cost.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

class Itemcauhinh extends StatefulWidget {
  final int index;
  final double width;
  final String id;
  final Cost cost;
  const Itemcauhinh({Key? key, required this.index, required this.width, required this.id, required this.cost}) : super(key: key);

  @override
  State<Itemcauhinh> createState() => _ItemcauhinhState();
}

class _ItemcauhinhState extends State<Itemcauhinh> {
  @override
  Widget build(BuildContext context) {
    String type = 'Xe máy';
    if (widget.index == 1) {
      type = 'Ô tô';
    }
    if (widget.index == 2) {
      type = 'Đồ ăn';
    }
    if (widget.index == 3) {
      type = 'Giao hàng';
    }
    
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
            width: (widget.width - 20)/6 - 1,
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
            width: (widget.width - 20)/6 - 1,
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
            width: (widget.width - 20)/6 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                child: AutoSizeText(
                  dataCheckManager.getStringNumber(widget.cost.departCost),
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
            width: (widget.width - 20)/6 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                child: AutoSizeText(
                  dataCheckManager.getStringNumber(widget.cost.perKMcost),
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
            width: (widget.width - 20)/6 - 1,
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
            width: (widget.width - 20)/6 - 1,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: 13,bottom: 13,left: 10,right: 10),
                      child: AutoSizeText(
                        'Cập nhật',
                        style: TextStyle(
                          fontSize: 100,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}
