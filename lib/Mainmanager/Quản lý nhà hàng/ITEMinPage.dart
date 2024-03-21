import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20nh%C3%A0%20h%C3%A0ng/Danh%20m%E1%BB%A5c%20%C4%91%E1%BB%93%20%C4%83n/Danh%20m%E1%BB%A5c%20%C4%91%E1%BB%93%20%C4%83n.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20nh%C3%A0%20h%C3%A0ng/Danh%20s%C3%A1ch%20m%C3%B3n%20%C4%83n/Xem%20danh%20s%C3%A1ch%20m%C3%B3n%20%C4%83n.dart';
import 'package:masumanager/dataClass/Product.dart';
import 'package:masumanager/dataClass/accountShop.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../utils/utils.dart';
import '../Quản lý khu vực và tài khoản admin/Area.dart';
import '../Quản lý nhà hàng danh mục/Danh mục.dart';
import 'Danh mục đồ ăn/Hiển thị danh mục.dart';
import 'Danh mục đồ ăn/Thêm danh mục.dart';
import 'Thêm món ăn.dart';

class ITEMshop extends StatefulWidget {
  final double width;
  final double height;
  final accountShop shop;
  final VoidCallback updateEvent;
  final Color color;
  final String data;
  const ITEMshop({Key? key, required this.width, required this.height, required this.shop, required this.updateEvent, required this.color, required this.data}) : super(key: key);

  @override
  State<ITEMshop> createState() => _ITEMshopState();
}

