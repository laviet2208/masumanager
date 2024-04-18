import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shipperAccount.dart';
import 'package:masumanager/MasuShipManager/Data/locationData/Location.dart';
import 'package:masumanager/MasuShipManager/Data/models/area_search/search_page_area.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../../dataClass/FinalClass.dart';
import '../../../../Data/areaData/Area.dart';

class add_new_driver_dialog extends StatefulWidget {
  const add_new_driver_dialog({Key? key}) : super(key: key);

  @override
  State<add_new_driver_dialog> createState() => _add_new_driver_dialogState();
}

class _add_new_driver_dialogState extends State<add_new_driver_dialog> {
  bool loading = false;
  final NameController = TextEditingController();
  final PhoneController = TextEditingController();
  final LicenseController = TextEditingController();
  final WalletController = TextEditingController();
  Area area = Area(id: '', name: '', money: 0, status: 0);

  final shipperAccount account = shipperAccount(id: generateID(15), createTime: getCurrentTime(), lockStatus: 1, name: '', area: '', phone: '', location: Location(placeId: '', description: '', longitude: 105.791731, latitude: 21.006259, mainText: '', secondaryText: ''), onlineStatus: 0, money: 10000000, license: '', orderHaveStatus: 0, debt: 0);

  Future<void> push_new_driver() async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Account').child(account.id).set(account.toJson());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy tài xế mới');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/2;
    double height = MediaQuery.of(context).size.height/2.5;

    return AlertDialog(
      title: Text('Thêm tài xế'),
      content: Container(
        width: width,
        height: height,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Tên tài xế *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),

            Container(
              height: 7,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        width: 0.5,
                        color: Colors.black,
                      )
                  ),

                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Form(
                      child: TextFormField(
                        controller: NameController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập tên tài xế',
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
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Số điện thoại *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),

            Container(
              height: 7,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        width: 0.5,
                        color: Colors.black,
                      )
                  ),

                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Form(
                      child: TextFormField(
                        controller: PhoneController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập số điện thoại tài xế',
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
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Biển số xe *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),

            Container(
              height: 7,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        width: 0.5,
                        color: Colors.black,
                      )
                  ),

                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Form(
                      child: TextFormField(
                        controller: LicenseController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập biển số xe tài xế',
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
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Số dư ban đầu *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),

            Container(
              height: 7,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        width: 0.5,
                        color: Colors.black,
                      )
                  ),

                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Form(
                      child: TextFormField(
                        controller: WalletController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập số dư ban đầu',
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
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Chọn khu vực quản lý *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: currentAccount.provinceCode == '0' ? 14 : 0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),

            Container(
              height: currentAccount.provinceCode == '0' ? 10 : 0,
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
        !loading ? TextButton(
          onPressed: () async {
            if (NameController.text.isNotEmpty && PhoneController.text.isNotEmpty && LicenseController.text.isNotEmpty && WalletController.text.isNotEmpty && area.id != 'NA') {
              setState(() {
                loading = true;
              });
              account.id = generateID(15);
              account.name = NameController.text.toString();
              account.money = double.parse(WalletController.text.toString());
              account.area = area.id;
              account.phone = PhoneController.text.toString();
              account.license = LicenseController.text.toString();
              await push_new_driver();
              setState(() {
                loading = false;
              });
              // Navigator.of(context).pop();
            }
          },
          child: Text('Xác nhận', style: TextStyle(color: Colors.blueAccent),),
        ) : CircularProgressIndicator(color: Colors.black,)
      ],
    );
  }
}
