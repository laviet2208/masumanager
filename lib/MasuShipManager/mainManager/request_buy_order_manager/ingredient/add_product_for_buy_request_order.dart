import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/requestBuyOrderData/requestProduct.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/utils.dart';

class add_product_for_buy_request_order extends StatefulWidget {
  final requestBuyOrder order;
  final VoidCallback event;
  const add_product_for_buy_request_order({Key? key, required this.order, required this.event}) : super(key: key);

  @override
  State<add_product_for_buy_request_order> createState() => _add_product_for_buy_request_orderState();
}

class _add_product_for_buy_request_orderState extends State<add_product_for_buy_request_order> {
  final NameControl = TextEditingController();
  final UnitControl = TextEditingController();
  final NumberControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thêm mặt hàng'),
      content: Container(
        width: MediaQuery.of(context).size.width/3,
        height: MediaQuery.of(context).size.height/2,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Tên mặt hàng *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),

            Container(
              height: 7,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        width: 0.5,
                        color: Colors.black,
                      )
                  ),

                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Form(
                      child: TextFormField(
                        controller: NameControl,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập tên mặt hàng',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'arial',
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ),

            Container(
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Đơn vị *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),

            Container(
              height: 7,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        width: 0.5,
                        color: Colors.black,
                      )
                  ),

                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Form(
                      child: TextFormField(
                        controller: UnitControl,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập đơn vị',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'arial',
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ),

            Container(
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Số lượng *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),

            Container(
              height: 7,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        width: 0.5,
                        color: Colors.black,
                      )
                  ),

                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Form(
                      child: TextFormField(
                        controller: NumberControl,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập số lượng',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'arial',
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ),

            Container(
              height: 15,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (NameControl.text.isNotEmpty && NumberControl.text.isNotEmpty) {
              requestProduct product = requestProduct(name: NameControl.text.toString(), unit: UnitControl.text.isNotEmpty ? UnitControl.text.toString() : '', cost: 0, number: double.parse(NumberControl.text.toString()));
              widget.order.productList.add(product);
              widget.event();
              Navigator.of(context).pop();
            } else {
              toastMessage('Vui lòng nhập đủ');
            }
          },
          child: Text('Thêm', style: TextStyle(color: Colors.blueAccent),),
        ),

        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Hủy', style: TextStyle(color: Colors.redAccent),),
        ),
      ],
    );
  }
}