class _ITEMshopState extends State<ITEMshop> {
  Future<void> pushData(int status) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child(widget.data + '/' + widget.shop.id + '/status').set(status);
      toastMessage('khóa/mở thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushIsTop(int status) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child(widget.data + '/' + widget.shop.id + '/isTop').set(status);
      toastMessage('gắn/bỏ thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  GestureDetector getButton(String text, Color backgroundColor, Color borderColor, Color TextColor, double borderRadius, VoidCallback event) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: backgroundColor,
            border: Border.all(
                width: 1,
                color: borderColor
            )
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'roboto',
              color: TextColor,
              fontSize: 13
          ),
        ),
      ),
      onTap: event,
    );
  }

  Area aRea = Area(id: '', name: '', money: 0, status: 0);

  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area/"+widget.shop.Area).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      Area area= Area.fromJson(orders);
      aRea.name = area.name;
      setState(() {

      });
    });
  }

  //Xóa nhà hàng
  Future<void> delete(String id , String data) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child(data + '/' + id).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  final List<RestaurantDirectory> DirectList = [];

  final List<FoodDirectory> FoodDirectList = [];

  final List<Product> FoodList = [];

  void getRestaurantDirectoryData() async {
    final reference = FirebaseDatabase.instance.reference();
    final snapshot = await reference.child(widget.data == 'Restaurant' ? "RestaurantDirectory" : "StoreDirectory").once();

    DirectList.clear();
    final dynamic orders = snapshot.snapshot.value;

    if (orders != null) {
      orders.forEach((key, value) {
        RestaurantDirectory food = RestaurantDirectory.fromJson(value);
        for (int i = 0; i < food.shopList.length; i++) {
          if (food.shopList.elementAt(i) == widget.shop.id) {
            DirectList.add(food);
            break;
          }
        }
      });
    }
  }

  void getFoodDirectoryData() async {
    final reference = FirebaseDatabase.instance.reference();
    final snapshot = await reference.child(widget.data == 'Restaurant' ? "FoodDirectory" : "ProductDirectory").once();

    FoodDirectList.clear();
    final dynamic orders = snapshot.snapshot.value;

    if (orders != null) {
      orders.forEach((key, value) {
        FoodDirectory food = FoodDirectory.fromJson(value);
        if (food.ownerID == widget.shop.id) {
          FoodDirectList.add(food);
        }
      });
    }
  }

  void getFoodData() async {
    final reference = FirebaseDatabase.instance.reference();
    final snapshot = await reference.child(widget.data == 'Restaurant' ? "Food" : "Product").once();

    FoodList.clear();
    final dynamic orders = snapshot.snapshot.value;

    if (orders != null) {
      orders.forEach((key, value) {
        Product food = Product.fromJson(value);
        if (food.owner.id == widget.shop.id) {
          FoodList.add(food);
        }
      });
    }
  }

  Future<void> pushDataDirectory(RestaurantDirectory restaurantDirectory, List<String> shopList) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child(widget.data == 'Restaurant' ? 'RestaurantDirectory' : 'StoreDirectory').child(restaurantDirectory.id).child('shopList').set(shopList.map((e) => e).toList());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  void deleteImage(String imagePath) async {
    final ref = FirebaseStorage.instance.ref().child(imagePath);
    try {
      await ref.delete();
      print('Xóa ảnh thành công: $imagePath');
    } catch (e) {
      print('Lỗi khi xóa ảnh: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRestaurantDirectoryData();
    getFoodData();
    getFoodDirectoryData();
    getData1();
  }


  @override
  Widget build(BuildContext context) {
    String istop = '';
    String status = '';
    Color statusColor = Colors.green;
    if (widget.shop.status == 1) {
      status = 'Đang kích hoạt';
      statusColor = Colors.green;
    } else {
      status = 'Đang bị khóa';
      statusColor = Colors.red;
    }

    if (widget.shop.isTop == 1) {
      istop = 'Chưa là top';
    } else {
      istop = 'Đang là top';
    }

    return Container(
      width: widget.width,
      height: 3 * ((widget.width/5) + 30)/11 + 45,
      decoration: BoxDecoration(
        color: widget.color,
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 240, 240, 240),
            width: 1.0,
          ),
        ),
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: widget.width/5,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                child: ListView(
                  children: [
                    Container(
                      height: 5,
                    ),

                    Container(
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: (widget.data == 'Restaurant') ? 'Tên nhà hàng : ' : 'Tên cửa hàng : ',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.bold, // Để in đậm
                              ),
                            ),
                            TextSpan(
                              text: widget.shop.name, // Phần còn lại viết bình thường
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'roboto',
                                color: Colors.purple,
                                fontWeight: FontWeight.normal, // Để viết bình thường
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      height: 7,
                    ),

                    Container(
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Số điện thoại(Tài khoản) : ',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.bold, // Để in đậm
                              ),
                            ),
                            TextSpan(
                              text: widget.shop.phoneNum, // Phần còn lại viết bình thường
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'roboto',
                                color: Colors.black,
                                fontWeight: FontWeight.normal, // Để viết bình thường
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
            width: widget.width/5-1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                child: ListView(
                  children: [
                    Container(
                      height: 5,
                    ),

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Ngày tạo : ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'roboto',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: (widget.shop.createTime.day >= 10 ? widget.shop.createTime.day.toString() : '0' + widget.shop.createTime.day.toString()) + "/" + (widget.shop.createTime.month >= 10 ? widget.shop.createTime.month.toString() : '0' + widget.shop.createTime.month.toString()) + "/" + widget.shop.createTime.year.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'roboto',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: 7,
                    ),

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Giờ tạo : ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'roboto',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: (widget.shop.createTime.hour >= 10 ? widget.shop.createTime.hour.toString() : '0' + widget.shop.createTime.hour.toString()) + ":" + (widget.shop.createTime.minute >= 10 ? widget.shop.createTime.minute.toString() : '0' + widget.shop.createTime.minute.toString()) + ":" + (widget.shop.createTime.second >= 10 ? widget.shop.createTime.second.toString() : '0' + widget.shop.createTime.second.toString()),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'roboto',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: 7,
                    ),

                    Container(
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Khu vực : ',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.bold, // Để in đậm
                              ),
                            ),
                            TextSpan(
                              text: aRea.name, // Phần còn lại viết bình thường
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'roboto',
                                color: Colors.purple,
                                fontWeight: FontWeight.normal, // Để viết bình thường
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
            width: widget.width/5 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                child: ListView(
                  children: [
                    Container(
                      height: 5,
                    ),

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Giờ mở cửa : ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'roboto',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: (widget.shop.openTime.hour >= 10 ? widget.shop.openTime.hour.toString() : '0' + widget.shop.openTime.hour.toString()) + " giờ, " + (widget.shop.openTime.minute >= 10 ? widget.shop.openTime.minute.toString() : '0' + widget.shop.openTime.minute.toString()) + " phút",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'roboto',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: 7,
                    ),

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Giờ đóng cửa : ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'roboto',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: (widget.shop.closeTime.hour >= 10 ? widget.shop.closeTime.hour.toString() : '0' + widget.shop.closeTime.hour.toString()) + " giờ, " + (widget.shop.closeTime.minute >= 10 ? widget.shop.closeTime.minute.toString() : '0' + widget.shop.closeTime.minute.toString()) + " phút",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'roboto',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
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
            width: widget.width/5 - 60,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1,
                        color: statusColor
                    )
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: AutoSizeText(
                    status,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal,
                        color: statusColor,
                        fontSize: 100
                    ),
                  ),
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
            width: widget.width/5 + 60,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 15),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0, // Khoảng cách giữa các item theo chiều ngang
                    mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng theo chiều dọc
                    childAspectRatio: 5.5
                ),
                itemCount: 5, // Số lượng item trong danh sách của bạn
                itemBuilder: (BuildContext context, int index) {
                  if (index == 1) {
                    return getButton('Khóa/mở tài khoản', Colors.white, Colors.redAccent, Colors.redAccent, 0 ,() async {
                      if (widget.shop.status == 1) {
                        await pushData(2);
                      } else {
                        await pushData(1);
                      }
                    },);
                  }
                  if (index == 4) {
                    return getButton('Xóa tài khoản', Colors.redAccent, Colors.redAccent, Colors.white, 0 ,() async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Xác nhận xóa'),
                            content: Text('Bạn có chắc chắn xóa tài khoản không.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Hủy',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  //Xóa danh mục đồ ăn
                                  for (FoodDirectory res in FoodDirectList) {
                                    await delete(res.id, widget.data == 'Restaurant' ? 'FoodDirectory' : 'ProductDirectory');
                                  }
                                  //Xóa món ăn
                                  for (Product res in FoodList) {
                                    await delete(res.id,widget.data == 'Restaurant' ? 'Food' : 'Product');
                                    deleteImage(widget.data == 'Restaurant' ? 'Food/'+res.id+'.png' : 'Product/'+res.id+'.png');
                                  }
                                  //Xóa nhà hàng trong danh mục
                                  for (RestaurantDirectory res in DirectList) {
                                    for (String a in res.shopList) {
                                      if (a == widget.shop.id) {
                                        res.shopList.remove(a);
                                      }
                                    }
                                    await pushDataDirectory(res,res.shopList);
                                  }
                                  deleteImage('Shop/' + widget.shop.id + '.png');
                                  await delete(widget.shop.id, widget.data);
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Đồng ý',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );

                    },
                    );
                  }
                  if (index == 3) {
                    return getButton('DS danh mục', Colors.redAccent, Colors.redAccent, Colors.white,0, ()  async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Thông tin nhà hàng'),
                            content: Container(
                              width: widget.width,
                              height: widget.height * 5,
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
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    top: 5,
                                    left: 10,
                                    child: GestureDetector(
                                      child: Container(
                                        width: 190,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                                          child: AutoSizeText(
                                            widget.data == 'Restaurant' ? '+ Thêm danh mục món ăn' : '+ Thêm danh mục sản phẩm',
                                            style: TextStyle(
                                                fontFamily: 'roboto',
                                                fontSize: 100,
                                                color: Colors.white
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),

                                      onTap: () {
                                        Themdanhmucdoan.showdialog(widget.width/3*2, widget.height, context, TextEditingController(), widget.shop, widget.data);
                                      },
                                    ),
                                  ),

                                  Positioned(
                                    top: 55,
                                    left: 10,
                                    child: Container(
                                      width: widget.width - 20,
                                      height: widget.height * 5 - 65,
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            top: 0,
                                            left: 0,
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
                                                scrollDirection: Axis.horizontal,

                                                children: [
                                                  Container(
                                                    width: (widget.width - 20)/4 - 1,
                                                    alignment: Alignment.center,
                                                    child : Padding(
                                                      padding: EdgeInsets.only(top: 15,bottom: 15),
                                                      child: AutoSizeText(
                                                        'ID danh mục',
                                                        style: TextStyle(
                                                            fontFamily: 'roboto',
                                                            color: Colors.black,
                                                            fontSize: 100
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
                                                    width: (widget.width - 20)/4 - 1,
                                                    alignment: Alignment.center,
                                                    child : Padding(
                                                      padding: EdgeInsets.only(top: 15,bottom: 15),
                                                      child: AutoSizeText(
                                                        'Tên danh mục',
                                                        style: TextStyle(
                                                            fontFamily: 'roboto',
                                                            color: Colors.black,
                                                            fontSize: 100
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
                                                    width: (widget.width - 20)/4 - 1,
                                                    alignment: Alignment.center,
                                                    child : Padding(
                                                      padding: EdgeInsets.only(top: 15,bottom: 15),
                                                      child: AutoSizeText(
                                                        widget.data == 'Restaurant' ? 'Số lượng món ăn' : 'Số lượng sản phẩm',
                                                        style: TextStyle(
                                                            fontFamily: 'roboto',
                                                            color: Colors.black,
                                                            fontSize: 100
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
                                                    width: (widget.width - 20)/4 - 1,
                                                    alignment: Alignment.center,
                                                    child : Padding(
                                                      padding: EdgeInsets.only(top: 15,bottom: 15),
                                                      child: AutoSizeText(
                                                        'Thao tác',
                                                        style: TextStyle(
                                                            fontFamily: 'roboto',
                                                            color: Colors.black,
                                                            fontSize: 100
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 50,
                                            left: 0,
                                            child: Container(
                                              width: widget.width - 20,
                                              height: widget.height * 5 - 60,
                                              child: Hienthidanhmucdoan(width: widget.width - 20, height: widget.height * 5 - 60, idShop: widget.shop.id, data: widget.data,),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Thoát',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          );
                        },
                      );

                    },
                    );
                  }
                  if (index == 2) {
                    return getButton((widget.data == 'Restaurant') ?'DS món ăn' : 'DS sản phẩm', Colors.white, Colors.redAccent, Colors.redAccent,0,
                          () async {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Xemdanhsachmonan(width: widget.width/6 * 5, height: 700, shop: widget.shop, data: widget.data,),
                              );
                            }
                        );
                      },
                    );
                  }

                  return getButton('Cập nhật', Colors.redAccent, Colors.redAccent, Colors.white,0, widget.updateEvent);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

