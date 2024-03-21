import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Danh mục đồ ăn.dart';
import 'Item danh mục.dart';

class Hienthidanhmucdoan extends StatefulWidget {
  final double width;
  final double height;
  final String idShop;
  final String data;
  const Hienthidanhmucdoan({Key? key, required this.width, required this.height, required this.idShop, required this.data}) : super(key: key);

  @override
  State<Hienthidanhmucdoan> createState() => _HienthidanhmucdoanState();
}

class _HienthidanhmucdoanState extends State<Hienthidanhmucdoan> {
  List<FoodDirectory> list = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child(widget.data == 'Restaurant' ? "FoodDirectory" : 'ProductDirectory').onValue.listen((event) {
      list.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        FoodDirectory food= FoodDirectory.fromJson(value);
        if (food.ownerID == widget.idShop) {
          list.add(food);
        }

      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Itemdanhmucmonan(width: widget.width, foodDirectory: list[index], color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255), data: widget.data,);
        },
      ),
    );
  }
}
