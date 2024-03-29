import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20store%20danh%20m%E1%BB%A5c/Danh%20s%C3%A1ch%20c%E1%BB%ADa%20h%C3%A0ng%20trong%20danh%20m%E1%BB%A5c.dart';
import 'package:masumanager/dataClass/accountShop.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../utils/utils.dart';
import '../Quản lý khu vực và tài khoản admin/Area.dart';
import '../Quản lý nhà hàng danh mục/Danh mục.dart';
import 'Page tìm kiếm.dart';

class ITEMdanhmucshop extends StatefulWidget {
  final double width;
  final double height;
  final List<accountShop> shopList;
  final RestaurantDirectory directory;
  final VoidCallback updateEvent;
  final Color color;
  const ITEMdanhmucshop({Key? key, required this.width, required this.height, required this.shopList, required this.directory, required this.updateEvent, required this.color}) : super(key: key);

  @override
  State<ITEMdanhmucshop> createState() => _ITEMdanhmucshopState();
}

class _ITEMdanhmucshopState extends State<ITEMdanhmucshop> {
  Area aRea = Area(id: '', name: '', money: 0, status: 0);
  List<Area> areaList = [];

  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area/"+widget.directory.Area).onValue.listen((event) {
      areaList.clear();
      final dynamic orders = event.snapshot.value;
      Area area= Area.fromJson(orders);
      aRea.name = area.name;
      setState(() {

      });
    });
  }

  Future<void> deleteProduct(String idshop) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('StoreDirectory/' + idshop).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushData() async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('StoreDirectory/' + widget.directory.id).set(widget.directory.toJson());
      toastMessage('Thêm thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData1();
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
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: widget.width/5 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 5, right: 10, top: 15, bottom: 5),
                child: ListView(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'ID danh mục : ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'muli',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: widget.directory.id,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'muli',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(height: 10,),

                    Container(
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Cập nhật ngày : ',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'muli',
                                fontWeight: FontWeight.bold, // Để in đậm
                              ),
                            ),
                            TextSpan(
                              text: widget.directory.createTime.day.toString() + '/' + widget.directory.createTime.month.toString() + '/' + widget.directory.createTime.year.toString() + ' , ' + widget.directory.createTime.hour.toString() + ':' + widget.directory.createTime.minute.toString(), // Phần còn lại viết bình thường
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontWeight: FontWeight.normal, // Để viết bình thường
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(height: 10,),

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Tên khu vực : ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'muli',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: aRea.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'muli',
                                    color: Colors.purple,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
            width: widget.width/5,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15,),
              child: Text(
                widget.directory.mainContent,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'muli'
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
            width: widget.width/5 - 1,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15,),
              child: Text(
                widget.directory.subContent,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'muli'
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
            width: widget.width/5 - 1,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15,),
              child: Text(
                widget.directory.shopList.length.toString() + ' Cửa Hàng',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'muli'
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
            width: widget.width/5 - 1,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15,),
                child: ListView(
                  children: [
                    Container(height: 15,),

                    GestureDetector(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(
                                width: 1,
                                color: Colors.redAccent
                            )
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Cập nhật',
                          style: TextStyle(
                              fontFamily: 'muli',
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              color: Colors.white
                          ),
                        ),
                      ),
                      onTap: widget.updateEvent,
                    ),

                    Container(height: 8,),

                    GestureDetector(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(
                                color: Colors.redAccent,
                                width: 1
                            )
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Danh sách cửa hàng',
                          style: TextStyle(
                              fontFamily: 'muli',
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              color: Colors.redAccent
                          ),
                        ),
                      ),
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Danhsachcuahang(directory: widget.directory, width: widget.width/1.5, shopList: widget.shopList);
                            });
                      },
                    ),

                    Container(height: 8,),

                  ],
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
    );
  }
}
