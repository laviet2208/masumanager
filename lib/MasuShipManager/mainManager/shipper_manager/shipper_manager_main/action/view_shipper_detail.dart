import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shipperAccount.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../../../dataClass/FinalClass.dart';
import '../../../../../utils/utils.dart';
import '../../../../Data/areaData/Area.dart';
import '../../../../Data/models/area_search/search_page_area.dart';
import 'upload_image.dart';

class view_shipper_detail extends StatefulWidget {
  final shipperAccount account;
  const view_shipper_detail({Key? key, required this.account}) : super(key: key);

  @override
  State<view_shipper_detail> createState() => _view_shipper_detailState();
}

class _view_shipper_detailState extends State<view_shipper_detail> {
  Area area = Area(id: '', name: '', money: 0, status: 0);
  int index = 2;
  String chosenVehicle = 'Xe máy';
  List<String> vehicles = ['Xe máy'];
  final TextEditingController name = TextEditingController();
  final TextEditingController money = TextEditingController();
  final TextEditingController biensoxe = TextEditingController();

  Future<String> _getImageURL(String imagePath) async {
    final ref = FirebaseStorage.instance.ref().child('CCCD').child(imagePath);
    final url = await ref.getDownloadURL();
    return url;
  }

  Future<void> push_data_account() async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Account').child(widget.account.id).set(widget.account.toJson());
      toastMessage('Thay đổi thông tin thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
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
    if (currentAccount.provinceCode != '0') {
      area.id = currentAccount.provinceCode;
    }
    name.text = widget.account.name.toString();
    money.text = widget.account.money.toStringAsFixed(0);
    biensoxe.text = widget.account.license.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 30,
        decoration: BoxDecoration(
            color: Colors.yellow,
            border: Border.all(
              width: 0.5,
              color: Colors.black,
            )
        ),
        alignment: Alignment.center,
        child: Text(
          'Thông tin shipper',
          style: TextStyle(
              fontFamily: 'roboto',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13
          ),
        ),
      ),

      onTap: () async {
        showDialog(
          context: context,
          builder: (context) {
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
                                  hintText: 'Biển số xe',
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
                                  future: _getImageURL(widget.account.id + '_LT.png'),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    }

                                    if (snapshot.hasError) {
                                      return Container(
                                        alignment: Alignment.center,
                                        child: Text('Ảnh lỗi hoặc chưa có ảnh',style: TextStyle(color: Colors.black, fontFamily: 'roboto', fontSize: 13),textAlign: TextAlign.center,),
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
                                child: TextButton(
                                  child: Text(
                                    'Mặt sau Giấy phép',
                                    style: TextStyle(
                                        fontFamily: 'roboto',
                                        fontSize: 14,
                                        color: Colors.redAccent
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return upload_image(path: 'CCCD/' + widget.account.id + '_LT.png', title: 'Mặt sau GPLX');
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),

                            Positioned(
                              bottom: 0,
                              right: 30,
                              child: Container(
                                width: 150,
                                alignment: Alignment.center,
                                child: TextButton(
                                  child: Text(
                                    'Mặt trước Giấy phép',
                                    style: TextStyle(
                                        fontFamily: 'roboto',
                                        fontSize: 14,
                                        color: Colors.redAccent
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return upload_image(path: 'CCCD/' + widget.account.id + '_LS.png', title: 'Mặt trước GPLX');
                                      },
                                    );
                                  },
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
                                  future: _getImageURL(widget.account.id + '_LS.png'),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    }

                                    if (snapshot.hasError) {
                                      return Container(
                                        alignment: Alignment.center,
                                        child: Text('Ảnh lỗi hoặc chưa có ảnh',style: TextStyle(color: Colors.black, fontFamily: 'roboto', fontSize: 13),textAlign: TextAlign.center,),
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
                                  future: _getImageURL(widget.account.id + '_T.png'),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    }

                                    if (snapshot.hasError) {
                                      return Container(
                                        alignment: Alignment.center,
                                        child: Text('Ảnh lỗi hoặc chưa có ảnh',style: TextStyle(color: Colors.black, fontFamily: 'roboto', fontSize: 13),textAlign: TextAlign.center,),
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
                                child: TextButton(
                                  child: Text(
                                    'Mặt sau CCCD',
                                    style: TextStyle(
                                        fontFamily: 'roboto',
                                        fontSize: 14,
                                        color: Colors.redAccent
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return upload_image(path: 'CCCD/' + widget.account.id + '_T.png', title: 'Mặt sau CCCD');
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),

                            Positioned(
                              bottom: 0,
                              right: 30,
                              child: Container(
                                width: 150,
                                alignment: Alignment.center,
                                child: TextButton(
                                  child: Text(
                                    'Mặt trước CCCD',
                                    style: TextStyle(
                                        fontFamily: 'roboto',
                                        fontSize: 14,
                                        color: Colors.redAccent
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return upload_image(path: 'CCCD/' + widget.account.id + '_S.png', title: 'Mặt trước CCCD');
                                      },
                                    );
                                  },
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
                                  future: _getImageURL(widget.account.id + '_S.png'),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    }

                                    if (snapshot.hasError) {
                                      return Container(
                                        alignment: Alignment.center,
                                        child: Text('Ảnh lỗi hoặc chưa có ảnh',style: TextStyle(color: Colors.black, fontFamily: 'roboto', fontSize: 13),textAlign: TextAlign.center,),
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
                                  future: _getImageURL(widget.account.id + '_Ava.png'),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    }

                                    if (snapshot.hasError) {
                                      return Container(
                                        alignment: Alignment.center,
                                        child: Text('Ảnh lỗi hoặc chưa có ảnh',style: TextStyle(color: Colors.black, fontFamily: 'roboto', fontSize: 13),textAlign: TextAlign.center,),
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
                                child: TextButton(
                                  child: Text(
                                    'Ảnh đại diện',
                                    style: TextStyle(
                                        fontFamily: 'roboto',
                                        fontSize: 14,
                                        color: Colors.redAccent
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return upload_image(path: 'CCCD/' + widget.account.id + '_Ava.png', title: 'Chân dung tài xế');
                                      },
                                    );
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
                        height: currentAccount.provinceCode == '0' ? 150 : 0,
                        child: search_page_area(area: area,),
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
                      widget.account.name = name.text.toString();
                      widget.account.money = double.parse(money.text.toString());
                      widget.account.license = biensoxe.text.toString();
                      widget.account.area = (currentAccount.provinceCode == '0' ? area.id : currentAccount.provinceCode);
                      await push_data_account();
                      Navigator.of(context).pop();
                    } else {
                      toastMessage('Điền đủ các mục rồi tiếp tục');
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
