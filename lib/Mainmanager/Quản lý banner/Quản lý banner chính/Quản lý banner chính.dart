import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20banner/Itembannertop.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20banner/Qu%E1%BA%A3n%20l%C3%BD%20banner%20ch%C3%ADnh/Topbanner.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';
import 'package:masumanager/utils/utils.dart';

import '../../../dataClass/Time.dart';
import '../Thêm sửa banner/Thêm banner cửa hàng.dart';

class Quanlybannerchinhtrencung extends StatefulWidget {
  final double width;
  final double height;
  const Quanlybannerchinhtrencung({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Quanlybannerchinhtrencung> createState() => _QuanlybannerchinhtrencungState();
}

class _QuanlybannerchinhtrencungState extends State<Quanlybannerchinhtrencung> {
  final URLcontrol = TextEditingController();
  final URL1control = TextEditingController();
  List<Topbanner> adsList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("adsTOP").onValue.listen((event) {
      adsList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Topbanner food= Topbanner.fromJson(value);
        adsList.add(food);
      });
      setState(() {

      });
    });
  }

  Time getCurrentTime() {
    DateTime now = DateTime.now();

    Time currentTime = Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0);
    currentTime.second = now.second;
    currentTime.minute = now.minute;
    currentTime.hour = now.hour;
    currentTime.day = now.day;
    currentTime.month = now.month;
    currentTime.year = now.year;

    return currentTime;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
              child: Container(
                width: 240,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text(
                  '+ Thêm banner top',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontFamily: 'roboto',
                      fontSize: 14
                  ),
                ),
              ),
              onTap: () {
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
                                    fontFamily: 'roboto',
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
                                          fontFamily: 'roboto',
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Kích cỡ đề nghị 1920x668',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontFamily: 'roboto',
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
                                    fontFamily: 'roboto',
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
                                          fontFamily: 'roboto',
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Nhập liên kết web hoặc facebook,...',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontFamily: 'roboto',
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
                              Topbanner top = Topbanner(URLimage: URLcontrol.text.toString(), URL: URL1control.text.toString(), createTime:getCurrentTime(), id: dataCheckManager.generateRandomString(10));
                              await pushData(top);
                              toastMessage('Thêm thành công');
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
              },
            ),
          ),

          Positioned(
            top: 80,
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
                    width: (widget.width - 20)/4 - 1 - 150,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Ngày tạo Banner',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'roboto',
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
                    width: (widget.width - 20)/4 - 1 + 150,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Liên kết ảnh',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'roboto',
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
                    width: (widget.width - 20)/4 + 100,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Liên kết đích',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'roboto',
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
                    width: (widget.width - 20)/4 - 100,
                    alignment: Alignment.center,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thao tác',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'roboto',
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
            top: 130,
            left: 10,
            child: Container(
              width: widget.width - 20,
              height: widget.height - 140,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
              ),
              child: ListView.builder(
                itemCount: adsList.length,
                itemBuilder: (context, index) {
                  return ItembannerTop(width: widget.width, height: 120, topbanner: adsList[index],color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255),
                    updateEvent: () {

                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
