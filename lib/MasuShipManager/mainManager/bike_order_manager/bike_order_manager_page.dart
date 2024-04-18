import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/mainManager/bike_order_manager/ingredient/add_bike_order/add_bike_order_dialog_step_1.dart';
import '../../Data/areaData/Area.dart';
import '../ingredient/heading_title.dart';
import 'bike_order_item.dart';

class bike_order_manager_page extends StatefulWidget {
  const bike_order_manager_page({super.key});

  @override
  State<bike_order_manager_page> createState() => _bike_order_manager_pageState();
}

class _bike_order_manager_pageState extends State<bike_order_manager_page> {
  TextEditingController searchController = TextEditingController();
  List<motherOrder> orderList = [];
  List<motherOrder> chosenList = [];
  List<Area> areaList = [];
  List<String> status_list = ['Tất cả','Đơn chưa đẩy', 'Đơn đã đẩy cho tài xế',];
  Area chosenArea = Area(id: '', name: '', money: 0, status: 0);
  String chosenStatus = '';

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").onValue.listen((event) {
      orderList.clear();
      chosenList.clear();
      setState(() {

      });
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        if (value['orderList'] != null) {
          motherOrder order = motherOrder.fromJson(value);
          orderList.add(order);
          chosenList.add(order);
        }
      });
      setState(() {
        sortChosenListByCreateTime(chosenList);
      });
    });
  }

  void getDataArea() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").onValue.listen((event) {
      areaList.clear();
      areaList.add(Area(id: 'all', name: 'Tất cả', money: 0, status: 0));
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Area area= Area.fromJson(value);
        areaList.add(area);
      });
      setState(() {
        if (areaList.length != 0) {
          chosenArea = areaList.first;
        }
      });
    });
  }

  void sortChosenListByCreateTime(List<motherOrder> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
      return b.createTime.year.compareTo(a.createTime.year) != 0
          ? b.createTime.year.compareTo(a.createTime.year)
          : (b.createTime.month.compareTo(a.createTime.month) != 0
          ? b.createTime.month.compareTo(a.createTime.month)
          : (b.createTime.day.compareTo(a.createTime.day) != 0
          ? b.createTime.day.compareTo(a.createTime.day)
          : (b.createTime.hour.compareTo(a.createTime.hour) != 0
          ? b.createTime.hour.compareTo(a.createTime.hour)
          : (b.createTime.minute.compareTo(a.createTime.minute) != 0
          ? b.createTime.minute.compareTo(a.createTime.minute)
          : b.createTime.second.compareTo(a.createTime.second)))));
    });
  }

  void dropdownCallback(Area? selectedValue) {
    if (selectedValue is Area) {
      chosenArea = selectedValue;
      if (chosenArea.id == 'all') {
        chosenList.clear();
        for(int i = 0 ; i < orderList.length ; i++) {
          chosenList.add(orderList.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      } else {
        chosenList.clear();
        for(int i = 0 ; i < orderList.length ; i++) {
          if (orderList.elementAt(i).owner.area == chosenArea.id) {
            chosenList.add(orderList.elementAt(i));
            setState(() {

            });
          }
        }
      }

    }

    setState(() {

    });
  }

  void drop_down_status_order(String? selectedValue) {
    if (selectedValue is String) {
      chosenStatus = selectedValue;
      if (chosenStatus == 'Tất cả') {
        chosenList.clear();
        for(int i = 0 ; i < orderList.length ; i++) {
          chosenList.add(orderList.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      }

      if (chosenStatus == 'Đơn chưa đẩy') {
        chosenList.clear();
        for(int i = 0 ; i < orderList.length ; i++) {
          if (orderList.elementAt(i).status == 'A') {
            chosenList.add(orderList.elementAt(i));
            setState(() {

            });
          }
        }
        setState(() {

        });
      }

      if (chosenStatus == 'Đơn mới đẩy cho tài xế') {
        chosenList.clear();
        for(int i = 0 ; i < orderList.length ; i++) {
          if (orderList.elementAt(i).status == 'B') {
            chosenList.add(orderList.elementAt(i));
            setState(() {

            });
          }
        }
        setState(() {

        });
      }

      if (chosenStatus == 'Tài xế đã đón khách') {
        chosenList.clear();
        for(int i = 0 ; i < orderList.length ; i++) {
          if (orderList.elementAt(i).status == 'C') {
            chosenList.add(orderList.elementAt(i));
            setState(() {

            });
          }
        }
        setState(() {

        });
      }

      if (chosenStatus == 'Đơn hoàn thành') {
        chosenList.clear();
        for(int i = 0 ; i < orderList.length ; i++) {
          if (orderList.elementAt(i).status == 'D') {
            chosenList.add(orderList.elementAt(i));
            setState(() {

            });
          }
        }
        setState(() {

        });
      }

      if (chosenStatus == 'Đơn bị khách hủy') {
        chosenList.clear();
        for(int i = 0 ; i < orderList.length ; i++) {
          if (orderList.elementAt(i).status == 'E') {
            chosenList.add(orderList.elementAt(i));
            setState(() {

            });
          }
        }
        setState(() {

        });
      }

      if (chosenStatus == 'Đơn bị admin hủy') {
        chosenList.clear();
        for(int i = 0 ; i < orderList.length ; i++) {
          if (orderList.elementAt(i).status == 'E1') {
            chosenList.add(orderList.elementAt(i));
            setState(() {

            });
          }
        }
        setState(() {

        });
      }
    }

    setState(() {

    });
  }

  void onSearchTextChanged(String value) {
    setState(() {
      chosenList = orderList
          .where((account) =>
      account.id.toLowerCase().contains(value.toLowerCase()) ||
          account.locationSet.mainText.toLowerCase().contains(value.toLowerCase()) ||
          account.locationSet.secondaryText.toLowerCase().contains(value.toLowerCase()) ||
          account.locationGet.mainText.toLowerCase().contains(value.toLowerCase()) ||
          account.locationGet.secondaryText.toLowerCase().contains(value.toLowerCase()) ||
          account.owner.name.toLowerCase().contains(value.toLowerCase()) ||
          account.owner.phone.toLowerCase().contains(value.toLowerCase()) ||
          account.shipper.name.toLowerCase().contains(value.toLowerCase()) ||
          account.shipper.phone.toLowerCase().contains(value.toLowerCase()) ||
          account.id.toString().toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    getDataArea();
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
          Positioned(
            top: 10,
            left: 260,
            child: GestureDetector(
              child: Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.yellow.shade700,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 11, bottom: 11),
                  child: Text(
                    'Tạo đơn mới',
                    style: TextStyle(
                      fontFamily: 'muli',
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return add_bike_order_dialog_step_1();
                  },
                );
              },
            ),
          ),

          Positioned(
            top: 10,
            left: 0,
            child: Container(
              width: 250,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
              ),
              child: TextFormField(
                controller: searchController,
                onChanged: onSearchTextChanged,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'muli',
                ),
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm đơn đặt xe',
                  prefixIcon: Icon(Icons.search, color: Colors.grey,),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: 'muli',
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 10,
            right: 0,
            child: Container(
              width: 200,
              height: 40,
              child: DropdownButton<Area>(
                items: areaList.map((e) => DropdownMenuItem<Area>(
                  value: e,
                  child: Text('Khu vực : ' + e.name),
                )).toList(),
                onChanged: (value) { dropdownCallback(value); },
                value: chosenArea,
                iconEnabledColor: Colors.redAccent,
                isExpanded: true,
                iconDisabledColor: Colors.grey,
              ),
            ),
          ),

          Positioned(
            top: 80,
            left: 10,
            child: heading_title(numberColumn: 4, listTitle: ['Mã đơn lái hộ', 'Điểm đón khách', 'Trạng thái đơn', 'Thao tác'], width: width - 20, height: 50),
          ),

          Positioned(
            top: 130,
            left: 10,
            bottom: 10,
            child: Container(
              width: width - 20,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
              ),
              child: ListView.builder(
                itemCount: chosenList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return bike_order_item(order: chosenList[index], index: index);
                },
              ),
            ),
          )

        ],
      ),
    );
  }
}
