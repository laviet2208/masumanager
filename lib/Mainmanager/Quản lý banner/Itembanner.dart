import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:masumanager/dataClass/Ads/ADStype1.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../utils/utils.dart';

class ITEMbanner extends StatefulWidget {
  final double width;
  final double height;
  final ADStype1 adStype1;
  final VoidCallback updateEvent;
  final Color color;
  const ITEMbanner({Key? key, required this.width, required this.height, required this.adStype1, required this.updateEvent, required this.color}) : super(key: key);

  @override
  State<ITEMbanner> createState() => _ITEMbannerState();
}

class _ITEMbannerState extends State<ITEMbanner> {
  Future<void> deleteProduct(String idshop) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('ADStype1/' + idshop).remove();
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
      width: widget.width - 20,
      height: 100,
      decoration: BoxDecoration(
        color: widget.color,
        border: Border.all(
          width: 1,
          color: Colors.grey
        )
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: (widget.width - 20)/4 - 1 - 150,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10,),
                child: Text(
                  widget.adStype1.id,
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
            width: (widget.width - 20)/4 - 1 + 150,
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
                              text: 'Tiêu đề chính : ',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'muli',
                                fontWeight: FontWeight.bold, // Để in đậm
                              ),
                            ),
                            TextSpan(
                              text: widget.adStype1.mainContent, // Phần còn lại viết bình thường
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
                              text: 'Tiêu đề phụ : ',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'muli',
                                fontWeight: FontWeight.bold, // Để in đậm
                              ),
                            ),
                            TextSpan(
                              text: widget.adStype1.secondaryText, // Phần còn lại viết bình thường
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
            width: (widget.width - 20)/4 + 100,
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
                              text: widget.adStype1.shop.name, // Phần còn lại viết bình thường
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
                              text: 'Số điện thoại : ',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'muli',
                                fontWeight: FontWeight.bold, // Để in đậm
                              ),
                            ),
                            TextSpan(
                              text: widget.adStype1.shop.phoneNum, // Phần còn lại viết bình thường
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
            width: (widget.width - 20)/4 - 100,
            child: Padding(
              padding: EdgeInsets.only(top: 5, right: 10, left: 10, bottom: 5),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0, // Khoảng cách giữa các item theo chiều ngang
                      mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng theo chiều dọc
                      childAspectRatio: 4
                  ),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 1) {
                      return getButton('Cập nhật', Colors.white, Colors.redAccent, Colors.redAccent, 0, widget.updateEvent);
                    }
                    if (index == 2) {
                      return getButton('Xem ảnh', Colors.white, Colors.redAccent, Colors.redAccent, 0, () async {
                        if (await canLaunch(widget.adStype1.mainImage)) {
                          await launch(widget.adStype1.mainImage);
                        } else {
                          toastMessage('Không thể mở ảnh');
                        }
                      },);
                    }
                    return getButton('Xóa', Colors.redAccent, Colors.redAccent, Colors.white, 0, () async {
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
                                          await deleteProduct(widget.adStype1.id);
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
              )
            ),
          )
        ],
      ),
    );
  }
}

