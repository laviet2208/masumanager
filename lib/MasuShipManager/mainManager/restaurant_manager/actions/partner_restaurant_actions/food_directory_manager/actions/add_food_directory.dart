import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shopData/productDirectory.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shopData/shopAccount.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';

import '../../../../../../Data/otherData/utils.dart';

class add_food_directory extends StatefulWidget {
  final ShopAccount account;
  const add_food_directory({super.key, required this.account});

  @override
  State<add_food_directory> createState() => _add_food_directoryState();
}

class _add_food_directoryState extends State<add_food_directory> {
  final nameController = TextEditingController();

  Future<void> push_new_directory(productDirectory directory) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('FoodDirectory').child(directory.id).set(directory.toJson());
      toastMessage('Thêm danh mục thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> change_shop() async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Restaurant').child(widget.account.id).set(widget.account.toJson());
      toastMessage('Thêm danh mục thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/2;
    double height = MediaQuery.of(context).size.height/3;
    return AlertDialog(
        title: Text('Thêm danh mục'),
        content: Container(
          width: width,
          height: height,
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
          child: ListView(
            children: [
              Container(
                height: 10,
              ),

              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Tên danh mục đồ ăn *',
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
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Hủy'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty) {
                productDirectory directory = productDirectory(
                  id: generateID(20),
                  mainName: nameController.text.toString(),
                  foodList: [],
                  ownerID: widget.account.id,
                );
                widget.account.listDirectory.add(directory.id);
                await push_new_directory(directory);
                await change_shop();
                Navigator.of(context).pop();
              } else {
                toastMessage('Vui lòng điền tên danh mục');
              }
            },
            child: Text('Đồng ý'),
          )
        ]
    );
  }
}
