import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/timeKeeping.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:masumanager/MasuShipManager/mainManager/shipper_manager/shipper_time_keeping/ingredient/accept_keeping_request.dart';

import '../../ingredient/text_line_in_item.dart';

class item_shipper_time_keeping extends StatefulWidget {
  final timeKeeping keeping;
  final int index;
  const item_shipper_time_keeping({super.key, required this.keeping, required this.index});

  @override
  State<item_shipper_time_keeping> createState() => _item_shipper_time_keepingState();
}

class _item_shipper_time_keepingState extends State<item_shipper_time_keeping> {

  String getReason(int index) {
    List<String> reasonTypes = ['Gia đình có việc', 'Bản thân có việc', 'Có tang', 'Có hỉ', 'Lí do khác'];
    return reasonTypes.elementAt(index);
  }

  String getShift(int index) {
    List<String> shiftTypes = ['Nghỉ cả ngày', 'Nghỉ ca sáng 8-12h', 'Nghỉ ca chiều ', 'Nghỉ ca tối'];
    return shiftTypes.elementAt(index);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 80;
    double height = 120;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: widget.index % 2 == 0 ? Colors.white : Color.fromARGB(255, 247, 250, 255),
        border: Border.all(
          color: Color.fromARGB(255, 240, 240, 240),
          width: 1.0,
        ),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            width: 49,
            alignment: Alignment.center,
            child: Text(
              (widget.index + 1).toString(),
              style: TextStyle(
                fontFamily: 'arial',
                color: Colors.black,

              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (width - 50)/4 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 8,),

                  text_line_in_item(title: 'Tên tài xế: ', content: widget.keeping.owner.name, color: Colors.black),

                  Container(height: 8,),

                  text_line_in_item(title: 'Số điện thoại: ', content: '0' + widget.keeping.owner.phone, color: Colors.black),

                  Container(height: 8,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (width - 50)/4 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 8,),

                  text_line_in_item(title: 'Loại lí do: ', content: getReason(widget.keeping.reasonType), color: Colors.redAccent),

                  Container(height: 8,),

                  text_line_in_item(title: 'Ca nghỉ: ', content: getShift(widget.keeping.shift), color: Colors.purple),

                  Container(height: 8,),

                  text_line_in_item(title: 'Chi tiết: ', content: widget.keeping.reason, color: Colors.black),

                  Container(height: 8,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (width - 50)/4 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 8,),

                  text_line_in_item(title: 'Ngày xin nghỉ: ', content: getTimeString(widget.keeping.dayOff), color: Colors.redAccent),

                  Container(height: 8,),

                  text_line_in_item(title: 'Trạng thái: ', content: widget.keeping.status == 0 ? 'Chờ duyệt' : (widget.keeping.status == 1 ? 'Đã duyệt' : 'Từ chối'), color: widget.keeping.status == 0 ? Colors.black : (widget.keeping.status == 1 ? Colors.green : Colors.redAccent)),

                  Container(height: 8,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (width - 50)/4 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 8,),

                  GestureDetector(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          border: Border.all(
                            width: 0.5,
                            color: Colors.black,
                          )
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Phê duyệt yêu cầu',
                        style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return accept_keeping_request(keeping: widget.keeping);
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),
        ],
      ),
    );
  }
}
