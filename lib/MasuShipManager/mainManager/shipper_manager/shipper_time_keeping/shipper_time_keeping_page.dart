import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/mainManager/shipper_manager/shipper_time_keeping/item_shipper_time_keeping.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../Data/accountData/timeKeeping.dart';
import '../../ingredient/heading_title.dart';

class shipper_time_keeping_page extends StatefulWidget {
  const shipper_time_keeping_page({super.key});

  @override
  State<shipper_time_keeping_page> createState() => _shipper_time_keeping_pageState();
}

class _shipper_time_keeping_pageState extends State<shipper_time_keeping_page> {
  List<timeKeeping> keepingList = [];
  List<timeKeeping> chosenList = [];
  String chosenStatus = '';
  List<String> status_list = ['Tất cả','Hôm nay',];

  void drop_down_status(String? selectedValue) {
    if (selectedValue is String) {
      chosenStatus = selectedValue;
      if (chosenStatus == 'Tất cả') {
        chosenList.clear();
        for(int i = 0 ; i < keepingList.length ; i++) {
          chosenList.add(keepingList.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      }

      if (chosenStatus == 'Hôm nay') {
        chosenList.clear();
        for(int i = 0 ; i < keepingList.length ; i++) {
          if (keepingList[i].dayOff.day == DateTime.now().day && keepingList[i].dayOff.month == DateTime.now().month && keepingList[i].dayOff.year == DateTime.now().year) {
            chosenList.add(keepingList[i]);
          }
        }
        setState(() {

        });
      }
    }

    setState(() {

    });
  }

  void get_keeping_list() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("timeKeeping").onValue.listen((event) {
      keepingList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        timeKeeping account = timeKeeping.fromJson(value);
        keepingList.add(account);
        chosenList.add(account);
        setState(() {
          sortByTime(chosenList);
        });
      });
      setState(() {
        sortByTime(chosenList);
      });
    });
  }

  void sortByTime(List<timeKeeping> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
      return b.dayOff.year.compareTo(a.dayOff.year) != 0
          ? b.dayOff.year.compareTo(a.dayOff.year)
          : (b.dayOff.month.compareTo(a.dayOff.month) != 0
          ? b.dayOff.month.compareTo(a.dayOff.month)
          : (b.dayOff.day.compareTo(a.dayOff.day) != 0
          ? b.dayOff.day.compareTo(a.dayOff.day)
          : (b.dayOff.hour.compareTo(a.dayOff.hour) != 0
          ? b.dayOff.hour.compareTo(a.dayOff.hour)
          : (b.dayOff.minute.compareTo(a.dayOff.minute) != 0
          ? b.dayOff.minute.compareTo(a.dayOff.minute)
          : b.dayOff.second.compareTo(a.dayOff.second)))));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_keeping_list();
    chosenStatus = status_list.first;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    double height = MediaQuery.of(context).size.height - 60;
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          //Thanh head thông tin
          Positioned(
            top: 70,
            left: 10,
            child: heading_title(numberColumn: 4, listTitle: ['Người xin nghỉ', 'Lí do nghỉ', 'Thời gian nghỉ', 'Thao tác'], width: width - 20, height: 50),
          ),

          //chọn theo trạng thái
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 250,
              height: 40,
              child: DropdownButton<String>(
                items: status_list.map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                )).toList(),
                onChanged: (value) { drop_down_status(value); },
                value: chosenStatus,
                iconEnabledColor: Colors.redAccent,
                isExpanded: true,
                iconDisabledColor: Colors.grey,
              ),
            ),
          ),

          Positioned(
            top: 120,
            left: 10,
            bottom: 10,
            child: Container(
              width: width - 20,
              child: ListView.builder(
                itemCount: keepingList.length,
                itemBuilder: (context, index) {
                  return item_shipper_time_keeping(keeping: keepingList[index], index: index);
                },
              ),
            ),
          ),


        ],
      ),
    );
  }
}
