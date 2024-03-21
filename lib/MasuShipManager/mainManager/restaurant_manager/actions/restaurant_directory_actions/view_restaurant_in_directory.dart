import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:masumanager/MasuShipManager/mainManager/restaurant_manager/actions/restaurant_directory_actions/add_restaurant_to_directory.dart';
import 'package:masumanager/MasuShipManager/mainManager/restaurant_manager/actions/restaurant_directory_actions/item_restaurant_in_directory.dart';

import '../../../../Data/accountData/shopData/shopDirectory.dart';

class view_restaurant_in_directory extends StatefulWidget {
  final shopDirectory directory;
  const view_restaurant_in_directory({super.key, required this.directory});

  @override
  State<view_restaurant_in_directory> createState() => _view_restaurant_in_directoryState();
}

class _view_restaurant_in_directoryState extends State<view_restaurant_in_directory> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/2;
    double height = MediaQuery.of(context).size.height/4*3;
    return AlertDialog(
      content: Container(
        width: width,
        height: height,
        child: Stack(
          children: <Widget>[
            //Thêm nhà hàng vào danh mục
            Positioned(
              top: 0,
              left: 0,
              child: GestureDetector(
                child: Container(
                  width: 200,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      border: Border.all()
                  ),
                  child: Center(
                    child: Text(
                      'Thêm nhà hàng',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'roboto'
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return add_restaurant_to_directory(directory: widget.directory);
                    },
                  );
                },
              ),
            ),

            //Thanh head
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Container(
                width: width,
                height: 50,
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
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Thông tin nhà hàng',
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
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
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
              child: widget.directory.restaurantList.length != 0 ? Container(
                child: ListView.builder(
                  itemCount: widget.directory.restaurantList.length,
                  itemBuilder: (context, index) {
                    return item_restaurant_in_directory(directory: widget.directory, index: index, shopId: widget.directory.restaurantList[index]);
                  },
                ),
              )  : Container(alignment: Alignment.center, child: Text('Danh sách trống', style: TextStyle(fontSize: 11),),),
            )
          ],
        ),
      ),
    );
  }
}
