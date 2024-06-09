import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shopData/productDirectory.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shopData/shopAccount.dart';
import 'package:masumanager/MasuShipManager/mainManager/restaurant_manager/actions/partner_restaurant_actions/food_directory_manager/actions/delete_food_directory.dart';
import 'package:masumanager/MasuShipManager/mainManager/restaurant_manager/actions/partner_restaurant_actions/food_directory_manager/actions/view_food_in_directory/view_food_in_directory.dart';
import 'package:masumanager/MasuShipManager/mainManager/store_manager/actions/partner_store_actions/product_directory_manager/actions/delete_product_directory.dart';

import 'actions/view_food_in_directory/view_product_in_directory.dart';

class item_product_directory extends StatefulWidget {
  final productDirectory directory;
  final ShopAccount account;
  final int index;
  const item_product_directory({super.key, required this.directory, required this.index, required this.account});

  @override
  State<item_product_directory> createState() => _item_product_directoryState();
}

class _item_product_directoryState extends State<item_product_directory> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 200;
    double height = 70;
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
            width: (width - 50)/3 - 1,
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
                            text: 'Tên danh mục: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.directory.mainName, // Phần còn lại viết bình thường
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
            width: (width - 50)/3 - 1,
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
                            text: 'Số lượng món ăn: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.directory.foodList.length.toString(), // Phần còn lại viết bình thường
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
            width: (width - 50)/3 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 4,),

                  GestureDetector(
                    child: Container(
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        border: Border.all(width: 1),
                      ),
                      child: Center(
                        child: Text(
                          'Xóa danh mục',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return delete_product_directory(directory: widget.directory, account: widget.account);
                        },
                      );
                    },
                  ),

                  Container(height: 4,),

                  GestureDetector(
                    child: Container(
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1),
                      ),
                      child: Center(
                        child: Text(
                          'Xem sản phẩm trong danh mục',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return view_product_in_directory(directory: widget.directory, account: widget.account);
                        },
                      );
                    },
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
        ],
      ),
    );
  }
}
