import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/mainManager/notice_manager/actions/add_notice.dart';
import 'package:masumanager/MasuShipManager/mainManager/notice_manager/item_notice.dart';
import '../../Data/areaData/Area.dart';
import '../../Data/noticeData/noticeData.dart';

class notice_manager_page extends StatefulWidget {
  const notice_manager_page({super.key});

  @override
  State<notice_manager_page> createState() => _notice_managerState();
}

class _notice_managerState extends State<notice_manager_page> {
  List<noticeData> noticeList = [];
  List<noticeData> chosenList = [];
  String chosenReceiver = '';
  List<String> receiverList = ['Tất cả','Khách hàng','Shipper'];
  Area chosenArea = Area(id: '', name: '', money: 0, status: 0);
  List<Area> areaList = [];
  TextEditingController searchController = TextEditingController();

  void onSearchTextChanged(String value) {
    setState(() {
      chosenList = noticeList
          .where((account) =>
          account.title.toLowerCase().contains(value.toLowerCase()) ||
          account.sub.toLowerCase().contains(value.toLowerCase()) ||
          account.content.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void drop_down_receiver(String? selectedValue) {
    if (selectedValue is String) {
      chosenReceiver = selectedValue;
      if (chosenReceiver == 'Tất cả') {
        chosenList.clear();
        for (noticeData data in noticeList) {
          chosenList.add(data);
        }
      }

      if (chosenReceiver == 'Người dùng') {
        chosenList.clear();
        for (noticeData data in noticeList) {
          if (data.object == 0) {
            chosenList.add(data);
          }
        }
      }

      if (chosenReceiver == 'Shipper') {
        chosenList.clear();
        for (noticeData data in noticeList) {
          if (data.object == 1) {
            chosenList.add(data);
          }
        }
      }
    }

    setState(() {

    });
  }

  void dropdownCallback(Area? selectedValue) {
    if (selectedValue is Area) {
      chosenArea = selectedValue;
      if (chosenArea.id == 'all') {
        chosenList.clear();
        for(int i = 0 ; i < noticeList.length ; i++) {
          chosenList.add(noticeList.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      } else {
        chosenList.clear();
        for(int i = 0 ; i < noticeList.length ; i++) {
          if (noticeList.elementAt(i).area == chosenArea.id) {
            chosenList.add(noticeList.elementAt(i));
            setState(() {

            });
          }
        }
      }

    }

    setState(() {

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

  void get_notice_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Notification").onValue.listen((event) {
      noticeList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        noticeList.add(noticeData.fromJson(value));
        chosenList.add(noticeData.fromJson(value));
      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataArea();
    get_notice_data();
    chosenReceiver = receiverList.first;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 80;
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
                  color: Colors.yellow,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 11, bottom: 11),
                  child: Text(
                    'Tạo thông báo',
                    style: TextStyle(
                      fontFamily: 'muli',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return add_notice();
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
                  hintText: 'Tìm kiếm quảng cáo',
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
            top: 10,
            right: 220,
            child: Container(
              width: 200,
              height: 40,
              child: DropdownButton<String>(
                items: receiverList.map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                )).toList(),
                onChanged: (value) { drop_down_receiver(value); },
                value: chosenReceiver,
                iconEnabledColor: Colors.redAccent,
                isExpanded: true,
                iconDisabledColor: Colors.grey,
              ),
            ),
          ),

          Positioned(
            top: 80,
            left: 0,
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
                    width: (width - 50)/4 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Tiêu đề và nội dung',
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
                    width: (width - 50)/4 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Đối tượng',
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
                    width: (width - 50)/4 - 1,
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
                    width: (width - 50)/4 - 1,
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
            bottom: 5,
            child: chosenList.length != 0 ?Container(
              width: width,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: chosenList.length,
                itemBuilder: (context, index) {
                  return item_notice(notice: chosenList[index], index: index);
                },
              ),
            ): Container(alignment: Alignment.center, child: Text('Danh sách trống'),),
          )
        ],
      ),
    );
  }
}
