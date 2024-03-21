import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/accountShop.dart';

import '../../dataClass/Time.dart';
import '../../utils/utils.dart';

class Droplisticon extends StatefulWidget {
  final double width;
  final accountShop shop;
  final int type;
  const Droplisticon({Key? key, required this.width, required this.shop, required this.type}) : super(key: key);

  @override
  State<Droplisticon> createState() => _DroplistnhahangState();
}

class _DroplistnhahangState extends State<Droplisticon> {
  int selectIndex = 0;

  List<String> items = ['Ngọn lửa','Chúc mừng','Xe máy','Mặt trăng','Mặt trời'];
  @override
  Widget build(BuildContext context) {
    if (widget.type == 1) {
      selectIndex = widget.shop.Type;
    }
    if (widget.type == 2) {
      selectIndex = widget.shop.isTop;
    }
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

                  if (widget.type == 1) {
                    widget.shop.Type = selectIndex;
                    if (selectIndex == 0) {
                      widget.shop.id = 'assets/image/icontrang1/fire.png';
                    }
                    if (selectIndex == 1) {
                      widget.shop.id = 'assets/image/icontrang1/celebrate.png';
                    }
                    if (selectIndex == 2) {
                      widget.shop.id = 'assets/image/icontrang1/minibike.png';
                    }
                    if (selectIndex == 3) {
                      widget.shop.id = 'assets/image/icontrang1/moon.png';
                    }
                    if (selectIndex == 4) {
                      widget.shop.id = 'assets/image/icontrang1/weather.png';
                    }
                    toastMessage('Bạn đã chọn : ' + items[selectIndex]);
                  }

                  if (widget.type == 2) {
                    widget.shop.isTop = selectIndex;
                    if (selectIndex == 0) {
                      widget.shop.phoneNum = 'assets/image/icontrang1/fire.png';
                    }
                    if (selectIndex == 1) {
                      widget.shop.phoneNum = 'assets/image/icontrang1/celebrate.png';
                    }
                    if (selectIndex == 2) {
                      widget.shop.phoneNum = 'assets/image/icontrang1/minibike.png';
                    }
                    if (selectIndex == 3) {
                      widget.shop.phoneNum = 'assets/image/icontrang1/moon.png';
                    }
                    if (selectIndex == 4) {
                      widget.shop.phoneNum = 'assets/image/icontrang1/weather.png';
                    }
                    toastMessage('Bạn đã chọn : ' + items[selectIndex]);
                  }
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
