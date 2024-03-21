import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import 'Danh mục đồ ăn.dart';
import 'Thêm món ăn vào danh mục.dart';

class Itemdanhmucmonan extends StatefulWidget {
  final double width;
  final FoodDirectory foodDirectory;
  final Color color;
  final String data;
  const Itemdanhmucmonan({Key? key, required this.width, required this.foodDirectory, required this.color, required this.data}) : super(key: key);

  @override
  State<Itemdanhmucmonan> createState() => _ItemdanhmucmonanState();
}

class _ItemdanhmucmonanState extends State<Itemdanhmucmonan> {
  Future<void> deleteProduct(String idshop) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child(widget.data == 'Restaurant' ? 'FoodDirectory/' : 'ProductDirectory/' + idshop).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: 100,
      decoration: BoxDecoration(
        color: widget.color,
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 240, 240, 240),
            width: 1.0,
          ),
        ),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: (widget.width)/4 - 1,
            alignment: Alignment.center,
            child : Padding(
              padding: EdgeInsets.only(top: 40,bottom: 40),
              child: AutoSizeText(
                widget.foodDirectory.id,
                style: TextStyle(
                    fontFamily: 'arial',
                    color: Colors.black,
                    fontSize: 100
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
            width: (widget.width)/4 - 1,
            alignment: Alignment.center,
            child : Padding(
              padding: EdgeInsets.only(top: 40,bottom: 40),
              child: AutoSizeText(
                widget.foodDirectory.mainName,
                style: TextStyle(
                    fontFamily: 'arial',
                    color: Colors.black,
                    fontSize: 100
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
            width: (widget.width)/4 - 1,
            alignment: Alignment.center,
            child : Padding(
              padding: EdgeInsets.only(top: 40,bottom: 40),
              child: AutoSizeText(
                widget.foodDirectory.foodList.length.toString(),
                style: TextStyle(
                    fontFamily: 'arial',
                    color: Colors.black,
                    fontSize: 100
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
            width: (widget.width)/4 - 1,
            alignment: Alignment.center,
            child : Stack(
              children: <Widget>[
                Positioned(
                  top: 8,
                  left: 5,
                  child: GestureDetector(
                    child: Container(
                      width: ((widget.width)/4 -15)/2,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.redAccent
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(left: 3, right: 3 ,),
                        child: Text(
                          'Xóa danh mục',
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'roboto',
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),

                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Xác nhận xóa'),
                            content: Text('Bạn có chắc chắn xóa tài khoản không.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Hủy',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await deleteProduct(widget.foodDirectory.id);
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Đồng ý',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),

                Positioned(
                  top: 8,
                  right: 0,
                  child: GestureDetector(
                    child: Container(
                      width: ((widget.width)/4 -15)/2,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: Colors.redAccent
                          ),
                          color: Colors.white
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(left: 3, right: 3),
                        child: Text(
                          'Xem danh sách',
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'roboto',
                              color: Colors.redAccent
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 8,
                  left: 5,
                  child: GestureDetector(
                    child: Container(
                      width: ((widget.width)/4 -15)/2,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: Colors.deepOrange
                          ),
                          color: Colors.white
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(left: 3, right: 3),
                        child: AutoSizeText(
                          widget.data == 'Restaurant' ? 'Thêm món ăn' : 'Thêm sản phẩm',
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'roboto',
                              color: Colors.deepOrange
                          ),
                        ),
                      ),
                    ),

                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(widget.data == 'Restaurant' ?'Add món ăn' : 'Add sản phẩm'),
                              content: Container(
                                height: 200,
                                width: widget.width/2,
                                child: searchPagefood(id: widget.foodDirectory.id, idshop: widget.foodDirectory.ownerID, idproduct: widget.foodDirectory.foodList, data: widget.data,),
                              ),
                            );
                          });
                    },
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
