import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/accountShop.dart';

import '../../utils/utils.dart';

class Droplistnhahang extends StatefulWidget {
  final double width;
  final accountShop shop;
  const Droplistnhahang({Key? key, required this.width, required this.shop}) : super(key: key);

  @override
  State<Droplistnhahang> createState() => _DroplistnhahangState();
}

class _DroplistnhahangState extends State<Droplistnhahang> {
  int selectIndex = 0;
  List<String> items = ['5 sao','Ăn vặt','Bún phở','Cơm','Khuyến mãi','Món nhậu','Nước uống','Thức ăn nhanh','Trà sữa'];
  @override
  Widget build(BuildContext context) {
    selectIndex = widget.shop.Type;
    return Container(
      width: widget.width,
      height: 50,
        child: Container(
          height: 50,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
              border: Border.all(
                width: 1,
                color: Colors.black,
              )
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: DropdownButton(
              value: selectIndex,
              items: List.generate(items.length,
                      (index) => DropdownMenuItem(
                    value: index,
                    child: Text(items[index]),
                  )),
              onChanged: (value) {
                setState(() {
                  selectIndex = int.parse(value.toString());
                  widget.shop.Type = selectIndex;
                  toastMessage('Bạn đã chọn : ' + items[selectIndex]);
                });
              },
            ),
          ),
        )
    );
  }

  int _getSelectedIndex() {
    return selectIndex;
  }
}
