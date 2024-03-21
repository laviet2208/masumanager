import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/FinalClass.dart';

import '../../Mainmanager/Quản lý nhà hàng/Danh sách món ăn/Xem danh sách món ăn.dart';

class Danhsachmonannhahang extends StatefulWidget {
  final double width;
  final double height;
  const Danhsachmonannhahang({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Danhsachmonannhahang> createState() => _DanhsachmonannhahangState();
}

class _DanhsachmonannhahangState extends State<Danhsachmonannhahang> {
  @override
  Widget build(BuildContext context) {
    return Xemdanhsachmonan(width: widget.width, height: widget.height, shop: currentShop, data: 'Restaurant',);
  }
}
