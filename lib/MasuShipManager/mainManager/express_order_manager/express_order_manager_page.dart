import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/expressOrder/expressOrder.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../Data/areaData/Area.dart';
import '../ingredient/heading_title.dart';
import 'express_order_item.dart';

class express_order_manager_page extends StatefulWidget {
  const express_order_manager_page({super.key});

  @override
  State<express_order_manager_page> createState() => _express_order_manager_pageState();
}

class _express_order_manager_pageState extends State<express_order_manager_page> {
  TextEditingController searchController = TextEditingController();
  List<expressOrder> orderList = [];
  List<expressOrder> chosenList = [];
  List<Area> areaList = [];
  List<String> status_list = ['Tất cả','Đơn chưa đẩy', 'Đơn mới đẩy cho tài xế', 'Tài xế đã lấy hàng', 'Đơn hoàn thành', 'Đơn bị khách hủy', 'Đơn bị admin hủy'];
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
        if (value['item'] != null) {
          expressOrder order = expressOrder.fromJson(value);
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

  void sortChosenListByCreateTime(List<expressOrder> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
      return b.S1time.year.compareTo(a.S1time.year) != 0
          ? b.S1time.year.compareTo(a.S1time.year)
          : (b.S1time.month.compareTo(a.S1time.month) != 0
          ? b.S1time.month.compareTo(a.S1time.month)
          : (b.S1time.day.compareTo(a.S1time.day) != 0
          ? b.S1time.day.compareTo(a.S1time.day)
          : (b.S1time.hour.compareTo(a.S1time.hour) != 0
          ? b.S1time.hour.compareTo(a.S1time.hour)
          : (b.S1time.minute.compareTo(a.S1time.minute) != 0
          ? b.S1time.minute.compareTo(a.S1time.minute)
          : b.S1time.second.compareTo(a.S1time.second)))));
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
          account.item.toLowerCase().contains(value.toLowerCase()) ||
          account.receiver.name.toLowerCase().contains(value.toLowerCase()) ||
          account.receiver.phone.toLowerCase().contains(value.toLowerCase()) ||
          account.sender.name.toLowerCase().contains(value.toLowerCase()) ||
          account.sender.phone.toLowerCase().contains(value.toLowerCase()) ||
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
            child: heading_title(numberColumn: 5, listTitle: ['Mã đơn Express', 'Điểm lấy, giao hàng', 'Chi tiết đơn', 'Thanh toán', 'Thao tác'], width: width - 20, height: 50),
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
                  return express_order_item(order: chosenList[index], index: index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
