import 'package:flutter/material.dart';

import '../../../dataClass/Time.dart';
import '../../../utils/utils.dart';


class Droplistquyenhan extends StatefulWidget {
  final double width;
  final Time time;
  const Droplistquyenhan({Key? key, required this.width, required this.time, }) : super(key: key);

  @override
  State<Droplistquyenhan> createState() => _DroplistnhahangState();
}

class _DroplistnhahangState extends State<Droplistquyenhan> {
  int selectIndex = 0;
  List<String> items = ['Admin hệ thống','Admin các tỉnh'];
  @override
  Widget build(BuildContext context) {
    selectIndex = widget.time.second - 1;
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
                  widget.time.second = selectIndex + 1;
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