import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../../dataClass/Ads/ADStype1.dart';
import '../../../dataClass/FinalClass.dart';
import '../../../dataClass/Time.dart';
import '../../../dataClass/accountShop.dart';
import '../../../utils/utils.dart';
import '../../Quản lý voucher/page tìm kiếm.dart';


class SuaBannerShop extends StatefulWidget {
  final ADStype1 adStype1;
  const SuaBannerShop({Key? key, required this.adStype1}) : super(key: key);

  @override
  State<SuaBannerShop> createState() => _SuaBannerShopState();
}

class _SuaBannerShopState extends State<SuaBannerShop> {
  final mainContentcontrol = TextEditingController();
  final secondaryControl = TextEditingController();
  final mainImagecontrol = TextEditingController();
  List<accountShop> shopList = [];
  bool loading = false;
  final accountShop selectShop = accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '', OpenStatus: 0);

  Future<void> pushData(ADStype1 adStype1) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('ADStype1').child(adStype1.id).set(adStype1.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Thêm ads thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  void getRestaurantData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Restaurant").onValue.listen((event) {
      shopList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        accountShop food= accountShop.fromJson(value);
        if (currentAccount.provinceCode != '0') {
          if (currentAccount.provinceCode == food.Area) {
            shopList.add(food);
          }
        } else {
          shopList.add(food);
        }
      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRestaurantData();
    mainContentcontrol.text = widget.adStype1.mainContent;
    secondaryControl.text = widget.adStype1.secondaryText;
    mainImagecontrol.text = widget.adStype1.mainImage;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thêm Banner mới'),
      content: Container(
        width: 400, // Đặt kích thước chiều rộng theo ý muốn
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
                'Tên sự kiện *',
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
                        controller: mainContentcontrol,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'roboto',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Dòng chữ in đậm to nhất',
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
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Dòng mô tả sự kiện *',
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
                        controller: secondaryControl,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'roboto',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Dòng chữ bé hơn nằm dưới dòng mô tả chỉnh',
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
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Liên kết ảnh đại diện *',
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
                        controller: mainImagecontrol,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'roboto',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập vào liên kết ảnh đại diện của sự kiện',
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
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Chọn nhà hàng *',
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
                child: searchPage(list: shopList, selectShop: selectShop,),
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
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: loading ? CircularProgressIndicator() : Text('Lưu'),
          onPressed: loading ? null : () async {
            setState(() {
              loading = true;
            });
            if (mainContentcontrol.text.isNotEmpty && mainImagecontrol.text.isNotEmpty && secondaryControl.text.isNotEmpty) {
              if (selectShop.id != '') {
                ADStype1 ads = ADStype1(
                    mainContent: mainContentcontrol.text.toString(),
                    secondaryText: secondaryControl.text.toString(),
                    mainImage: mainImagecontrol.text.toString(),
                    shop: selectShop,
                    id: widget.adStype1.id
                );
                await pushData(ads);
                selectShop.id = '';
                mainImagecontrol.clear();
                secondaryControl.clear();
                mainImagecontrol.clear();
              }
            } else {
              toastMessage('Điền đủ thông tin trước');
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
