import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20khu%20v%E1%BB%B1c%20v%C3%A0%20t%C3%A0i%20kho%E1%BA%A3n%20admin/Area.dart';
import 'package:masumanager/dataClass/accountShop.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../dataClass/Time.dart';
import '../../utils/utils.dart';
import 'Voucher.dart';

class ITEMdanhsach extends StatefulWidget {
  final double width;
  final double height;
  final Voucher voucher;
  final VoidCallback onTapUpdate;
  final Color color;
  const ITEMdanhsach({Key? key, required this.width, required this.height, required this.voucher, required this.onTapUpdate, required this.color}) : super(key: key);

  @override
  State<ITEMdanhsach> createState() => _ITEMdanhsachState();
}

class _ITEMdanhsachState extends State<ITEMdanhsach> {
  final Area area = Area(id: '', name: '', money: 0, status: 0);
  final accountShop shop = accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '', OpenStatus: 0);
  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area/" + widget.voucher.LocationId).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      Area a = Area.fromJson(orders);
      area.name = a.name;
      setState(() {

      });
    });
  }

  void getData2() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Restaurant/" + widget.voucher.Otype).onValue.listen((event) {
      final dynamic orders = event.snapshot.value;
      accountShop a = accountShop.fromJson(orders);
      shop.name = a.name;
      setState(() {

      });
    });
  }

  Future<void> deleteProduct(String idshop) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('VoucherStorage/' + idshop).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData1();
    if (widget.voucher.Otype != '1') {
      getData2();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
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
            width: (widget.width)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Chương trình : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.voucher.tenchuongtrinh, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              color: Colors.redAccent,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Mã code : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.voucher.id, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              color: Colors.redAccent,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Đối tượng : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: (widget.voucher.Otype == '1') ? area.name : shop.name, // Phần còn lại viết bình thường
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
            width: (widget.width)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Bắt đầu : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.voucher.startTime.day.toString() + "/" + widget.voucher.startTime.month.toString() + "/" + widget.voucher.startTime.year.toString(), // Phần còn lại viết bình thường
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

                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Kết thúc : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.voucher.endTime.day.toString() + "/" + widget.voucher.endTime.month.toString() + "/" + widget.voucher.endTime.year.toString(), // Phần còn lại viết bình thường
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
            width: (widget.width)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Giảm giá : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: (widget.voucher.type == 0) ? (dataCheckManager.getStringNumber(widget.voucher.totalmoney) + 'VNĐ') : (dataCheckManager.getStringNumber(widget.voucher.totalmoney) + '%'), // Phần còn lại viết bình thường
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

                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'cho đơn từ : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: dataCheckManager.getStringNumber(widget.voucher.mincost) + 'VNĐ', // Phần còn lại viết bình thường
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

                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Giảm tối đa : ',
                            style: TextStyle(
                              fontSize: widget.voucher.type == 0 ? 0 : 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: dataCheckManager.getStringNumber(widget.voucher.maxSale) + 'VNĐ', // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: widget.voucher.type == 0 ? 0 : 16,
                              fontFamily: 'muli',
                              color: Colors.black,
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
            width: (widget.width)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Đã sử dụng : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text:  widget.voucher.useCount.toString() + ' Lượt', // Phần còn lại viết bình thường
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

                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Giới hạn : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.voucher.maxCount.toString() + ' Lượt', // Phần còn lại viết bình thường
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

                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Tối đa mỗi khách : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.voucher.perCustom.toString() + ' Lượt', // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              color: Colors.purple,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 15,),
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
            width: (widget.width)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 10,),

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
                    onTap: widget.onTapUpdate,
                  ),

                  Container(height: 10,),

                  GestureDetector(
                    child: Container(
                      width: widget.width/10,
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
                        'Xóa voucher',
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
                          return AlertDialog(
                            title: Text('Xác nhận xóa voucher',),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () async {
                                  await deleteProduct(widget.voucher.id);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Xác nhận', style: TextStyle(color: Colors.redAccent)),
                              ),

                              TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Hủy', style: TextStyle(color: Colors.black)),
                              ),
                            ],
                          );
                        },
                      );

                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
