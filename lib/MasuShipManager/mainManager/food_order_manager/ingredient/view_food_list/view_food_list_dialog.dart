import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masumanager/MasuShipManager/mainManager/food_order_manager/ingredient/view_food_list/item_view_food.dart';

class view_food_list_dialog extends StatefulWidget {
  final foodOrder order;
  const view_food_list_dialog({super.key, required this.order});

  @override
  State<view_food_list_dialog> createState() => _view_food_list_dialogState();
}

class _view_food_list_dialogState extends State<view_food_list_dialog> {
  @override
  Widget build(BuildContext context) {
    double width = 500;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          width: width,
          height: MediaQuery.of(context).size.height/5*4,
          child: ListView.builder(
            itemCount: widget.order.productList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: item_view_food(order: widget.order, index: index),
              );
            },
          ),
        ),
      )
    );
  }
}
