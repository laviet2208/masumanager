import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/accountShop.dart';

import '../../dataClass/Time.dart';
import '../../utils/utils.dart';

class Droplisttype extends StatefulWidget {
  final double width;
  final accountShop shop;
  const Droplisttype({Key? key, required this.width, required this.shop,}) : super(key: key);

  @override
  State<Droplisttype> createState() => _DroplistnhahangState();
}

class _DroplistnhahangState extends State<Droplisttype> {
  int selectIndex = 1;

  List<String> items = ['Giảm theo tiền cứng','Giảm theo phần trăm',];
  @override
  Widget build(BuildContext context) {
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
                   if (selectIndex == 0) {
                     widget.shop.status = 0;
                     widget.shop.name = 'Nhập số VNĐ muốn giảm(Không có phần thập phân)';
                   }
                   if (selectIndex == 1) {
                     widget.shop.status = 1;
                     widget.shop.name = 'Nhập số % muốn giảm(Không có phần thập phân)';
                   }
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
