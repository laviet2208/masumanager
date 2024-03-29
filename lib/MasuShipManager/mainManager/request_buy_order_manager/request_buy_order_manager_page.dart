import 'package:flutter/material.dart';
import '../../Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import '../../Data/areaData/Area.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'action/add_buy_request_order/add_buy_request_order.dart';
import 'action/caculate_free_request_order_money/item_buy_request_order.dart';

class request_buy_order_manager_page extends StatefulWidget {
  const request_buy_order_manager_page({Key? key}) : super(key: key);

  @override
  State<request_buy_order_manager_page> createState() => _request_buy_order_manager_pageState();
}

class _request_buy_order_manager_pageState extends State<request_buy_order_manager_page> {
  List<requestBuyOrder> orderList = [];
  List<requestBuyOrder> chosenList = [];
  List<Area> areaList = [];
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
        if (value['productList'] != null) {
          requestBuyOrder order = requestBuyOrder.fromJson(value);
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

  void sortChosenListByCreateTime(List<requestBuyOrder> chosenList) {
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
          account.id.toString().toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    getDataArea();
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
            left: 370,
            child: GestureDetector(
              child: Container(
                height: 40,
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.yellow.shade700,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 11, bottom: 11),
                  child: AutoSizeText(
                    'Tạo đơn mới',
                    style: TextStyle(
                      fontFamily: 'arial',
                      color: Colors.black,
                      fontSize: 100,
                    ),
                  ),
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return add_buy_request_order();
                  },
                );
              },
            ),
          ),

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
                  hintText: 'Tìm kiếm đơn mua tự do',
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
              width: 300,
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
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 29,
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),

                  Container(
                    width: (width - 20)/6 - 1 - 30,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Mã đơn hàng',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        )
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),

                  Container(
                    width: (width - 20)/6 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Điểm mua, giao hàng',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        )
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),

                  Container(
                    width: (width - 20)/6 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Chi tiết đơn',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        )
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),

                  Container(
                    width: (width - 20)/6 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Chiết khấu',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        )
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),

                  Container(
                    width: (width - 20)/6 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Ngày tạo',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        )
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),

                  Container(
                    width: (width - 20)/6 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thao tác',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'arial',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        )
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 240, 240, 240)
                    ),
                  ),
                ],
              ),
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
                  return item_buy_request_order(order: chosenList[index], index: index);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
