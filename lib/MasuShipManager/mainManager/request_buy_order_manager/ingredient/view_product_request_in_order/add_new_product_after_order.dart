import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:masumanager/MasuShipManager/mainManager/request_buy_order_manager/controller/start_request_order_controller.dart';

import '../../../../Data/OrderData/requestBuyOrderData/requestProduct.dart';
import '../../../../Data/otherData/utils.dart';

class add_new_product_after_order extends StatefulWidget {
  final requestBuyOrder order;
  final VoidCallback event;
  const add_new_product_after_order({super.key, required this.order, required this.event});

  @override
  State<add_new_product_after_order> createState() => _add_new_product_after_orderState();
}

class _add_new_product_after_orderState extends State<add_new_product_after_order> {
  bool loading = false;
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
        !loading ? TextButton(
          onPressed: () async {
            if (NameControl.text.isNotEmpty && NumberControl.text.isNotEmpty) {
              requestProduct product = requestProduct(name: NameControl.text.toString(), unit: UnitControl.text.isNotEmpty ? UnitControl.text.toString() : '', cost: 0, number: double.parse(NumberControl.text.toString()));
              widget.order.productList.add(product);
              await start_request_order_controller.push_buy_request_order_data(widget.order);
              widget.event();
              toastMessage('Thêm thành công');
              Navigator.of(context).pop();
            } else {
              toastMessage('Vui lòng nhập đủ');
            }
          },
          child: Text('Thêm sản phẩm', style: TextStyle(color: Colors.blueAccent),),
        ) : CircularProgressIndicator(color: Colors.blueAccent,),

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
