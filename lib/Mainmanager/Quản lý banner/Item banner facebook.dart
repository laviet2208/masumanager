import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:masumanager/dataClass/Ads/ADStype1.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../dataClass/Ads/ADStype2.dart';
import '../../utils/utils.dart';

class ITEMbannerFacebook extends StatelessWidget {
  final double width;
  final double height;
  final ADStype2 adStype2;
  final VoidCallback updateEvent;
  final Color color;
  const ITEMbannerFacebook({Key? key, required this.width, required this.height, required this.adStype2, required this.updateEvent, required this.color}) : super(key: key);

  Future<void> deleteProduct(String idshop) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('ADStype2/' + idshop).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
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
    return Container(
      width: width-20,
      height: 100,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(
              color: Colors.grey,
              width: 1
          )
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: (width - 20)/4 - 1 - 150,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10,),
                child: Text(
                  adStype2.id,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'muli',
                      color: Colors.black,
                      fontSize: 16
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
            width: (width - 20)/4 - 1 + 150,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10,),
                child: Text(
                  adStype2.mainContent,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'muli',
                      color: Colors.purple,
                      fontSize: 16
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
            width: (width - 20)/4 + 100,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10,),
                child: Text(
                  adStype2.facebookLink,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'muli',
                      color: Colors.black,
                      fontSize: 16
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
            width: (width - 20)/4 - 100,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(top: 5, right: 10, left: 10, bottom: 5),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0, // Khoảng cách giữa các item theo chiều ngang
                        mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng theo chiều dọc
                        childAspectRatio: 4
                    ),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 1) {
                        return getButton('Xóa', Colors.white, Colors.redAccent, Colors.redAccent, 0, () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Xác nhận xóa'),
                                content: Text('Bạn có chắc chắn xóa banner không.'),
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
                                      await deleteProduct(adStype2.id);
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

                        });
                      }
                      if (index == 2) {
                        return getButton('Xem ảnh', Colors.white, Colors.redAccent, Colors.redAccent, 0, () async {
                          if (await canLaunch(adStype2.mainImage)) {
                            await launch(adStype2.mainImage);
                          } else {
                            toastMessage('Không thể mở ảnh');
                          }
                        },);
                      }
                      if (index == 3) {
                        return getButton('Xem FB', Colors.blue, Colors.blue, Colors.white, 0, () async {
                          if (await canLaunch(adStype2.facebookLink)) {
                            await launch(adStype2.facebookLink);
                          } else {
                            toastMessage('Không thể mở ảnh');
                          }
                        },);
                      }
                      return getButton('Cập nhật', Colors.redAccent, Colors.redAccent, Colors.white, 0, updateEvent);
                    }
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
    );
  }
}
