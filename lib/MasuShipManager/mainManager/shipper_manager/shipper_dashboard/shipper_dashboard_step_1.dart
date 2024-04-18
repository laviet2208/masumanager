import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shipperAccount.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/utils.dart';
import 'package:masumanager/MasuShipManager/mainManager/shipper_manager/shipper_dashboard/shipper_dashboard_step_2.dart';

import '../../../Data/otherData/Time.dart';

class shipper_dashboard_step_1 extends StatefulWidget {
  final shipperAccount account;
  const shipper_dashboard_step_1({super.key, required this.account});

  @override
  State<shipper_dashboard_step_1> createState() => _shipper_dashboard_step_1State();
}

class _shipper_dashboard_step_1State extends State<shipper_dashboard_step_1> {
  final startController = TextEditingController();
  final endController = TextEditingController();
  Time start = Time(second: 0, minute: 0, hour: 0, day: 10, month: 10, year: 2023);
  Time end = Time(second: 0, minute: 0, hour: 0, day: 20, month: 10, year: 2023);
  List<Time> timeList = [];

  Future<void> _selectDate(BuildContext context, TextEditingController controller, Time time) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        time.day = selectedDate.day;
        time.month = selectedDate.month;
        time.year = selectedDate.year;
        controller.text = selectedDate.day.toString() + '/' + selectedDate.month.toString() + '/' + selectedDate.year.toString();
      });
    }
  }

  bool check_if_start_before_end() {
    DateTime st = DateTime(start.year, start.month, start.day, 0, 0, 0);
    DateTime en = DateTime(end.year, end.month, end.day, 0, 0, 0);
    return st.isBefore(en);
  }

  bool check_if_under_31_day() {
    DateTime st = DateTime(start.year, start.month, start.day, 0, 0, 0);
    DateTime en = DateTime(end.year, end.month, end.day, 0, 0, 0);
    return en.difference(st).inDays <= 31;
  }

  // Hàm tính số ngày trong một tháng
  int daysInMonth(int month, int year) {
    if (month == 2) {
      if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
        return 29; // Năm nhuận có 29 ngày trong tháng 2
      } else {
        return 28; // Năm không nhuận có 28 ngày trong tháng 2
      }
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
      return 30; // Tháng 4, 6, 9, 11 có 30 ngày
    } else {
      return 31; // Các tháng còn lại có 31 ngày
    }
  }

  void create_time_list() {
    timeList.clear();
    Time currentTime = start;
    while (currentTime.day <= end.day || currentTime.month < end.month) {
      timeList.add(currentTime);

      // Tính ngày tiếp theo
      int nextDay = currentTime.day + 1;
      int nextMonth = currentTime.month;
      int nextYear = currentTime.year;

      // Kiểm tra xem ngày hiện tại có phải là ngày cuối cùng của tháng không
      if (nextDay > daysInMonth(nextMonth, nextYear)) {
        nextDay = 1;
        nextMonth++;
      }

      // Kiểm tra xem tháng hiện tại có phải là tháng cuối cùng không
      if (nextMonth > 12) {
        nextMonth = 1;
        nextYear++;
      }

      // Cập nhật currentTime
      currentTime = Time(
        second: currentTime.second,
        minute: currentTime.minute,
        hour: currentTime.hour,
        day: nextDay,
        month: nextMonth,
        year: nextYear,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Chọn khoảng thời gian'),
      content: Container(
        width: MediaQuery.of(context).size.width/2,
        height: 200,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Ngày bắt đầu *',
                style: TextStyle(
                    fontFamily: 'muli',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
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
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: startController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'muli',
                    ),
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nhấn chọn ngày bắt đầu',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: 'muli',
                      ),
                    ),
                    onTap: () {
                      _selectDate(context, startController, start);
                    },
                  ),
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Ngày kết thúc *',
                style: TextStyle(
                    fontFamily: 'muli',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
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
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: endController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'muli',
                    ),
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nhấn chọn ngày kết thúc',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: 'muli',
                      ),
                    ),
                    onTap: () {
                      _selectDate(context, endController, end);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (check_if_start_before_end()) {
              if (check_if_under_31_day()) {
                create_time_list();
                showDialog(
                  context: context,
                  builder: (context) {
                    return shipper_dashboard_step_2(timeList: timeList, account: widget.account);
                  },);
              } else {
                toastMessage('Chỉ lọc tối đa 31 ngày');
              }
            } else {
              toastMessage('Thời gian bắt đầu phải trước thời gian kết thúc');
            }
          },
          child: Text('Bắt đầu thống kê', style: TextStyle(color: Colors.blueAccent,),),
        ),
      ],
    );
  }
}
