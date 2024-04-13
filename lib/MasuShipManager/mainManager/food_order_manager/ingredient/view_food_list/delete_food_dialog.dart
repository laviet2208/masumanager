import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/utils.dart';
import 'package:masumanager/MasuShipManager/mainManager/food_order_manager/ingredient/view_food_list/delete_food_controller.dart';

class delete_food_dialog extends StatefulWidget {
  final foodOrder order;
  final int index;
  const delete_food_dialog({super.key, required this.order, required this.index});

  @override
  State<delete_food_dialog> createState() => _delete_food_dialogState();
}

class _delete_food_dialogState extends State<delete_food_dialog> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Bạn có chắc chắn xóa không?'),
      content: Text('Điều này sẽ làm thay đổi giá trị đơn'),
      actions: <Widget>[
        !loading ? TextButton(
          onPressed: () async {
            if (widget.order.productList.length > 1) {
              setState(() {
                loading = true;
              });
              widget.order.productList.removeAt(widget.index);
              await delete_food_controller.add_restaurant_to_list(widget.order.productList, widget.order.shopList);
              widget.order.cost = await delete_food_controller.getMaxCost(widget.order);
              widget.order.pointFee = (widget.order.shopList.length - 1) * 5000;
              await delete_food_controller.push_food_order_data(widget.order);
              setState(() {
                loading = false;
              });
              Navigator.of(context).pop();
            } else {
              toastMessage('Không thể xóa');
            }
          },
          child: Text(
            'Xác nhận',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ) : CircularProgressIndicator(color: Colors.blueAccent,),
      ],
    );
  }
}
