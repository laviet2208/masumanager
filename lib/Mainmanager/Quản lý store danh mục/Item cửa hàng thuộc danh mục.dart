import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/accountShop.dart';

import '../../dataClass/Time.dart';

class Itemcuahangtrongdanhmuc extends StatefulWidget {
  final double width;
  final String id;
  final Color color;
  final VoidCallback delete;
  const Itemcuahangtrongdanhmuc({Key? key, required this.width, required this.id, required this.color, required this.delete}) : super(key: key);

  @override
  State<Itemcuahangtrongdanhmuc> createState() => _ItemnhahangtrongdanhmucState();
}

class _ItemnhahangtrongdanhmucState extends State<Itemcuahangtrongdanhmuc> {
  final accountShop shop = accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '', OpenStatus: 0);
  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Store/"+widget.id).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
        accountShop acshop = accountShop.fromJson(orders);
        shop.name = acshop.name;
        shop.phoneNum = acshop.phoneNum;
      setState(() {

      });
    });
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
      height: 80,
      decoration: BoxDecoration(
        color: widget.color,
        border: Border.all(
          color: Colors.grey,
          width: 1
        ),
      ),

      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: (widget.width) - (widget.width)/4 - 3,
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
                                  text: 'Tên Cửa hàng : ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'roboto',
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
                                  text: shop.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'roboto',
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
                                  text: 'Số điện thoại : ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'roboto',
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
                                  text: shop.phoneNum,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'roboto',
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
            width: (widget.width)/4 - 1,
            child: Padding(
                padding: EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 15),
                child: ListView(
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Xóa Cửa hàng',
                          style: TextStyle(
                            fontFamily: 'roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.white
                          ),
                        )
                      ),


                      onTap: widget.delete,
                    )
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
