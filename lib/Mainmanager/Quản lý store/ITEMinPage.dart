import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../dataClass/accountShop.dart';
import '../../utils/utils.dart';
import 'Danh mục sản phẩm/Hiển thị danh mục.dart';
import 'Danh mục sản phẩm/Thêm danh mục.dart';
import 'Danh sách sản phẩm/Xem danh sách sản phẩm.dart';
import 'Thêm sản phẩm.dart';

class ITEMstore extends StatelessWidget {
  final double width;
  final double height;
  final accountShop shop;
  final VoidCallback updateEvent;
  final Color color;
  const ITEMstore({Key? key, required this.width, required this.height, required this.shop, required this.updateEvent, required this.color}) : super(key: key);

  Future<void> deleteProduct(String idshop) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Store/' + idshop).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushData(int status) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Store/' + shop.id + '/status').set(status);
      toastMessage('khóa/mở thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushIsTop(int status) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Store/' + shop.id + '/isTop').set(status);
      toastMessage('gắn/bỏ thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  GestureDetector getButton(String text, Color backgroundColor, Color borderColor, Color TextColor, VoidCallback event) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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
              fontFamily: 'muli',
              color: TextColor,
              fontSize: 13
          ),
        ),
      ),
      onTap: event,
    );
  }

  @override
  Widget build(BuildContext context) {
    String istop = '';
    String status = '';
    Color statusColor = Colors.green;
    if (shop.status == 1) {
      status = 'Đang kích hoạt';
      statusColor = Colors.green;
    } else {
      status = 'Đang bị khóa';
      statusColor = Colors.red;
    }

    if (shop.isTop == 1) {
      istop = 'Chưa là top';
    } else {
      istop = 'Đang là top';
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
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
            width: width/5,
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
                              text: 'Tên nhà hàng : ',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'muli',
                                fontWeight: FontWeight.bold, // Để in đậm
                              ),
                            ),
                            TextSpan(
                              text: shop.name, // Phần còn lại viết bình thường
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'muli',
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
                                fontFamily: 'muli',
                                fontWeight: FontWeight.bold, // Để in đậm
                              ),
                            ),
                            TextSpan(
                              text: shop.phoneNum, // Phần còn lại viết bình thường
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'muli',
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
            width: width/5-1,
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
                                    fontFamily: 'muli',
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
                                  text: shop.createTime.day.toString() + "/" + shop.createTime.month.toString() + "/" + shop.createTime.year.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'muli',
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
                                    fontFamily: 'muli',
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
                                  text: shop.createTime.hour.toString() + ":" + shop.createTime.minute.toString() + ":" + shop.createTime.second.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'muli',
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
            width: width/5 - 1,
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
                                    fontFamily: 'muli',
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
                                  text: shop.openTime.hour.toString() + " giờ, " + shop.openTime.minute.toString() + " phút",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'muli',
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
                                    fontFamily: 'muli',
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
                                  text: shop.closeTime.hour.toString() + " giờ, " + shop.closeTime.minute.toString() + " phút",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'muli',
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
            width: width/5 - 60,
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
                        fontFamily: 'muli',
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
            width: width/5 + 60,
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
                    return getButton('Khóa/mở tài khoản', Colors.white, Colors.redAccent, Colors.redAccent, () async {
                      if (shop.status == 1) {
                        await pushData(2);
                      } else {
                        await pushData(1);
                      }
                    },);
                  }
                  if (index == 4) {
                    return getButton('Xóa tài khoản', Colors.white, Colors.red, Colors.red, () async {
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
                                  await deleteProduct(shop.id);
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
                    return getButton('DS danh mục', Colors.white, Colors.purple, Colors.purple, ()  async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Thông tin cửa hàng'),
                            content: Container(
                              width: width,
                              height: height * 5,
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
                                            '+ Thêm danh mục sản phẩm',
                                            style: TextStyle(
                                                fontFamily: 'muli',
                                                fontSize: 100,
                                                color: Colors.white
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),

                                      onTap: () {
                                        Themdanhmucsanpham.showdialog(width/3*2, height, context, TextEditingController(), shop);
                                      },
                                    ),
                                  ),

                                  Positioned(
                                    top: 55,
                                    left: 10,
                                    child: Container(
                                      width: width - 20,
                                      height: height * 5 - 65,
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                              width: width - 20,
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
                                                    width: (width - 20)/4 - 1,
                                                    alignment: Alignment.center,
                                                    child : Padding(
                                                      padding: EdgeInsets.only(top: 15,bottom: 15),
                                                      child: AutoSizeText(
                                                        'ID danh mục',
                                                        style: TextStyle(
                                                            fontFamily: 'muli',
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
                                                    width: (width - 20)/4 - 1,
                                                    alignment: Alignment.center,
                                                    child : Padding(
                                                      padding: EdgeInsets.only(top: 15,bottom: 15),
                                                      child: AutoSizeText(
                                                        'Tên danh mục',
                                                        style: TextStyle(
                                                            fontFamily: 'muli',
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
                                                    width: (width - 20)/4 - 1,
                                                    alignment: Alignment.center,
                                                    child : Padding(
                                                      padding: EdgeInsets.only(top: 15,bottom: 15),
                                                      child: AutoSizeText(
                                                        'Sô lượng sản phẩm',
                                                        style: TextStyle(
                                                            fontFamily: 'muli',
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
                                                    width: (width - 20)/4 - 1,
                                                    alignment: Alignment.center,
                                                    child : Padding(
                                                      padding: EdgeInsets.only(top: 15,bottom: 15),
                                                      child: AutoSizeText(
                                                        'Thao tác',
                                                        style: TextStyle(
                                                            fontFamily: 'muli',
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
                                              width: width - 20,
                                              height: height * 5 - 60,
                                              child: Hienthidanhmucsanpham(width: width - 20, height: height * 5 - 60, idShop: shop.id,),
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
                    return getButton('DS sản phẩm', Colors.white, Colors.purple, Colors.purple,
                          () async {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Xemdanhsachsanpham(width: width/6 * 5, height: 700, shop: shop),
                              );
                            }
                        );
                      },
                    );
                  }

                  return getButton('Cập nhật', Colors.white, Colors.redAccent, Colors.redAccent, updateEvent);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

