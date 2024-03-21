import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../Quản lý nhà hàng/Danh mục đồ ăn/Danh mục đồ ăn.dart';
import 'Item danh mục.dart';

class Hienthidanhmucsanpham extends StatefulWidget {
  final double width;
  final double height;
  final String idShop;
  const Hienthidanhmucsanpham({Key? key, required this.width, required this.height, required this.idShop}) : super(key: key);

  @override
  State<Hienthidanhmucsanpham> createState() => _HienthidanhmucdoanState();
}

class _HienthidanhmucdoanState extends State<Hienthidanhmucsanpham> {
  List<FoodDirectory> list = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("ProductDirectory").onValue.listen((event) {
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
          return Itemdanhmucsanpham(width: widget.width, foodDirectory: list[index],  color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255),);
        },
      ),
    );
  }
}
