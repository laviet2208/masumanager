import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/mainManager/ads_manager/actions/add_new_ads.dart';
import 'package:masumanager/MasuShipManager/mainManager/ads_manager/item_ads.dart';
import '../../Data/adsData/restaurantAdsData.dart';
import '../../Data/areaData/Area.dart';

class ads_manager extends StatefulWidget {
  const ads_manager({super.key});

  @override
  State<ads_manager> createState() => _ads_managerState();
}

class _ads_managerState extends State<ads_manager> {
  List<String> direction_list = ['Tất cả','Bật ra khi mở app','Trên đầu trang chính','Trong mục đồ ăn',];
  List<restaurantAdsData> ads_list = [];
  List<restaurantAdsData> chosenList = [];
  List<Area> areaList = [];
  Area chosenArea = Area(id: '', name: '', money: 0, status: 0);
  String chosenDirection = '';

  void get_ads_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Ads").onValue.listen((event) {
      ads_list.clear();
      chosenList.clear();
      setState(() {

      });
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        ads_list.add(restaurantAdsData.fromJson(value));
        chosenList.add(restaurantAdsData.fromJson(value));
        setState(() {

        });
      });
      setState(() {

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

  void drop_down_status_order(String? selectedValue) {
    if (selectedValue is String) {
      chosenDirection = selectedValue;
      if (chosenDirection == 'Tất cả') {
        chosenList.clear();
        for(int i = 0 ; i < ads_list.length ; i++) {
          chosenList.add(ads_list.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      } else {
        int index = -1;
        for(int i = 0 ; i < direction_list.length ; i++) {
          if (direction_list[i] == chosenDirection) {
            index = i;
            break;
          }
        }
        chosenList.clear();
        for(int i = 0 ; i < ads_list.length ; i++) {
          if (ads_list.elementAt(i).direction == index) {
            chosenList.add(ads_list.elementAt(i));
            setState(() {

            });
          }
        }
        setState(() {

        });

      }
    }
  }

  void dropdownCallback(Area? selectedValue) {
    if (selectedValue is Area) {
      chosenArea = selectedValue;
      if (chosenArea.id == 'all') {
        chosenList.clear();
        for(int i = 0 ; i < ads_list.length ; i++) {
          chosenList.add(ads_list.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      } else {
        chosenList.clear();
        for(int i = 0 ; i < ads_list.length ; i++) {
          if (ads_list.elementAt(i).area == chosenArea.id) {
            chosenList.add(ads_list.elementAt(i));
            setState(() {

            });
          }
        }
      }

    }

    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_ads_data();
    getDataArea();
    chosenDirection = direction_list.first;
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
          //Thêm ads mới
          Positioned(
            top: 10,
            left: 0,
            child: GestureDetector(
              child: Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  border: Border.all(),
                ),
                child: Center(
                  child: Text(
                    'Thêm ads mới',
                    style: TextStyle(
                        fontFamily: 'muli',
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return add_new_ads();
                  },
                );
              },
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
            top: 10,
            right: 210,
            child: Container(
              width: 200,
              height: 40,
              child: DropdownButton<String>(
                items: direction_list.map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                )).toList(),
                onChanged: (value) { drop_down_status_order(value); },
                value: chosenDirection,
                iconEnabledColor: Colors.redAccent,
                isExpanded: true,
                iconDisabledColor: Colors.grey,
              ),
            ),
          ),

          //Thanh head
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Container(
              width: width,
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
                    width: 49,
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),

                  Container(
                    width: (width - 50)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thông tin quảng cáo',
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
                    width: (width - 50)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thông tin nhà hàng',
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
                    width: (width - 50)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thời gian',
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
                    width: (width - 50)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Vị trí xuất hiện',
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
                    width: (width - 50)/5 - 1,
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
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 130,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              child: ListView.builder(
                itemCount: chosenList.length,
                itemBuilder: (context, index) {
                  return item_ads(index: index, data: chosenList[index]);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
