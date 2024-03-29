import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:masumanager/MasuShipManager/mainManager/restaurant_manager/actions/partner_restaurant_actions/food_manager/actions/change_food_cost.dart';
import 'package:masumanager/MasuShipManager/mainManager/restaurant_manager/actions/partner_restaurant_actions/food_manager/actions/change_food_name_description.dart';
import 'package:masumanager/MasuShipManager/mainManager/restaurant_manager/actions/partner_restaurant_actions/food_manager/actions/delete_food.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:masumanager/MasuShipManager/mainManager/restaurant_manager/actions/partner_restaurant_actions/food_manager/actions/on_off_food.dart';
import '../../../../../Data/accountData/shopData/Product.dart';
import '../../../../shipper_manager/shipper_manager_main/action/upload_image.dart';

class item_food extends StatefulWidget {
  final Product product;
  final int index;
  const item_food({super.key, required this.product, required this.index});

  @override
  State<item_food> createState() => _item_foodState();
}

class _item_foodState extends State<item_food> {
  Future<String> _getImageURL(String imagePath) async {
    final ref = FirebaseStorage.instance.ref().child('Food').child(imagePath);
    final url = await ref.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 120;
    double height = 140;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: widget.index % 2 == 0 ? Colors.white : Color.fromARGB(255, 247, 250, 255),
        border: Border.all(
          color: Color.fromARGB(255, 240, 240, 240),
          width: 1.0,
        ),
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 49,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: Center(
                child: Text(
                  (widget.index + 1).toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'muli',
                    color: Colors.black,
                    fontWeight: FontWeight.bold, // Để in đậm
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
            width: (width - 50)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Mã món ăn: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.product.id, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Tên món ăn: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.product.name, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              color: Colors.redAccent,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Mô tả món ăn: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.product.describle, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 4,),

                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      child: Text('Cập nhật thông tin', style: TextStyle(color: Colors.blueAccent, fontSize: 14),),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return change_food_name_description(product: widget.product);
                          },
                        );
                      },
                    ),
                  ),

                  Container(height: 8,),
                ],
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
            width: (width - 50)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  widget.product.status == 0 ? 'Đang đóng' : 'Đang mở',
                  style: TextStyle(
                    fontFamily: 'muli',
                    color: widget.product.status == 0 ? Colors.redAccent : Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
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
            width: (width - 50)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Giá tiền món ăn: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: getStringNumber(widget.product.cost) + ' VNĐ', // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 4,),

                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      child: Text('Cập nhật giá tiền', style: TextStyle(color: Colors.blueAccent, fontSize: 14),),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return change_food_cost(product: widget.product);
                          },
                        );
                      },
                    ),
                  ),

                  Container(height: 8,),
                ],
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
            width: (width - 50)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30,),
              child: ListView(
                children: [
                  Container(height: 4,),

                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      height: (width - 50)/5/3,
                      width: (width - 50)/5/3,
                      decoration: BoxDecoration(

                      ),
                      child: FutureBuilder(
                        future: _getImageURL(widget.product.id + '.png'),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }

                          if (snapshot.hasError) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text('Ảnh lỗi hoặc chưa có ảnh',style: TextStyle(color: Colors.black, fontFamily: 'muli', fontSize: 13),textAlign: TextAlign.center,),
                            );                                                        }

                          if (!snapshot.hasData) {
                            return Text('Image not found');
                          }

                          return Image.network(snapshot.data.toString(),fit: BoxFit.fill,);
                        },
                      ),
                    ),
                  ),

                  Container(height: 4,),

                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      child: TextButton(
                        child: Text(
                          'Chỉnh sửa ảnh',
                          style: TextStyle(
                              fontFamily: 'muli',
                              fontSize: 11,
                              color: Colors.blueAccent
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return upload_image(path: 'Food/' + widget.product.id + '.png', title: 'Ảnh món ăn');
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
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (width - 50)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 8,),

                  GestureDetector(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        border: Border.all(),
                      ),
                      child: Center(
                        child: Text(
                          'Xóa món ăn',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return delete_food(product: widget.product);
                        },
                      );
                    },
                  ),

                  Container(height: 8,),

                  GestureDetector(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                      ),
                      child: Center(
                        child: Text(
                          'Tắt/Bật',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return on_off_food(product: widget.product);
                        },
                      );
                    },
                  ),

                  Container(height: 8,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
