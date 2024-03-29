import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20nh%C3%A0%20h%C3%A0ng/Danh%20s%C3%A1ch%20m%C3%B3n%20%C4%83n/S%E1%BB%ADa%20m%C3%B3n.dart';
import 'package:masumanager/dataClass/Product.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../../utils/utils.dart';
import 'Sửa sản phẩm.dart';

class ItemProduct extends StatelessWidget {
  final double width;
  final Product product;
  final Color color;
  const ItemProduct({Key? key, required this.width, required this.product, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void deleteImage(String imagePath) async {
      final ref = FirebaseStorage.instance.ref().child(imagePath);
      try {
        await ref.delete();
        print('Xóa ảnh thành công: $imagePath');
      } catch (e) {
        print('Lỗi khi xóa ảnh: $e');
      }
    }

    Future<void> deleteRequest(String id) async {
      try {
        DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
        await databaseRef.child('Product/' + id).remove();
        toastMessage('xóa thành công');
      } catch (error) {
        toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
        throw error;
      }
    }

    Future<void> changeStatus(int status) async {
      final reference = FirebaseDatabase.instance.reference();
      await reference.child("Product/" + product.id + "/OpenStatus").set(status);
    }

    return Container(
      height: width/10 - 30,
      width: width,
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
            width: width/10,
            child: Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(product.imageList)
                    )
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
                              text: 'Tên món: ',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'muli',
                                fontWeight: FontWeight.bold, // Để in đậm
                              ),
                            ),
                            TextSpan(
                              text: product.name, // Phần còn lại viết bình thường
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
                              text: 'Mô tả : ',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'muli',
                                fontWeight: FontWeight.bold, // Để in đậm
                              ),
                            ),
                            TextSpan(
                              text: product.content, // Phần còn lại viết bình thường
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

                    Container(
                      height: 7,
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
            width: width/8,
            alignment: Alignment.centerRight,
            child: Padding(
                padding: EdgeInsets.only(left: 5, right: 10, top: 15, bottom: 15),
                child: Text(
                  dataCheckManager.getStringNumber(product.cost),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontFamily: 'muli',
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
            width: width+20 - (width/8) - (width/5) - (width/10) - 3,
            alignment: Alignment.centerRight,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: (width/10 - 30)/3, bottom: (width/10 - 30)/3),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 30,
                    ),

                    GestureDetector(
                      child:Container(
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Cập nhật',
                          style: TextStyle(
                              fontFamily: 'muli',
                              fontSize: 14,
                              color: Colors.white
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Chỉnh sửa thông tin sản phẩm'),
                                content: Suasanpham(shop: product.owner, product: product),
                              );
                            }
                        );
                      },
                    ),

                    Container(
                      width: 30,
                    ),

                    GestureDetector(
                      child:Container(
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(
                                color: Colors.redAccent,
                                width: 1
                            )
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Xem ảnh',
                          style: TextStyle(
                              fontFamily: 'muli',
                              fontSize: 14,
                              color: Colors.redAccent
                          ),
                        ),
                      ),
                      onTap: () async {
                        if (await canLaunch(product.imageList)) {
                          await launch(product.imageList);
                        } else {
                          toastMessage('Không thể mở ảnh');
                        }
                      },
                    ),

                    Container(
                      width: 30,
                    ),

                    GestureDetector(
                      child:Container(
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Xóa sản phẩm',
                          style: TextStyle(
                              fontFamily: 'muli',
                              fontSize: 14,
                              color: Colors.white
                          ),
                        ),
                      ),
                      onTap: () async {
                        deleteImage('Product/'+product.id+'.png');
                        await deleteRequest(product.id);
                      },
                    ),

                    Container(
                      width: 30,
                    ),

                    GestureDetector(
                      child:Container(
                        width: 120,
                        decoration: BoxDecoration(
                          color: product.OpenStatus == 0 ? Colors.redAccent : Colors.blueAccent,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          product.OpenStatus == 0 ? 'Đang tắt' : 'Đang bật',
                          style: TextStyle(
                              fontFamily: 'muli',
                              fontSize: 14,
                              color: Colors.white
                          ),
                        ),
                      ),
                      onTap: () async {
                        if (product.OpenStatus == 0) {
                          await changeStatus(1);
                          toastMessage('Đã mở món ăn');
                        } else {
                          await changeStatus(1);
                          toastMessage('Đã đóng món ăn');
                        }
                      },
                    ),
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
}

