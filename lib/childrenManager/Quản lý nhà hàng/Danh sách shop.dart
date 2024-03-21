import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20nh%C3%A0%20h%C3%A0ng/DropList%20th%E1%BB%83%20lo%E1%BA%A1i.dart';
import 'package:masumanager/dataClass/FinalClass.dart';
import 'package:masumanager/dataClass/accountShop.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../Mainmanager/Quản lý khu vực và tài khoản admin/Area.dart';
import '../../Mainmanager/Quản lý nhà hàng/Chỉnh sửa shop.dart';
import '../../Mainmanager/Quản lý nhà hàng/ITEMinPage.dart';
import '../../Mainmanager/Quản lý nhà hàng/Thêm cửa hàng.dart';
import '../../dataClass/Time.dart';
import '../../utils/utils.dart';

class PageQuanlyshop extends StatefulWidget {
  final double width;
  final double height;
  const PageQuanlyshop({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<PageQuanlyshop> createState() => _PageQuanlyshopState();
}

class _PageQuanlyshopState extends State<PageQuanlyshop> {
  final tennhahangcontrol = TextEditingController();
  final sdtcontrol = TextEditingController();
  final avatarcontrol = TextEditingController();
  final locationcontrol = TextEditingController();
  final passcontrol = TextEditingController();
  final startcontrol = TextEditingController();
  final endcontrol = TextEditingController();
  final List<accountShop> shopList = [];
  List<accountShop> chosenList = [];
  List<String> items = ['5 sao','Ăn vặt','Bún phở','Cơm','Khuyến mãi','Món nhậu','Nước uống','Thức ăn nhanh','Trà sữa'];
  final accountShop shop = accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '', OpenStatus: 0);
  int selectIndex = 0;
  bool loading = false;

  Future<void> pushData(accountShop accountShop) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Restaurant').child(accountShop.id).set(accountShop.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Thêm nhà hàng thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Restaurant").onValue.listen((event) {
      shopList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        accountShop food= accountShop.fromJson(value);
        if (food.Area == currentAccount.provinceCode) {
          shopList.add(food);
          chosenList.add(food);
        }
      });
      setState(() {

      });
    });
  }


  TextEditingController searchController = TextEditingController();

  void onSearchTextChanged(String value) {
    setState(() {
      chosenList = shopList
          .where((account) =>
      account.name.toLowerCase().contains(value.toLowerCase()) ||
          account.phoneNum.toLowerCase().contains(value.toLowerCase()) ||
          account.id.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  void sortChosenListByCreateTime(List<accountShop> chosenList) {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            left: 10,
            child: GestureDetector(
              child: Container(
                width: 120,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text(
                  '+ Thêm mới',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontFamily: 'arial',
                      fontSize: 14
                  ),
                ),
              ),
              onTap: () async {
                showDialog (
                  context: context,
                  builder: (BuildContext context) {
                    return Themcuahang(width: widget.width, height: widget.height);
                  },
                );
              },
            ),
          ),

          Positioned(
            top: 80,
            left: 10,
            child: Container(
              width: widget.width - 20,
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
                    width: (widget.width - 20)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Tên nhà hàng',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'roboto',
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
                    width: (widget.width - 20)/5 - 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                      child: Container(
                        width: (widget.width - 20)/5 - 1 - 20,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                height: 20,
                                width: (widget.width - 20)/5 - 1 - 20,
                                child: AutoSizeText(
                                  'Thời gian tạo',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'roboto',
                                      color: Colors.black,
                                      fontSize: 100
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                child: Icon(
                                  Icons.arrow_downward_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                onTap: () {
                                  sortChosenListByCreateTime(chosenList);
                                  setState(() {

                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),

                  Container(
                    width: (widget.width - 20)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thời gian hoạt động',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'roboto',
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
                    width: (widget.width - 20)/5 - 60,
                    alignment: Alignment.center,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Trạng thái tài khoản',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'roboto',
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
                    width: (widget.width - 20)/5 - 1 + 60,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thao tác',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'roboto',
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
            left: 10,
            child: Container(
              width: widget.width - 20,
              height: widget.height - 155,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
              ),
              alignment: Alignment.center,
              child: (chosenList.length == 0) ? Text('không có nhà hàng nào') : ListView.builder(
                itemCount: chosenList.length,
                itemBuilder: (context, index) {
                  return ITEMshop(width: widget.width - 20, height: 120, shop: chosenList[index],
                    updateEvent: () {
                      showDialog (
                        context: context,
                        builder: (BuildContext context) {
                          return Chinhsuashop(width: widget.width, height: widget.height, shop: chosenList[index], data: 'Restaurant',);
                        },
                      );
                    }, color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255), data: 'Restaurant',);
                },
              ),
            ),
          ),

          Positioned(
            top: 20,
            left: 150,
            child: Container(
              width: 500,
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
        ],
      ),
    );
  }
}
