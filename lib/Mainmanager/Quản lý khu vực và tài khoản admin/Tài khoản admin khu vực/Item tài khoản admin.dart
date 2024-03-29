import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20khu%20v%E1%BB%B1c%20v%C3%A0%20t%C3%A0i%20kho%E1%BA%A3n%20admin/Area.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20khu%20v%E1%BB%B1c%20v%C3%A0%20t%C3%A0i%20kho%E1%BA%A3n%20admin/T%C3%A0i%20kho%E1%BA%A3n%20admin%20khu%20v%E1%BB%B1c/S%E1%BB%ADa%20t%C3%A0i%20kho%E1%BA%A3n%20Admin.dart';
import 'package:masumanager/dataClass/adminaccount.dart';

import '../../../utils/utils.dart';

class ITEMadminaccount extends StatefulWidget {
  final double width;
  final AdminAccount adminAccount;
  final Color color;
  const ITEMadminaccount({Key? key, required this.width, required this.adminAccount, required this.color}) : super(key: key);

  @override
  State<ITEMadminaccount> createState() => _ITEMadminaccountState();
}

class _ITEMadminaccountState extends State<ITEMadminaccount> {
  final Area area = Area(id: '', name: '', money: 0, status: 0);

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").child(widget.adminAccount.provinceCode).onValue.listen((event) {
      final dynamic are = event.snapshot.value;
      Area areas = Area.fromJson(are);
      area.name = areas.name;
      area.id = areas.id;
      area.status = areas.status;
      setState(() {

      });
    });
  }

  Future<void> deleteAccount(String id) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('ADMINaccount/' + id).remove();
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
    getData();
  }

  @override
  Widget build(BuildContext context) {
    String statusText = 'Đang kích hoạt';
    Color statusColor = Colors.green;
    if (area.status != 0) {
      String statusText = 'Vô hiệu hóa';
      Color statusColor = Colors.red;
    }
    return Container(
      width: widget.width,
      height: 90,
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
            width: (widget.width-20)/5 - 1,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: Container(
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1,
                        color: statusColor
                    )
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: AutoSizeText(
                    statusText,
                    style: TextStyle(
                        fontFamily: 'muli',
                        fontWeight: FontWeight.normal,
                        color: statusColor,
                        fontSize: 100
                    ),
                  ),
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
            width: (widget.width-20)/5 - 1,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    widget.adminAccount.username,
                    style: TextStyle(
                        fontFamily: 'muli',
                        fontWeight: FontWeight.normal,
                        color: Colors.purple,
                        fontSize: 16
                    ),
                  ),
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
            width: (widget.width-20)/5 - 1,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    widget.adminAccount.password,
                    style: TextStyle(
                        fontFamily: 'muli',
                        fontWeight: FontWeight.normal,
                        color: Colors.purple,
                        fontSize: 16
                    ),
                  ),
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
            width: (widget.width-20)/5 - 1,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    widget.adminAccount.provinceCode == '0' ? 'Admin cao nhất' : area.name,
                    style: TextStyle(
                        fontFamily: 'muli',
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 16
                    ),
                  ),
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
            width: (widget.width-20)/5 - 1,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: Container(
                child: ListView(
                  children: [
                    Container(
                      height: 15,
                    ),

                    GestureDetector(
                      child: Container(
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Text(
                          'Cập nhật',
                          style: TextStyle(
                              fontFamily: 'muli',
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SuaTKadmin(adminAccount: widget.adminAccount);
                            }
                        );
                      },
                    ),

                    Container(
                      height: 8,
                    ),

                    GestureDetector(
                      child: Container(
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                            width: 1,
                            color: Colors.redAccent
                          )
                        ),
                        child: Text(
                          'Xóa tài khoản',
                          style: TextStyle(
                              fontFamily: 'muli',
                              fontSize: 13,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ),
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Bạn có chắc chắn xóa'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Hủy'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),

                                  TextButton(
                                    child: Text('Đồng ý'),
                                    onPressed: () async {
                                      await deleteAccount(widget.adminAccount.username);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            }
                        );
                      },
                    ),

                    Container(
                      height: 8,
                    ),
                  ],
                )
              ),
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
