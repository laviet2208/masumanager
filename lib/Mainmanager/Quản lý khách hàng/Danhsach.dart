import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20khu%20v%E1%BB%B1c%20v%C3%A0%20t%C3%A0i%20kho%E1%BA%A3n%20admin/T%C3%A0i%20kho%E1%BA%A3n%20admin%20khu%20v%E1%BB%B1c/Page%20t%C3%ACm%20ki%E1%BA%BFm.dart';

import '../../utils/utils.dart';
import '../Quản lý khu vực và tài khoản admin/Area.dart';
import 'ITEMdskhachhang.dart';
import 'accountNormal.dart';

class Danhsachkhachhang extends StatefulWidget {
  final double width;
  final double height;
  const Danhsachkhachhang({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Danhsachkhachhang> createState() => _DanhsachkhachhangState();
}

class _DanhsachkhachhangState extends State<Danhsachkhachhang> {
  List<accountNormal> accountList = [];
  List<accountNormal> chosenList = [];
  final TextEditingController name = TextEditingController();
  List<Area> areaList = [];
  List<Area> areaList1 = [];
  Area chosenArea = Area(id: '', name: '', money: 0, status: 0);
  Area area = Area(id: '', name: '', money: 0, status: 0);

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("normalUser").onValue.listen((event) {
      accountList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        accountNormal food= accountNormal.fromJson(value);
        if (food.type == 1) {
          accountList.add(food);
          chosenList.add(food);
          sortChosenListByCreateTime(chosenList);
        }

      });
      setState(() {

      });
    });
  }

  Future<void> pushData(accountNormal account) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('normalUser').child(account.id).set(account.toJson());
      toastMessage('Thay đổi thông tin thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").onValue.listen((event) {
      areaList.clear();
      areaList1.clear();
      areaList1.add(Area(id: 'all', name: 'Tất cả', money: 0, status: 0));
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Area area= Area.fromJson(value);
        areaList.add(area);
        areaList1.add(area);
      });
      setState(() {
        if (areaList1.length != 0) {
          chosenArea = areaList1.first;
        }
      });
    });
  }
  TextEditingController searchController = TextEditingController();

  void onSearchTextChanged(String value) {
    setState(() {
      chosenList = accountList
          .where((account) =>
      account.phoneNum.toLowerCase().contains(value.toLowerCase()) || account.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void dropdownCallback(Area? selectedValue) {
    if (selectedValue is Area) {
      chosenArea = selectedValue;
      if (chosenArea.id == 'all') {
        chosenList.clear();
        for(int i = 0 ; i < accountList.length ; i++) {
          chosenList.add(accountList.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      } else {
        chosenList.clear();
        for(int i = 0 ; i < accountList.length ; i++) {
          if (accountList.elementAt(i).Area == chosenArea.id) {
            chosenList.add(accountList.elementAt(i));
            setState(() {

            });
          }
        }
      }

    }

    setState(() {

    });
  }

  void sortChosenListByCreateTime(List<accountNormal> chosenList) {
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
    getData1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              left: 10,
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

            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 400,
                height: 40,
                child: DropdownButton<Area>(
                  items: areaList1.map((e) => DropdownMenuItem<Area>(
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
              top: 70,
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
                      width: (widget.width - 20)/6 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Thông tin tài khoản',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'muli',
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
                      width: (widget.width - 20)/6 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Vị trí hiện tại trong app',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'muli',
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
                      width: (widget.width - 20)/6 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Trạng thái tài khoản',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'muli',
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
                      width: (widget.width - 20)/6 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Thuộc khu vực',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'muli',
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
                      width: (widget.width - 20)/6 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: Container(
                          width: (widget.width - 20)/6 - 1 - 20,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  height: 20,
                                  width: (widget.width - 20)/6 - 1 - 20,
                                  child: AutoSizeText(
                                    'Thời gian tạo',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'muli',
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
                      width: (widget.width - 20)/6 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Thao tác',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 100
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 125,
              left: 10,
              child: Container(
                width: widget.width - 20,
                height: widget.height - 135,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255)
                ),
                child: (chosenList.length == 0) ? Text('Danh sách trống') : ListView.builder(
                    itemCount: chosenList.length,
                    itemBuilder: (context, index) {
                      return ITEMdanhsachkhachhang(width: widget.width, height: 120, account: chosenList[index], color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255) ,
                        onTapUpdate: () async {
                          name.text = accountList[index].name.toString();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Cập nhật thông tin tài xế'),
                                  content: Container(
                                    width: widget.width * (1.5/3), // Đặt kích thước chiều rộng theo ý muốn
                                    height: 170, // Đặt kích thước chiều cao theo ý muốn
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2), // màu của shadow
                                          spreadRadius: 5, // bán kính của shadow
                                          blurRadius: 7, // độ mờ của shadow
                                          offset: Offset(0, 3), // vị trí của shadow
                                        ),
                                      ],
                                    ),
                                    child: ListView(
                                      children: [
                                        Container(
                                          height: 10,
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Tên trong app',
                                            style: TextStyle(
                                                fontFamily: 'arial',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.redAccent
                                            ),
                                          ),
                                        ),

                                        Container(
                                          height: 10,
                                        ),

                                        Padding(
                                            padding: EdgeInsets.only(left: 10, right: 10),
                                            child: Container(
                                              height: 50,
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey.withOpacity(0.3),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: Offset(0, 3),
                                                    ),
                                                  ],
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Colors.black,
                                                  )
                                              ),

                                              child: Padding(
                                                padding: EdgeInsets.only(left: 10),
                                                child: Form(
                                                  child: TextFormField(
                                                    controller: name,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'arial',
                                                    ),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: 'Tên trong app',
                                                      hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16,
                                                        fontFamily: 'arial',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                        ),

                                        Container(
                                          height: 10,
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Chọn khu vực',
                                            style: TextStyle(
                                                fontFamily: 'arial',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.redAccent
                                            ),
                                          ),
                                        ),

                                        Container(
                                          height: 10,
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(left: 10, right: 10),
                                          child: Container(
                                            height: 150,
                                            child: searchPageArea(list: areaList, area: area,),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Hủy'),
                                      onPressed: () {
                                        area.id = '';
                                        name.clear();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child:Text('Lưu'),
                                      onPressed: () async {
                                        if (name.text.isNotEmpty && area.id != '') {
                                          accountList[index].name = name.text.toString();
                                          accountList[index].Area = area.id;
                                          await pushData(accountList[index]);
                                          area.id = '';
                                          name.clear();
                                          Navigator.of(context).pop();
                                        } else {
                                          toastMessage('Điền đủ các mục rồi tiếp tục');
                                        }
                                      },
                                    ),
                                  ],
                                );
                              }
                          );
                        },
                      );
                    }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
