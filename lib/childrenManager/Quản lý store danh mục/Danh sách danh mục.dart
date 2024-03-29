import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/FinalClass.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';
import '../../Mainmanager/Quản lý nhà hàng danh mục/Cập nhật danh mục.dart';
import '../../Mainmanager/Quản lý nhà hàng danh mục/Danh mục.dart';
import '../../Mainmanager/Quản lý nhà hàng danh mục/DropList chọn icon.dart';
import '../../dataClass/Time.dart';
import '../../dataClass/accountShop.dart';
import '../../utils/utils.dart';
import 'ItemDanhmuc.dart';

class Danhsachdanhmucstore extends StatefulWidget {
  final double width;
  final double height;
  const Danhsachdanhmucstore({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Danhsachdanhmucstore> createState() => _DanhsachdanhmucState();
}

class _DanhsachdanhmucState extends State<Danhsachdanhmucstore> {
  final mainContent = TextEditingController();
  final subContent = TextEditingController();
  List<accountShop> shopList = [];
  final accountShop shop = accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '', OpenStatus: 0);
  final List<RestaurantDirectory> DirectList = [];
  bool loading = false;

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("StoreDirectory").onValue.listen((event) {
      DirectList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        RestaurantDirectory food= RestaurantDirectory.fromJson(value);
        if (food.Area == currentAccount.provinceCode) {
          DirectList.add(food);
        }
      });
      setState(() {

      });
    });
  }

  Future<void> pushData(RestaurantDirectory restaurantDirectory) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('StoreDirectory').child(restaurantDirectory.id).set(restaurantDirectory.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Thêm danh mục thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  void getRestaurantData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Store").onValue.listen((event) {
      shopList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        accountShop food= accountShop.fromJson(value);
        if (food.Area == currentAccount.provinceCode) {
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
    getData();
    getRestaurantData();
    shop.id = 'assets/image/icontrang1/fire.png';
    shop.phoneNum = 'assets/image/icontrang1/fire.png';
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
              onTap: () {
                showDialog (
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Thêm danh mục mới'),
                      content: Container(
                        width: widget.width * (1.5/3), // Đặt kích thước chiều rộng theo ý muốn
                        height: widget.height * (2/3), // Đặt kích thước chiều cao theo ý muốn
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
                                'Tên danh mục *',
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
                                        controller: mainContent,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'arial',
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Tên cửa hàng',
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
                              height: 20,
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Tên danh mục phụ bên dưới',
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
                                        controller: subContent,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'arial',
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Tên danh mục phụ',
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
                              height: 20,
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Chọn icon cho tiêu đề chính',
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
                                child: Droplisticon(width: widget.width * (1.5/3), shop: shop, type: 1,)
                            ),

                            Container(
                              height: 20,
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Chọn icon cho tiêu đề phụ',
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
                                child: Droplisticon(width: widget.width * (1.5/3), shop: shop, type: 2,)
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
                            mainContent.clear();
                            subContent.clear();
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: loading ? CircularProgressIndicator() : Text('Lưu'),
                          onPressed: loading ? null : () async {
                            setState(() {
                              loading = true;
                            });

                            if (mainContent.text.isNotEmpty && subContent.text.isNotEmpty) {
                              if (shop.phoneNum != '' && shop.id != '') {
                                RestaurantDirectory res = RestaurantDirectory(
                                    id: dataCheckManager.generateRandomString(15),
                                    mainContent: mainContent.text.toString(),
                                    mainIcon: shop.id,
                                    subContent: subContent.text.toString(),
                                    subIcon: shop.phoneNum,
                                    shopList: [],
                                    Area: currentAccount.provinceCode,
                                  createTime: Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year),);
                                await pushData(res);
                                Navigator.of(context).pop();
                              }
                            } else {
                              toastMessage('Phải nhập đủ thông tin');
                              setState(() {
                                loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
                              });
                            }
                          },
                        ),
                      ],
                    );
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
                          'ID danh mục',
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
                    width: (widget.width - 20)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Tiêu đề chính',
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
                    width: (widget.width - 20)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Tiêu đề phụ',
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
                    width: (widget.width - 20)/5 - 1,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Số lượng nhà hàng',
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
                    width: (widget.width - 20)/5 - 1 + 60,
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
              child: ListView.builder(
                itemCount: DirectList.length,
                itemBuilder: (context, index) {
                  return ITEMdanhmucshop(width: widget.width - 20, height: 120, directory: DirectList[index],shopList: shopList,
                    updateEvent: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Capnhatdanhmuc(directory: DirectList[index], data: 'StoreDirectory');
                          }
                      );
                    }, color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255),);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
