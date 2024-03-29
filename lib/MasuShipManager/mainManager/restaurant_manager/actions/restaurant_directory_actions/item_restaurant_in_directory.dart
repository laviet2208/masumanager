import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shopData/shopAccount.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shopData/shopDirectory.dart';
import 'package:masumanager/MasuShipManager/Data/locationData/Location.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:masumanager/MasuShipManager/mainManager/restaurant_manager/actions/partner_restaurant_actions/food_directory_manager/actions/view_food_in_directory/delete_food_from_directory.dart';
import 'package:masumanager/MasuShipManager/mainManager/restaurant_manager/actions/restaurant_directory_actions/delete_restaurant_from_directory.dart';

class item_restaurant_in_directory extends StatefulWidget {
  final shopDirectory directory;
  final int index;
  final String shopId;
  const item_restaurant_in_directory({super.key, required this.directory, required this.index, required this.shopId});

  @override
  State<item_restaurant_in_directory> createState() => _item_restaurant_in_directoryState();
}

class _item_restaurant_in_directoryState extends State<item_restaurant_in_directory> {
  ShopAccount account = ShopAccount(id: '', createTime: getCurrentTime(), lockStatus: 0, name: '', phone: '', money: 0, type: 0, password: '', closeTime: getCurrentTime(), openTime: getCurrentTime(), openStatus: 0, discount_type: 0, area: '', location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''), listDirectory: []);

  void get_shop_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Restaurant").child(widget.shopId).onValue.listen((event) {
      final dynamic pro = event.snapshot.value;
      if (pro != null) {
        account = ShopAccount.fromJson(pro);
        setState(() {

        });
      } else {
        widget.directory.restaurantList.remove(widget.shopId);
        change_directory(widget.directory);
      }
    });
  }

  void change_directory(shopDirectory directory) {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      databaseRef.child('RestaurantDirectory').child(directory.id).set(directory.toJson());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_shop_data();
  }

  @override
  Widget build(BuildContext context) {
      double width = MediaQuery.of(context).size.width/2;
    return Container(
      width: width,
      height: 70,
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
                            text: 'Tên nhà hàng: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: account.name, // Phần còn lại viết bình thường
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
                            text: 'Tên đăng nhập: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: account.phone, // Phần còn lại viết bình thường
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
                  Container(
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return delete_restaurant_from_directory(deleteId: widget.shopId, directory: widget.directory);
                          },
                        );
                      },
                      child: Text('Xóa khỏi danh mục', style: TextStyle(color: Colors.redAccent, fontSize: 13),),
                    ),
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
