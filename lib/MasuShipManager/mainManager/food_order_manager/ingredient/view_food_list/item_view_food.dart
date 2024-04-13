import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shopData/cartProduct.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:masumanager/MasuShipManager/mainManager/ingredient/text_line_in_item.dart';

import '../../../../Data/otherData/utils.dart';
import 'delete_food_dialog.dart';

class item_view_food extends StatefulWidget {
  final foodOrder order;
  final int index;
  const item_view_food({super.key, required this.order, required this.index});

  @override
  State<item_view_food> createState() => _item_view_foodState();
}

class _item_view_foodState extends State<item_view_food> {
  Future<String> _getImageURL(String imagePath) async {
    final ref = FirebaseStorage.instance.ref().child(imagePath);
    final url = await ref.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    double width = 500;
    return Container(
      width: width,
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          FutureBuilder(
            future: _getImageURL('Food/' + widget.order.productList[widget.index].product.id + '.png'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 90,
                  width: 90,
                  alignment: Alignment.center,
                  child: Container(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(color: Colors.black,),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Container(
                  height: 90,
                  width: 90,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.image,
                    size: 30,
                  )
                );
              }

              if (!snapshot.hasData) {
                return Container(
                    height: 90,
                    width: 90,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image,
                      size: 30,
                    )
                );
              }

              return Container(
                  height: 90,
                  width: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(snapshot.data!.toString()),
                    )
                  ),
              );
            },
          ),

          Container(width: 10,),

          Container(
            width: 350,
            child: ListView(
              children: [
                Container(height: 5,),

                text_line_in_item(title: 'Tên món ăn: ', content: widget.order.productList[widget.index].product.name),

                Container(height: 8,),

                text_line_in_item(title: 'Số lượng: ', content: widget.order.productList[widget.index].number.toString()),

                Container(height: 8,),

                text_line_in_item(title: 'Đơn giá: ', content: getStringNumber(widget.order.productList[widget.index].product.cost) + '.đ'),
              ],
            ),
          ),

          Container(width: 10,),

          GestureDetector(
            child: Container(
              width: 30,
              alignment: Alignment.center,
              child: Icon(
                Icons.delete_forever,
                color: Colors.red,
                size: 30,
              ),
            ),
            onTap: () {
              if (widget.order.status == 'A' || widget.order.status == 'B' || widget.order.status == 'C' || widget.order.status == 'D') {
                showDialog(
                    context: context,
                    builder: (context) {
                      return delete_food_dialog(order: widget.order, index: widget.index);
                    }
                );
              } else {
                toastMessage('Không thể xóa');
              }
            },
          ),
        ],
      ),
    );
  }
}
