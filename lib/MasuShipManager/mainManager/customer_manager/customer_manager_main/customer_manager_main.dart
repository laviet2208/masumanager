import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/mainManager/customer_manager/customer_manager_main/customer_item.dart';
import 'package:masumanager/MasuShipManager/mainManager/ingredient/heading_title.dart';
import '../../../Data/accountData/userAccount.dart';
import '../../../Data/areaData/Area.dart';

class customer_manager_main extends StatefulWidget {
  const customer_manager_main({super.key});

  @override
  State<customer_manager_main> createState() => _customer_manager_mainState();
}

class _customer_manager_mainState extends State<customer_manager_main> {
  List<UserAccount> userList = [];
  List<UserAccount> chosenList = [];
  List<String> status_list = ['Tất cả','Đang mở', 'Đang khoá',];
  String chosenStatus = '';
  List<Area> areaList = [];
  TextEditingController searchController = TextEditingController();
  Area chosenArea = Area(id: '', name: '', money: 0, status: 0);

  void get_user_list() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Account").onValue.listen((event) {
      userList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        if (value['license'] == null) {
          UserAccount account = UserAccount.fromJson(value);
          userList.add(account);
          chosenList.add(account);
        }
      });
      setState(() {

      });
    });
  }

  void get_area_data() {
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

  void on_search_text_changed(String value) {
    setState(() {
      chosenList = userList.where((account) => account.phone.toLowerCase().contains(value.toLowerCase()) || account.name.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  void drop_down_area(Area? selectedValue) {
    if (selectedValue is Area) {
      chosenArea = selectedValue;
      if (chosenArea.id == 'all') {
        chosenList.clear();
        for(int i = 0 ; i < userList.length ; i++) {
          chosenList.add(userList.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      } else {
        chosenList.clear();
        for(int i = 0 ; i < userList.length ; i++) {
          if (userList.elementAt(i).area == chosenArea.id) {
            chosenList.add(userList.elementAt(i));
            setState(() {

            });
          }
        }
      }

    }

    setState(() {

    });
  }

  void drop_down_status_account(String? selectedValue) {
    if (selectedValue is String) {
      chosenStatus = selectedValue;
      if (chosenStatus == 'Tất cả') {
        chosenList.clear();
        for(int i = 0 ; i < userList.length ; i++) {
          chosenList.add(userList.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      }

      if (chosenStatus == 'Đang mở') {
        chosenList.clear();
        for(int i = 0 ; i < userList.length ; i++) {
          if (userList.elementAt(i).lockStatus == 1) {
            chosenList.add(userList.elementAt(i));
            setState(() {

            });
          }
        }
        setState(() {

        });
      }

      if (chosenStatus == 'Đang khóa') {
        chosenList.clear();
        for(int i = 0 ; i < userList.length ; i++) {
          if (userList.elementAt(i).lockStatus == 0) {
            chosenList.add(userList.elementAt(i));
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chosenStatus = status_list.first;
    get_user_list();
    get_area_data();
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
          //tìm kiếm
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              width: 280,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
              ),
              child: TextFormField(
                controller: searchController,
                onChanged: on_search_text_changed,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'muli',
                ),
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm theo tên và số điện thoại',
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

          //chọn theo khu vực
          Positioned(
            top: 10,
            right: 0,
            child: Container(
              width: 250,
              height: 40,
              child: DropdownButton<Area>(
                items: areaList.map((e) => DropdownMenuItem<Area>(
                  value: e,
                  child: Text('Khu vực : ' + e.name),
                )).toList(),
                onChanged: (value) { drop_down_area(value); },
                value: chosenArea,
                iconEnabledColor: Colors.redAccent,
                isExpanded: true,
                iconDisabledColor: Colors.grey,
              ),
            ),
          ),

          //chọn theo trạng thái
          Positioned(
            top: 10,
            right: 270,
            child: Container(
              width: 250,
              height: 40,
              child: DropdownButton<String>(
                items: status_list.map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                )).toList(),
                onChanged: (value) { drop_down_status_account(value); },
                value: chosenStatus,
                iconEnabledColor: Colors.redAccent,
                isExpanded: true,
                iconDisabledColor: Colors.grey,
              ),
            ),
          ),

          //Thanh head thông tin
          Positioned(
            top: 70,
            left: 10,
            child: heading_title(numberColumn: 4, listTitle: ['Tài khoản', 'Vị trí', 'Trạng thái', 'Thao tác'], width: width-20, height: 50),
          ),

          Positioned(
            top: 125,
            bottom: 10,
            left: 10,
            child: Container(
              width: width - 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
              ),
              child: (chosenList.length == 0) ? Text('Danh sách trống') : ListView.builder(
                  itemCount: chosenList.length,
                  itemBuilder: (context, index) {
                    return customer_item(index: index, account: chosenList[index]);
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
