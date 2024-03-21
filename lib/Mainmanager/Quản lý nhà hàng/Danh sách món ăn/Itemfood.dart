import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20nh%C3%A0%20h%C3%A0ng/Danh%20s%C3%A1ch%20m%C3%B3n%20%C4%83n/S%E1%BB%ADa%20m%C3%B3n.dart';
import 'package:masumanager/dataClass/Product.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../../utils/utils.dart';

class ItemFood extends StatefulWidget {
  final double width;
  final Product product;
  final Color color;
  final String data;
  const ItemFood({Key? key, required this.width, required this.product, required this.color, required this.data}) : super(key: key);

  @override
  State<ItemFood> createState() => _ItemFoodState();
}

class _ItemFoodState extends State<ItemFood> {
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

    Future<void> changeStatus(int status) async {
      final reference = FirebaseDatabase.instance.reference();
      await reference.child(widget.data + "/" + widget.product.id + "/OpenStatus").set(status);
    }

    Future<void> deleteRequest(String id) async {
      try {
        DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
        await databaseRef.child(widget.data + '/' + id).remove();
        toastMessage('xóa thành công');
      } catch (error) {
        toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
        throw error;
      }
    }

    return Container(
      height: widget.width/10 - 10,
      width: widget.width,
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
            width: widget.width/10,
            child: Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(widget.product.imageList)
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
                              text: 'Tên món: ',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.bold, // Để in đậm
                              ),
                            ),
                            TextSpan(
                              text: widget.product.name, // Phần còn lại viết bình thường
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
                              text: 'Mô tả : ',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.bold, // Để in đậm
                              ),
                            ),
                            TextSpan(
                              text: widget.product.content, // Phần còn lại viết bình thường
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

                    Container(
                      height: 7,
                    ),

                    Container(
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Cập nhật ngày : ',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.bold, // Để in đậm
                              ),
                            ),
                            TextSpan(
                              text: widget.product.createTime.day.toString() + '/' + widget.product.createTime.month.toString() + '/' + widget.product.createTime.year.toString() + ' , ' + widget.product.createTime.hour.toString() + ':' + widget.product.createTime.minute.toString(), // Phần còn lại viết bình thường
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
            width: widget.width/8,
            alignment: Alignment.centerRight,
            child: Padding(
                padding: EdgeInsets.only(left: 5, right: 10, top: 15, bottom: 15),
                child: Text(
                  dataCheckManager.getStringNumber(widget.product.cost),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontFamily: 'roboto',
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
            width: widget.width+20 - (widget.width/8) - (widget.width/5) - (widget.width/10) - 3,
            alignment: Alignment.centerRight,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: (widget.width/10 - 30)/2.5, bottom: (widget.width/10 - 30)/2.5),
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
                              fontFamily: 'roboto',
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
                                title: Text('Chỉnh sửa thông tin món ăn'),
                                content: Suamonan(shop: widget.product.owner, product: widget.product, data: widget.data,),
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
                              fontFamily: 'roboto',
                              fontSize: 14,
                              color: Colors.redAccent
                          ),
                        ),
                      ),
                      onTap: () async {
                        if (await canLaunch(widget.product.imageList)) {
                          await launch(widget.product.imageList);
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
                              fontFamily: 'roboto',
                              fontSize: 14,
                              color: Colors.white
                          ),
                        ),
                      ),
                      onTap: () async {
                        deleteImage(widget.data + '/'+widget.product.id+'.png');
                        await deleteRequest(widget.product.id);
                      },
                    ),

                    Container(
                      width: 30,
                    ),

                    GestureDetector(
                      child:Container(
                        width: 120,
                        decoration: BoxDecoration(
                          color: widget.product.OpenStatus == 0 ? Colors.redAccent : Colors.blueAccent,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          widget.product.OpenStatus == 0 ? 'Đang tắt' : 'Đang bật',
                          style: TextStyle(
                              fontFamily: 'roboto',
                              fontSize: 14,
                              color: Colors.white
                          ),
                        ),
                      ),
                      onTap: () async {
                        if (widget.product.OpenStatus == 0) {
                          await changeStatus(1);
                          toastMessage('Đã mở món ăn');
                          setState(() {

                          });
                        } else {
                          await changeStatus(0);
                          toastMessage('Đã đóng món ăn');
                          setState(() {

                          });
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


