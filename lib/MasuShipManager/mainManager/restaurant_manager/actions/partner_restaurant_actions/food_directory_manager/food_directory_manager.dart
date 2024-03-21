import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shopData/shopAccount.dart';
import 'package:masumanager/MasuShipManager/mainManager/restaurant_manager/actions/partner_restaurant_actions/food_directory_manager/actions/add_food_directory.dart';
import 'package:masumanager/MasuShipManager/mainManager/restaurant_manager/actions/partner_restaurant_actions/food_directory_manager/item_food_directory.dart';

import '../../../../../Data/accountData/shopData/productDirectory.dart';

class food_directory_manager extends StatefulWidget {
  final ShopAccount account;
  const food_directory_manager({super.key, required this.account});

  @override
  State<food_directory_manager> createState() => _food_directory_managerState();
}

class _food_directory_managerState extends State<food_directory_manager> {
  List<productDirectory> directory_list = [];
  List<productDirectory> chosen_list = [];

  void get_directory_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("FoodDirectory").orderByChild("ownerID").equalTo(widget.account.id).onValue.listen((event) {
      directory_list.clear();
      chosen_list.clear();
      final dynamic direcs = event.snapshot.value;
      print(widget.account.id);
      direcs.forEach((key, value) {
        productDirectory directory= productDirectory.fromJson(value);
        directory_list.add(directory);
        chosen_list.add(directory);
      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_directory_data();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 200;
    double height = MediaQuery.of(context).size.height/3*4;
    return AlertDialog(
      title: Text('Quản lý danh mục món ăn',style: TextStyle(fontFamily: 'roboto', fontSize: 14, fontWeight: FontWeight.bold),),
      content: Container(
        width: width,
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              left: 0,
              child: GestureDetector(
                child: Container(
                  height: 35,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    border: Border.all(
                      width: 1
                    )
                  ),
                  child: Center(
                    child: Text(
                      'Thêm danh mục',
                      style: TextStyle(
                        fontFamily: 'roboto',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return add_food_directory(account: widget.account);
                    },
                  );
                },
              ),
            ),

            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: Container(
                width: width,
                height: 40,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 247, 250, 255),
                    border: Border.all(
                        width: 1,
                        color: Color.fromARGB(255, 225, 225, 226)
                    )
                ),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 49,
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
                          padding: EdgeInsets.only(left: 10, right: 10, top: 11, bottom: 11),
                          child: AutoSizeText(
                            'Tên danh mục',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'arial',
                                color: Colors.black,
                                fontSize: 100
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
                      width: (width - 50)/3 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 11, bottom: 11),
                          child: AutoSizeText(
                            'Số lượng món ăn',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'arial',
                                color: Colors.black,
                                fontSize: 100
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
                      width: (width - 50)/3 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 11, bottom: 11),
                          child: AutoSizeText(
                            'Thao tác',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'arial',
                                color: Colors.black,
                                fontSize: 100
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
                  ],
                ),
              ),
            ),

            Positioned(
              top: 100,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                child: ListView.builder(
                  itemCount: directory_list.length,
                  itemBuilder: (context, index) {
                    return item_food_directory(directory: directory_list[index], index: index, account: widget.account,);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
