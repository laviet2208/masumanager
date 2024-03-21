import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../Data/accountData/shopData/shopAccount.dart';
import '../../../Data/areaData/Area.dart';
import '../actions/partner_restaurant_actions/add_partner_restaurant.dart';
import 'item_partner_restaurant.dart';

class partner_restaurant_manager extends StatefulWidget {
  const partner_restaurant_manager({super.key});

  @override
  State<partner_restaurant_manager> createState() => _partner_restaurant_managerState();
}

class _partner_restaurant_managerState extends State<partner_restaurant_manager> {
  TextEditingController searchController = TextEditingController();
  List<ShopAccount> restaurant_list = [];
  List<ShopAccount> chosenList = [];
  List<String> status_list = ['Tất cả','5 sao','Ăn vặt','Bún phở','Cơm','Khuyến mãi','Món nhậu','Nước uống','Thức ăn nhanh','Trà sữa'];
  String chosenStatus = '';


  List<Area> areaList = [];
  Area chosenArea = Area(id: '', name: '', money: 0, status: 0);

  //Bộ các hàm tương tác với firebase
  void get_partner_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Restaurant").orderByChild('discount_type').equalTo(1).onValue.listen((event) {
      restaurant_list.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        ShopAccount shopAccount= ShopAccount.fromJson(value);
        restaurant_list.add(shopAccount);
        chosenList.add(shopAccount);
        sortChosenListByCreateTime(chosenList);
      });
      setState(() {

      });
    });
  }

  void get_area_list() {
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
  
  //Bộ các hàm sắp xếp
  void sortChosenListByCreateTime(List<ShopAccount> chosenList) {
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

  void sortChosenListAZ(List<ShopAccount> chosenList) {
    chosenList.sort((a, b) => a.name.compareTo(b.name));
  }

  void dropdownCallback(Area? selectedValue) {
    if (selectedValue is Area) {
      chosenArea = selectedValue;
      if (chosenArea.id == 'all') {
        chosenList.clear();
        for(int i = 0 ; i < restaurant_list.length ; i++) {
          chosenList.add(restaurant_list.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      } else {
        chosenList.clear();
        for(int i = 0 ; i < restaurant_list.length ; i++) {
          if (restaurant_list.elementAt(i).area == chosenArea.id) {
            chosenList.add(restaurant_list.elementAt(i));
            setState(() {

            });
          }
        }
      }

    }

    setState(() {

    });
  }

  void drop_down_status_restaurant(String? selectedValue) {
    if (selectedValue is String) {
      chosenStatus = selectedValue;
      if (chosenStatus == 'Tất cả') {
        chosenList.clear();
        for(int i = 0 ; i < restaurant_list.length ; i++) {
          chosenList.add(restaurant_list.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      } else {
        int index = -1;
        for (int i = 0; i < status_list.length; i++) {
          if (chosenStatus == status_list[i]) {
            index = i - 1;
            break;
          }
        }

        chosenList.clear();
        for(int i = 0 ; i < restaurant_list.length ; i++) {
          if (restaurant_list[i].type == index) {
            chosenList.add(restaurant_list.elementAt(i));
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
      chosenList = restaurant_list
          .where((account) =>
      account.name.toLowerCase().contains(value.toLowerCase()) ||
          account.phone.toLowerCase().contains(value.toLowerCase()) ||
          account.id.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chosenStatus = status_list.first;
    get_partner_data();
    get_area_list();
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
          //Tìm kiếm nhà hàng
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
                  fontFamily: 'roboto',
                ),
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm nhà hàng',
                  prefixIcon: Icon(Icons.search, color: Colors.grey,),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: 'roboto',
                  ),
                ),
              ),
            ),
          ),

          //Thêm nhà hàng
          Positioned(
            top: 10,
            left: 250,
            child: GestureDetector(
              child: Container(
                height: 40,
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                ),
                child: Center(
                  child: Text(
                    'Thêm nhà hàng',
                    style: TextStyle(
                        fontFamily: 'roboto',
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
                    return add_partner_restaurant();
                  },
                );
              },
            ),
          ),

          //Lọc theo khu vực
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

          //Lọc theo thể loại
          Positioned(
            top: 10,
            right: 210,
            child: Container(
              width: 200,
              height: 40,
              child: DropdownButton<String>(
                items: status_list.map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                )).toList(),
                onChanged: (value) { drop_down_status_restaurant(value); },
                value: chosenStatus,
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
                          'Thời gian hoạt động',
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
                          'Địa chỉ nhà hàng',
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
                          'Trạng thái',
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
            bottom: 0,
            left: 0,
            right: 0,
            child: ListView.builder(
              itemCount: chosenList.length,
              itemBuilder: (context, index) {
                return item_partner_restaurant(account: chosenList[index], index: index);
              },
            ),
          )
        ],
      ),
    );
  }
}