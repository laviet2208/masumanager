import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20nh%C3%A0%20h%C3%A0ng%20danh%20m%E1%BB%A5c/Item%20nh%C3%A0%20h%C3%A0ng%20thu%E1%BB%99c%20danh%20m%E1%BB%A5c.dart';
import 'package:masumanager/dataClass/accountShop.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../utils/utils.dart';
import '../Quản lý khu vực và tài khoản admin/Area.dart';
import 'Danh mục.dart';
import 'Page tìm kiếm.dart';

class Danhsachnhahang extends StatefulWidget {
  final RestaurantDirectory directory;
  final List<accountShop> shopList;
  final double width;
  const Danhsachnhahang({Key? key, required this.directory, required this.width, required this.shopList}) : super(key: key);

  @override
  State<Danhsachnhahang> createState() => _DanhsachnhahangState();
}

class _DanhsachnhahangState extends State<Danhsachnhahang> {
  Future<void> pushData() async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('RestaurantDirectory/' + widget.directory.id).set(widget.directory.toJson());
      toastMessage('Thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Nhà hàng trong danh mục'),
      content: Container(
        width: widget.width,
        height: 600,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              left: 10,
              child: GestureDetector(
                child: Container(
                  width: 200,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '+ Thêm nhà hàng',
                    style: TextStyle(
                        fontFamily: 'muli',
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                ),
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Add nhà hàng vào danh mục'),
                          content: Container(
                            width: 500, // Đặt kích thước chiều rộng theo ý muốn
                            height: 400,
                            child: ListView(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Container(
                                    height: 400,
                                    child: searchPagedanhmuc(list: widget.directory.shopList, list1: widget.shopList,
                                      event: () async {
                                        await pushData();
                                        Navigator.of(context).pop();
                                      },),
                                  ),

                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
            ),

            Positioned(
              top: 60,
              left: 10,
              child: Container(
                width: widget.width - 20,
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
                      width: (widget.width - 20) - (widget.width - 20)/4 - 3,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Thông tin nhà hàng',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'muli',
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
                      width: (widget.width - 20)/4 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Thao tác',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'muli',
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
              top: 110,
              left: 10,
              child: Container(
                width: widget.width-20,
                height: 480,
                child: ListView.builder(
                  itemCount: widget.directory.shopList.length,
                  itemBuilder: (context, index) {
                    return Itemnhahangtrongdanhmuc(width: widget.width-20, id: widget.directory.shopList[index], color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255),
                      delete: () async {
                        widget.directory.shopList.removeAt(index);
                        await pushData();
                        setState(() {

                        });
                      },
                    );
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
