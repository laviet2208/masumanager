import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20banner/Qu%E1%BA%A3n%20l%C3%BD%20banner%20ch%C3%ADnh/Topbanner.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../utils/utils.dart';

class ItembannerTop extends StatefulWidget {
  final double width;
  final double height;
  final Topbanner topbanner;
  final VoidCallback updateEvent;
  final Color color;
  const ItembannerTop({Key? key, required this.width, required this.height, required this.topbanner, required this.updateEvent, required this.color}) : super(key: key);

  @override
  State<ItembannerTop> createState() => _ItembannerTopState();
}

class _ItembannerTopState extends State<ItembannerTop> {
  final URLcontrol = TextEditingController();
  final URL1control = TextEditingController();

  Future<void> deleteBanner(String id) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('adsTOP/' + id).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushData(Topbanner topbanner) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('adsTOP/' + topbanner.id).set(topbanner.toJson());
      setState(() {

      });
      toastMessage('Thêm ads thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  GestureDetector getButton(String text, Color backgroundColor, Color borderColor, Color TextColor, double borderRadius, VoidCallback event) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: backgroundColor,
            border: Border.all(
                width: 1,
                color: borderColor
            )
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'muli',
              color: TextColor,
              fontSize: 13
          ),
        ),
      ),
      onTap: event,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    URLcontrol.text = widget.topbanner.URLimage;
    URL1control.text = widget.topbanner.URL;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width-20,
      height: 100,
      decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(
              color: Colors.grey,
              width: 1
          )
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: (widget.width - 20)/4 - 1 - 150,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10,),
                child: Text(
                  (widget.topbanner.createTime.hour < 10 ?'0' + widget.topbanner.createTime.hour.toString() : widget.topbanner.createTime.hour.toString()) + ":" + (widget.topbanner.createTime.minute < 10 ?'0' + widget.topbanner.createTime.minute.toString() : widget.topbanner.createTime.minute.toString()) + ":" + (widget.topbanner.createTime.second < 10 ?'0' + widget.topbanner.createTime.second.toString() : widget.topbanner.createTime.second.toString()) + " Ngày 0" + widget.topbanner.createTime.day.toString() + "/" + widget.topbanner.createTime.month.toString() + "/" + widget.topbanner.createTime.year.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'muli',
                      color: Colors.black,
                      fontSize: 16
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
            width: (widget.width - 20)/4 - 1 + 150,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10,),
                child: Text(
                  widget.topbanner.URLimage,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'muli',
                      color: Colors.purple,
                      fontSize: 16
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
            width: (widget.width - 20)/4 + 100,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10,),
                child: Text(
                  widget.topbanner.URL,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'muli',
                      color: Colors.black,
                      fontSize: 16
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
            width: (widget.width - 20)/4 - 100,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(top: 5, right: 10, left: 10, bottom: 5),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0, // Khoảng cách giữa các item theo chiều ngang
                        mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng theo chiều dọc
                        childAspectRatio: 4
                    ),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 1) {
                        return getButton('Xóa', Colors.white, Colors.redAccent, Colors.redAccent, 0, () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Xác nhận xóa'),
                                content: Text('Bạn có chắc chắn xóa banner không.'),
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
                                      await deleteBanner(widget.topbanner.id);
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

                        });
                      }
                      if (index == 2) {
                        return getButton('Xem ảnh', Colors.white, Colors.redAccent, Colors.redAccent, 0, () async {
                          if (await canLaunch(widget.topbanner.URLimage)) {
                            await launch(widget.topbanner.URLimage);
                          } else {
                            toastMessage('Không thể mở ảnh');
                          }
                        },);
                      }
                      if (index == 3) {
                        return getButton('Xem URL', Colors.blue, Colors.blue, Colors.white, 0, () async {
                          if (await canLaunch(widget.topbanner.URL)) {
                            await launch(widget.topbanner.URL);
                          } else {
                            toastMessage('Không thể mở ảnh');
                          }
                        },);
                      }
                      return getButton('Cập nhật', Colors.redAccent, Colors.redAccent, Colors.white, 0, () async {
                        showDialog (
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Container(
                                width: widget.width/2,
                                height: 200,
                                child: ListView(
                                  children: [
                                    Container(
                                      height: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'URL banner top (1920x668) *',
                                        style: TextStyle(
                                            fontFamily: 'muli',
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
                                                controller: URLcontrol,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: 'muli',
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Kích cỡ đề nghị 1920x668',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontFamily: 'muli',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                    ),

                                    Container(
                                      height: 20,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'URL liên kết của banner *',
                                        style: TextStyle(
                                            fontFamily: 'muli',
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
                                                controller: URL1control,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: 'muli',
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Nhập liên kết web hoặc facebook,...',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontFamily: 'muli',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                    ),

                                    Container(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () async {
                                    if (URLcontrol.text.isNotEmpty && URL1control.text.isNotEmpty) {
                                      Topbanner top = Topbanner(URLimage: URLcontrol.text.toString(), URL: URL1control.text.toString(),createTime: widget.topbanner.createTime, id: widget.topbanner.id);
                                      await pushData(top);
                                      toastMessage('Lưu thành công');
                                      Navigator.of(context).pop();
                                    } else {
                                      toastMessage('Vui lòng nhập đủ thông tin');
                                    }
                                  },
                                  child: Text('Lưu',style: TextStyle(color: Colors.blueAccent),),)
                              ],
                            );
                          },
                        );
                      });
                    }
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
