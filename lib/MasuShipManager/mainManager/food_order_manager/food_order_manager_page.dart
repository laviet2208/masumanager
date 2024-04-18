import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:masumanager/MasuShipManager/mainManager/food_order_manager/item_food_order.dart';
import '../../Data/areaData/Area.dart';
import '../ingredient/heading_title.dart';

class food_order_manager_page extends StatefulWidget {
  const food_order_manager_page({super.key});

  @override
  State<food_order_manager_page> createState() => _food_order_manager_pageState();
}

class _food_order_manager_pageState extends State<food_order_manager_page> {
  List<foodOrder> orderList = [];
  List<foodOrder> chosenList = [];
  List<Area> areaList = [];
  String chosenStatus = '';
  List<String> status_list = ['Tất cả','Đơn chưa đẩy', 'Đơn đã đẩy cho tài xế', 'Tài xế đã mua xong', 'Đơn hoàn thành', 'Đơn bị hủy'];
  TextEditingController searchController = TextEditingController();
  Area chosenArea = Area(id: '', name: '', money: 0, status: 0);

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").onValue.listen((event) {
      orderList.clear();
      chosenList.clear();
      setState(() {

      });
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        if (value['shopList'] != null) {
          foodOrder order = foodOrder.fromJson(value);
          orderList.add(order);
          chosenList.add(order);
          setState(() {
            sortChosenListByCreateTime(chosenList);
          });
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
          account.productList.map((e) => e.toJson()).toList().toString().contains(value.toLowerCase())||
          account.shopList.map((e) => e.toJson()).toList().toString().contains(value.toLowerCase())||
          account.shipper.name.toLowerCase().contains(value.toLowerCase()) ||
          account.shipper.phone.toLowerCase().contains(value.toLowerCase()) ||
          account.id.toString().toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void sortChosenListByCreateTime(List<foodOrder> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
      return b.timeList[0].year.compareTo(a.timeList[0].year) != 0
          ? b.timeList[0].year.compareTo(a.timeList[0].year)
          : (b.timeList[0].month.compareTo(a.timeList[0].month) != 0
          ? b.timeList[0].month.compareTo(a.timeList[0].month)
          : (b.timeList[0].day.compareTo(a.timeList[0].day) != 0
          ? b.timeList[0].day.compareTo(a.timeList[0].day)
          : (b.timeList[0].hour.compareTo(a.timeList[0].hour) != 0
          ? b.timeList[0].hour.compareTo(a.timeList[0].hour)
          : (b.timeList[0].minute.compareTo(a.timeList[0].minute) != 0
          ? b.timeList[0].minute.compareTo(a.timeList[0].minute)
          : b.timeList[0].second.compareTo(a.timeList[0].second)))));
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
            left: 10,
            child: Container(
              width: 350,
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
                  hintText: 'Tìm kiếm đơn đồ ăn',
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
            right: 10,
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
            child: Container(
              width: width - 20,
              height: 50,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 250, 255),
                  border: Border.all(
                      width: 1,
                      color: Color.fromARGB(255, 225, 225, 226)
                  )
              ),
              child: heading_title(numberColumn: 5, listTitle: ['Mã đơn hàng', 'Điểm mua, giao hàng', 'Chi tiết đơn', 'Thanh toán', 'Thao tác'], width: width - 20, height: 50),
            ),
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
                  return item_food_order(order: chosenList[index], index: index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
