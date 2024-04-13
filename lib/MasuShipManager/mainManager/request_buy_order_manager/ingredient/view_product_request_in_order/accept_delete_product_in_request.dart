import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/requestBuyOrderData/requestProduct.dart';
import 'package:masumanager/MasuShipManager/mainManager/request_buy_order_manager/controller/start_request_order_controller.dart';

class accept_delete_product_in_request extends StatefulWidget {
  final requestBuyOrder order;
  final requestProduct product;
  const accept_delete_product_in_request({super.key, required this.order, required this.product});

  @override
  State<accept_delete_product_in_request> createState() => _accept_delete_product_in_requestState();
}

class _accept_delete_product_in_requestState extends State<accept_delete_product_in_request> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.order.productList.length > 1 ? 'Bạn có chắc chắn xóa không' : 'Hỏi chấm thực sự?'),
      content: Text(widget.order.productList.length > 1 ? 'Việc này sẽ làm thay đổi giá trị đơn?' : 'Chỉ còn 1 sản phẩm, xóa hết để hỏng đơn luôn đơn hả mấy ông thần?🙂'),
      actions: <Widget>[
        !loading ? TextButton(
          onPressed: () async {
            if (widget.order.productList.length > 1) {
              setState(() {
                loading = true;
              });
              widget.order.productList.remove(widget.product);
              await start_request_order_controller.push_buy_request_order_data(widget.order);
              setState(() {
                loading = false;
              });
              Navigator.of(context).pop();
            }
          },
          child: Text('Đồng ý', style: TextStyle(color: Colors.blueAccent),),
        ) : CircularProgressIndicator(color: Colors.blueAccent,),
      ],
    );
  }
}
