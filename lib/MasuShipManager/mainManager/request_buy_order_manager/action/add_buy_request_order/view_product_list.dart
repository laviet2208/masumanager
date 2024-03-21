import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'add_product_for_buy_request_order.dart';
import 'item_product_in_request_order.dart';

class view_product_list extends StatefulWidget {
  final requestBuyOrder order;
  final VoidCallback event;
  const view_product_list({Key? key, required this.order, required this.event}) : super(key: key);

  @override
  State<view_product_list> createState() => _view_product_listState();
}

class _view_product_listState extends State<view_product_list> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/2;
    double height = MediaQuery.of(context).size.height/1.5;
    
    return AlertDialog(
      title: Text('Danh sách sản phẩm'),
      content: Container(
        width: width,
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              left: 0,
              child: GestureDetector(
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade600,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Thêm mặt hàng',
                    style: TextStyle(
                      fontFamily: 'arial',
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return add_product_for_buy_request_order(order: widget.order, event: () {setState(() {});});
                    },
                  );
                },
              ),
            ),
            
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 247, 250, 255),
                    border: Border.all(
                        width: 1,
                        color: Color.fromARGB(255, 225, 225, 226)
                    )
                ),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 29,
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
                            'Tên mặt hàng',
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
                            'Đơn giá',
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
                            'Đơn vị',
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
                            'Số lượng',
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
                            'Thành tiền',
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
                      width: 29,
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 110,
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                child: widget.order.productList.length == 0 ? Text('Danh sách trống', style: TextStyle(fontSize: 14,color: Colors.black),) : ListView.builder(
                  itemCount: widget.order.productList.length,
                  itemBuilder: (context, index) {
                    return item_product_in_request_order(product: widget.order.productList[index], index: index, event: () {setState(() {widget.order.productList.removeAt(index);});  },);
                    },
                ),
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            widget.event();
            Navigator.of(context).pop();
          },
          child: Text('Cập nhật', style: TextStyle(color: Colors.blueAccent),),
        ),
      ],
    );
  }
}
