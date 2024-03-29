import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shopData/productDirectory.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:masumanager/MasuShipManager/mainManager/restaurant_manager/actions/partner_restaurant_actions/food_directory_manager/actions/view_food_in_directory/delete_food_from_directory.dart';
import '../../../../../../../Data/accountData/shopData/Product.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../../../../Data/otherData/utils.dart';

class item_food_in_directory extends StatefulWidget {
  final String productId;
  final productDirectory directory;
  final int index;
  const item_food_in_directory({super.key, required this.productId, required this.index, required this.directory});

  @override
  State<item_food_in_directory> createState() => _item_food_in_directoryState();
}

class _item_food_in_directoryState extends State<item_food_in_directory> {
  Product product = Product(id: '', cost: 0, name: '', describle: '', owner: '', status: 0, createTime: getCurrentTime());

  void get_product_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Food").child(widget.productId).onValue.listen((event) {
      final dynamic pro = event.snapshot.value;
      if (pro != null) {
        product = Product.fromJson(pro);
        setState(() {

        });
      } else {
        widget.directory.foodList.remove(widget.productId);
        change_directory(widget.directory);
      }
    });
  }

  Future<void> change_directory(productDirectory directory) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('FoodDirectory').child(directory.id).set(directory.toJson());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_product_data();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/2;
    return Container(
      width: width,
      height: 80,
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
            width: (width - 50)/2 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 4,),

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
                            text: product.name, // Phần còn lại viết bình thường
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
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Giá tiền: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: getStringNumber(product.cost) + ' VNĐ', // Phần còn lại viết bình thường
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
            width: (width - 50)/2 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  TextButton(
                    child: Text('Xóa khỏi danh mục',style: TextStyle(color: Colors.redAccent),),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return delete_food_from_directory(deleteId: widget.productId, directory: widget.directory);
                        },
                      );
                    },
                  )
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
        ],
      ),
    );
  }
}
