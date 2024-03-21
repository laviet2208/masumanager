import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../Data/OrderData/requestBuyOrderData/requestProduct.dart';
import '../../../../Data/otherData/Tool.dart';

class item_product_in_request_order extends StatefulWidget {
  final requestProduct product;
  final int index;
  final VoidCallback event;
  const item_product_in_request_order({Key? key, required this.product, required this.index, required this.event}) : super(key: key);

  @override
  State<item_product_in_request_order> createState() => _item_product_in_request_orderState();
}

class _item_product_in_request_orderState extends State<item_product_in_request_order> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/2;
    return Container(
      width: width,
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(width: 0.6, color: Colors.black)
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 29,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                child: AutoSizeText(
                  (widget.index + 1).toString(),
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
            width: (width - 60)/5 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                child: AutoSizeText(
                  widget.product.name,
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
            width: (width - 60)/5 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                child: AutoSizeText(
                  getStringNumber(widget.product.cost),
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
            width: (width - 60)/5 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                child: AutoSizeText(
                  widget.product.unit,
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
            width: (width - 60)/5 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                child: AutoSizeText(
                  widget.product.number.toString(),
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
            width: (width - 60)/5 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                child: AutoSizeText(
                  getStringNumber(widget.product.number * widget.product.cost),
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

          GestureDetector(
            child: Container(
              width: 29,
              alignment: Alignment.center,
              child: Icon(
                Icons.delete_outline,
                size: 20,
                color: Colors.red,
              ),
            ),
            onTap: widget.event,
          )
        ],
      ),
    );
  }
}
