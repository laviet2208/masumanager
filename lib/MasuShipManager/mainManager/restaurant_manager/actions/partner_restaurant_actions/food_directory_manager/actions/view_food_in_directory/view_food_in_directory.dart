import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/mainManager/restaurant_manager/actions/partner_restaurant_actions/food_directory_manager/actions/view_food_in_directory/add_food_into_directory.dart';
import 'package:masumanager/MasuShipManager/mainManager/restaurant_manager/actions/partner_restaurant_actions/food_directory_manager/actions/view_food_in_directory/item_food_in_directory.dart';
import '../../../../../../../Data/accountData/shopData/productDirectory.dart';
import '../../../../../../../Data/accountData/shopData/shopAccount.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';

class view_food_in_directory extends StatefulWidget {
  final ShopAccount account;
  final productDirectory directory;
  const view_food_in_directory({super.key, required this.account, required this.directory});

  @override
  State<view_food_in_directory> createState() => _view_food_in_directoryState();
}

class _view_food_in_directoryState extends State<view_food_in_directory> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/2;
    return AlertDialog(
      title: Text(widget.directory.mainName),
      content: Container(
        width: MediaQuery.of(context).size.width/2,
        height: MediaQuery.of(context).size.height/3*2,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                      width: 150,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        border: Border.all(width: 1),
                      ),
                      child: Center(
                        child: Text(
                          'Thêm món',
                          style: TextStyle(
                              fontFamily: 'muli',
                              fontSize: 12,
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
                          return add_food_into_directory(directory: widget.directory);
                        },
                      );
                    },
                  ),

                  Container(width: 5,),

                  GestureDetector(
                    child: Icon(
                      Icons.history,
                      color: Colors.black,
                    ),
                    onTap: () {
                      setState(() {

                      });
                    },
                  )
                ],
              ),
            ),

            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Container(
                height: 45,
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
                      width: (width - 50)/2 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 13),
                          child: AutoSizeText(
                            'Thông tin món ăn',
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
                      width: (width - 50)/2 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 13),
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
              top: 95,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                child: ListView.builder(
                  itemCount: widget.directory.foodList.length,
                  itemBuilder: (context, index) {
                    return item_food_in_directory(productId: widget.directory.foodList[index], index: index, directory: widget.directory,);
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
