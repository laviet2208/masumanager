import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20th%C3%B4ng%20b%C3%A1o/Item%20trong%20danh%20s%C3%A1ch.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20th%C3%B4ng%20b%C3%A1o/Notification.dart';
import '../../dataClass/Time.dart';
import '../../dataClass/accountShop.dart';
import '../../utils/utils.dart';
import '../Quản lý khu vực và tài khoản admin/Area.dart';
import '../Quản lý khu vực và tài khoản admin/Tài khoản admin khu vực/Page tìm kiếm.dart';
import 'Droplistnguoinhan.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

class Pagequanlythongbao extends StatefulWidget {
  final double width;
  final double height;
  const Pagequanlythongbao({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Pagequanlythongbao> createState() => _PagequanlythongbaoState();
}

class _PagequanlythongbaoState extends State<Pagequanlythongbao> {
  bool loading = false;
  final accountShop shop = accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '', OpenStatus: 0);
  final tieudecontrol = TextEditingController();
  final tieudephucontrol = TextEditingController();
  final noidungcontrol = TextEditingController();
  Area chosenArea = Area(id: '', name: '', money: 0, status: 0);
  List<Area> areaList = [];
  List<Area> areaList1 = [];
  Area area = Area(id: '', name: '', money: 0, status: 0);
  List<notification> list = [];
  List<notification> chosenList = [];

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

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Notification").onValue.listen((event) {
      list.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        notification noti = notification.fromJson(value);
        list.add(noti);
        chosenList.add(noti);
      });
      setState(() {

      });
    });
  }

  TextEditingController searchController = TextEditingController();

  void onSearchTextChanged(String value) {
    setState(() {
      chosenList = list
          .where((account) =>
      account.Title.toLowerCase().contains(value.toLowerCase()) ||
          account.Sub.toLowerCase().contains(value.toLowerCase()) ||
          account.Content.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }


  Future<void> pushData(notification notification) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Notification').child(notification.id).set(notification.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Thêm thông báo thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  void dropdownCallback(Area? selectedValue) {
    if (selectedValue is Area) {
      chosenArea = selectedValue;
      if (chosenArea.id == 'all') {
        chosenList.clear();
        for(int i = 0 ; i < list.length ; i++) {
          chosenList.add(list.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      } else {
        chosenList.clear();
        for(int i = 0 ; i < list.length ; i++) {
          if (list.elementAt(i).Area == chosenArea.id) {
            chosenList.add(list.elementAt(i));
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
    getData1();
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
            top: 10,
            left: 10,
            child: GestureDetector(
              child: Container(
                width: 220,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text(
                  '+ Thêm thông báo mới',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontFamily: 'roboto',
                      fontSize: 14
                  ),
                ),
              ),
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Thêm thông báo mới'),
                        content: Container(
                          width: widget.width * (1.5/3),
                          height: widget.height * (2/3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
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
                                  'Tiêu đề thông báo *',
                                  style: TextStyle(
                                      fontFamily: 'roboto',
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
                                          controller: tieudecontrol,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'roboto',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Tiêu đề thông báo',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                              fontFamily: 'roboto',
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
                                  'Tiêu đề phụ thông báo *',
                                  style: TextStyle(
                                      fontFamily: 'roboto',
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
                                          controller: tieudephucontrol,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'roboto',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Tiêu đề thông báo',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                              fontFamily: 'roboto',
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
                                  'Nội dung thông báo *',
                                  style: TextStyle(
                                      fontFamily: 'roboto',
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
                                          controller: noidungcontrol,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'roboto',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Nội dung thông báo',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                              fontFamily: 'roboto',
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
                                  'Chọn loại người nhận *',
                                  style: TextStyle(
                                      fontFamily: 'roboto',
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
                                  child: Droplistnguoinhan(width: widget.width * (1.5/3), shop: shop)
                              ),

                              Container(
                                height: 10,
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Chọn khu vực quản lý *',
                                  style: TextStyle(
                                      fontFamily: 'roboto',
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

                              Container(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Hủy'),
                              onPressed: () {
                                tieudecontrol.clear();
                                noidungcontrol.clear();
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: loading ? CircularProgressIndicator() : Text('Lưu'),
                              onPressed: loading ? null : () async {
                                setState(() {
                                  loading = true;
                                });

                                if (tieudecontrol.text.isNotEmpty && noidungcontrol.text.isNotEmpty && area.id != '') {
                                  notification noti = notification(
                                      id: dataCheckManager.generateRandomString(20),
                                      Area: area.id,
                                      Title: tieudecontrol.text.toString(),
                                      Sub: tieudephucontrol.text.toString(),
                                      object: shop.Type,
                                      create: Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year),
                                      send: Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year),
                                      status: 1,
                                      Content: noidungcontrol.text.toString()
                                  );
                                  await pushData(noti);
                                  setState(() {
                                    loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
                                  });

                                  tieudecontrol.clear();
                                  noidungcontrol.clear();
                                  Navigator.of(context).pop();
                                } else {
                                  toastMessage('Phải nhập đủ thông tin');
                                  setState(() {
                                    loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
                                  });
                                }
                              },
                            ),
                          ]
                      );
                    }
                    );
              },
              ),
            ),

          Positioned(
            top: 10,
            left: 250,
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
                  hintText: 'Tìm kiếm theo tiêu đề và nội dung',
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
                    width: (widget.width - 20)/4 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Tiêu đề và nội dung',
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
                    width: (widget.width - 20)/4 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Đối tượng nhận',
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
                    width: (widget.width - 20)/4 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thời gian',
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
                    width: (widget.width - 20)/4 - 1,
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
              height: widget.height - 140,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
              ),
              child: ListView.builder(
                itemCount: chosenList.length,
                itemBuilder: (context, index) {
                  return Itemdanhsachtb(width: widget.width - 20, notice: chosenList[index], color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
