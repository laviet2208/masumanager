import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20kh%C3%A1ch%20h%C3%A0ng/accountNormal.dart';
import 'package:masumanager/dataClass/FinalClass.dart';

import '../../Mainmanager/Quản lý khu vực và tài khoản admin/Area.dart';
import '../../Mainmanager/Quản lý khu vực và tài khoản admin/Tài khoản admin khu vực/Page tìm kiếm.dart';
import '../../utils/utils.dart';

class UpdateDriver extends StatefulWidget {
  final accountNormal driver;
  const UpdateDriver({Key? key, required this.driver}) : super(key: key);

  @override
  State<UpdateDriver> createState() => _UpdateDriverState();
}

class _UpdateDriverState extends State<UpdateDriver> {
  Area area = Area(id: '', name: '', money: 0, status: 0);
  int index = 2;
  String chosenVehicle = 'Xe máy';
  List<Area> areaList = [];
  List<String> vehicles = ['Xe máy','Ô tô'];
  final TextEditingController name = TextEditingController();
  final TextEditingController money = TextEditingController();
  final TextEditingController biensoxe = TextEditingController();

  Future<String> _getImageURL(String imagePath) async {
    final ref = FirebaseStorage.instance.ref().child('CCCD').child(imagePath);
    final url = await ref.getDownloadURL();
    print(url);
    return url;
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
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Area area= Area.fromJson(value);
        areaList.add(area);
      });
      setState(() {

      });
    });
  }

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      chosenVehicle = selectedValue;
      if (chosenVehicle == 'Xe máy') {
        index = 2;
      } else {
        index = 3;
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
    if (currentAccount.provinceCode != '0') {
      area.id = currentAccount.provinceCode;
    }
    name.text = widget.driver.name.toString();
    money.text = widget.driver.totalMoney.toString();
    biensoxe.text = widget.driver.license.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cập nhật thông tin tài xế'),
      content: Container(
        width: 500, // Đặt kích thước chiều rộng theo ý muốn
        height: 600, // Đặt kích thước chiều cao theo ý muốn
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
                        controller: name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'roboto',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tên trong app',
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
                'Số dư(VNĐ)',
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
                        controller: money,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'roboto',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Số dư tài khoản',
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
                'Biển số xe',
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
                        controller: biensoxe,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'roboto',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Số dư tài khoản',
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
                'Loại phương tiện',
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
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Container(
                height: 40,
                child: DropdownButton<String>(
                  items: vehicles.map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e),
                  )).toList(),
                  onChanged: (value) { dropdownCallback(value); },
                  value: chosenVehicle,
                  iconEnabledColor: Colors.redAccent,
                  isExpanded: true,
                  iconDisabledColor: Colors.grey,
                ),
              ),
            ),

            Container(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Ảnh thông tin',
                style: TextStyle(
                    fontFamily: 'roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 180,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Colors.grey
                          ),
                        ),
                        child: FutureBuilder(
                          future: _getImageURL(widget.driver.id + '_LT.png'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            if (snapshot.hasError) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text('Ảnh lỗi hoặc chưa có ảnh',style: TextStyle(color: Colors.black, fontFamily: 'roboto'),textAlign: TextAlign.center,),
                              );                                                        }

                            if (!snapshot.hasData) {
                              return Text('Image not found');
                            }

                            return Image.network(snapshot.data.toString(),fit: BoxFit.fitHeight,);
                          },
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      left: 30,
                      child: Container(
                        width: 150,
                        alignment: Alignment.center,
                        child: Text(
                          'Mặt sau Giấy phép',
                          style: TextStyle(
                              fontFamily: 'roboto',
                              fontSize: 14,
                              color: Colors.redAccent
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      right: 30,
                      child: Container(
                        width: 150,
                        alignment: Alignment.center,
                        child: Text(
                          'Mặt trước Giấy phép',
                          style: TextStyle(
                              fontFamily: 'roboto',
                              fontSize: 14,
                              color: Colors.redAccent
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 0,
                      right: 30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Colors.grey
                          ),
                        ),
                        child: FutureBuilder(
                          future: _getImageURL(widget.driver.id + '_LS.png'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            if (snapshot.hasError) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text('Ảnh lỗi hoặc chưa có ảnh',style: TextStyle(color: Colors.black, fontFamily: 'roboto'),textAlign: TextAlign.center,),
                              );                                                        }

                            if (!snapshot.hasData) {
                              return Text('Image not found');
                            }

                            return Image.network(snapshot.data.toString(),fit: BoxFit.fitHeight,);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 180,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Colors.grey
                          ),
                        ),
                        child: FutureBuilder(
                          future: _getImageURL(widget.driver.id + '_T.png'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            if (snapshot.hasError) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text('Ảnh lỗi hoặc chưa có ảnh',style: TextStyle(color: Colors.black, fontFamily: 'roboto'),textAlign: TextAlign.center,),
                              );                                                        }

                            if (!snapshot.hasData) {
                              return Text('Image not found');
                            }

                            return Image.network(snapshot.data.toString(),fit: BoxFit.fitHeight,);
                          },
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      left: 30,
                      child: Container(
                        width: 150,
                        alignment: Alignment.center,
                        child: Text(
                          'Mặt sau CCCD',
                          style: TextStyle(
                              fontFamily: 'roboto',
                              fontSize: 14,
                              color: Colors.redAccent
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      right: 30,
                      child: Container(
                        width: 150,
                        alignment: Alignment.center,
                        child: Text(
                          'Mặt trước CCCD',
                          style: TextStyle(
                              fontFamily: 'roboto',
                              fontSize: 14,
                              color: Colors.redAccent
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 0,
                      right: 30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Colors.grey
                          ),
                        ),
                        child: FutureBuilder(
                          future: _getImageURL(widget.driver.id + '_S.png'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            if (snapshot.hasError) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text('Ảnh lỗi hoặc chưa có ảnh',style: TextStyle(color: Colors.black, fontFamily: 'roboto'),textAlign: TextAlign.center,),
                              );                                                        }

                            if (!snapshot.hasData) {
                              return Text('Image not found');
                            }

                            return Image.network(snapshot.data.toString(),fit: BoxFit.fitHeight,);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 180,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 175,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Colors.grey
                          ),
                        ),
                        child: FutureBuilder(
                          future: _getImageURL(widget.driver.id + '_Ava.png'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            if (snapshot.hasError) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text('Ảnh lỗi hoặc chưa có ảnh',style: TextStyle(color: Colors.black, fontFamily: 'roboto'),textAlign: TextAlign.center,),
                              );
                            }

                            if (!snapshot.hasData) {
                              return Text('Image not found');
                            }

                            return Image.network(snapshot.data.toString(),fit: BoxFit.fitHeight,);
                          },
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      left: 175,
                      child: Container(
                        width: 150,
                        alignment: Alignment.center,
                        child: Text(
                          'Ảnh chân dung',
                          style: TextStyle(
                              fontFamily: 'roboto',
                              fontSize: 14,
                              color: Colors.redAccent
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: currentAccount.provinceCode == '0' ? 150 : 0,
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
            money.clear();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child:Text('Lưu'),
          onPressed: () async {
            if (name.text.isNotEmpty && money.text.isNotEmpty && biensoxe.text.isNotEmpty && area.id != '') {
              widget.driver.name = name.text.toString();
              widget.driver.totalMoney = double.parse(money.text.toString());
              widget.driver.license = biensoxe.text.toString();
              widget.driver.type = index;
              widget.driver.Area = (currentAccount.provinceCode == '0' ? area.id : currentAccount.provinceCode);
              await pushData(widget.driver);
              Navigator.of(context).pop();
            } else {
              toastMessage('Điền đủ các mục rồi tiếp tục');
            }
          },
        ),
      ],
    );
  }
}
