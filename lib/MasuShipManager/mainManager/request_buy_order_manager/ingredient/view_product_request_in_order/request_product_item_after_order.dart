import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:masumanager/MasuShipManager/mainManager/request_buy_order_manager/ingredient/view_product_request_in_order/accept_delete_product_in_request.dart';

import '../../../../Data/OrderData/requestBuyOrderData/requestProduct.dart';

class request_product_item_after_order extends StatefulWidget {
  final requestBuyOrder order;
  final int index;
  final VoidCallback callback;
  const request_product_item_after_order({super.key, required this.order, required this.index, required this.callback});

  @override
  State<request_product_item_after_order> createState() => _request_product_item_after_orderState();
}

class _request_product_item_after_orderState extends State<request_product_item_after_order> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/3;
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        width: width - 20,
        height: 30,
        child: Row(
          children: [
            Container(
              width: width - 50,
              alignment: Alignment.centerLeft,
              child: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Món ' + (widget.index + 1).toString() + ': ',
                          style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )
                      ),

                      TextSpan(
                          text: widget.order.productList[widget.index].name + ' - Số lượng: ' + widget.order.productList[widget.index].number.toString() + ' ' + widget.order.productList[widget.index].unit,
                          style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          )
                      ),
                    ]
                ),
              ),
            ),

            GestureDetector(
              child: Container(
                width: 30,
                child: Icon(
                  Icons.delete_forever_sharp,
                  color: Colors.redAccent,
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return accept_delete_product_in_request(order: widget.order, product: widget.order.productList[widget.index]);
                  }
                );
                widget.callback();
              },
            ),
          ],
        ),
      ),
    );
  }
}
