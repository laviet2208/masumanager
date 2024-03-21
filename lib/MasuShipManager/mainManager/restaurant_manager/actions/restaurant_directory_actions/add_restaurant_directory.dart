import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/areaData/Area.dart';
import 'package:masumanager/MasuShipManager/Data/models/area_search/search_page_area.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';

import '../../../../Data/accountData/shopData/shopDirectory.dart';
import '../../../../Data/otherData/utils.dart';

class add_restaurant_directory extends StatefulWidget {
  const add_restaurant_directory({super.key});

  @override
  State<add_restaurant_directory> createState() => _add_restaurant_directoryState();
}

class _add_restaurant_directoryState extends State<add_restaurant_directory> {
  bool loading = false;
  Area area = Area(id: '', name: '', money: 0, status: 0);
  final nameController = TextEditingController();
  final subController = TextEditingController();

  Future<void> push_new_directory(shopDirectory directory) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('RestaurantDirectory').child(directory.id).set(directory.toJson());
      toastMessage('Thêm danh mục thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thêm danh mục nhà hàng', style: TextStyle(fontSize: 12),),
      content: Container(
        width: MediaQuery.of(context).size.width/3,
        height: MediaQuery.of(context).size.height/2,
        child: ListView(
          children: [
            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Tên danh mục nhà hàng *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      )
                  ),

                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Form(
                      child: TextFormField(
                        controller: nameController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tên danh mục',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'arial',
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ),

            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Phụ đề nhà hàng *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      )
                  ),

                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Form(
                      child: TextFormField(
                        controller: subController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tên phụ đề',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'arial',
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ),


            Container(
              height: 10,
            ),

            Container(
              height: 200,
              child: search_page_area(area: area),
            ),

            Container(
              height: 10,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        loading ? CircularProgressIndicator(color: Colors.blueAccent,) :TextButton(
          onPressed: () async {
            if (nameController.text.isNotEmpty && subController.text.isNotEmpty && area.id != '') {
              shopDirectory directory = shopDirectory(id: generateID(15), mainName: nameController.text.toString(), subName: subController.text.toString(), area: area.id, restaurantList: [], status: 1);
              setState(() {
                loading = true;
              });
              await push_new_directory(directory);
              Navigator.of(context).pop();
              setState(() {
                loading = false;
              });
            }
          },
          child: Text(
            'Thêm danh mục',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ),
      ],
    );
  }
}
