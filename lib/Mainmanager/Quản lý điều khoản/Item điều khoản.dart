import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20%C4%91i%E1%BB%81u%20kho%E1%BA%A3n/Policy.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../dataClass/Time.dart';
import '../../utils/utils.dart';

class Itemdieukhoan extends StatefulWidget {
  final double width;
  final double height;
  final Policy policy;
  final Color color;
  const Itemdieukhoan({Key? key, required this.width, required this.height, required this.policy, required this.color}) : super(key: key);

  @override
  State<Itemdieukhoan> createState() => _ItemdieukhoanState();
}

class _ItemdieukhoanState extends State<Itemdieukhoan> {
  final tieudecontrol = TextEditingController();
  final noidungcontrol = TextEditingController();

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

  Future<void> deletePolicy(String id) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Policy/' + id).remove();
      toastMessage('xóa thành công');
    } catch (error) {
      toastMessage('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushData(Policy policy) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Policy').child(policy.id).set(policy.toJson());
      setState(() {

      });
      toastMessage('Sửa điều khoản thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tieudecontrol.text = widget.policy.title;
    noidungcontrol.text = widget.policy.content;
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
                  (widget.policy.createTime.hour < 10 ?'0' + widget.policy.createTime.hour.toString() : widget.policy.createTime.hour.toString()) + ":" + (widget.policy.createTime.minute < 10 ?'0' + widget.policy.createTime.minute.toString() : widget.policy.createTime.minute.toString()) + ":" + (widget.policy.createTime.second < 10 ?'0' + widget.policy.createTime.second.toString() : widget.policy.createTime.second.toString()) + " Ngày 0" + widget.policy.createTime.day.toString() + "/" + widget.policy.createTime.month.toString() + "/" + widget.policy.createTime.year.toString(),
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
                  widget.policy.title,
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
                child: ListView(
                  children: [
                    Text(
                      widget.policy.content,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'muli',
                          color: Colors.black,
                          fontSize: 16
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
            width: (widget.width - 20)/4 - 100,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(top: 5, right: 10, left: 10, bottom: 5),
                child: ListView(
                  children: [
                    Container(
                      height: 10,
                    ),

                    GestureDetector(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.redAccent
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Cập nhật',
                          style: TextStyle(
                              fontFamily: 'muli',
                              color: Colors.white,
                              fontSize: 12
                          ),
                        ),
                      ),

                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Thêm điều khoản'),
                              content: Container(
                                width: 700,
                                height: 200,
                                child: ListView(
                                  children: [
                                    Container(
                                      height: 10,
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Tên điều khoản *',
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
                                                controller: tieudecontrol,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: 'arial',
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Nhập tên điều khoản',
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
                                        'Nội dung điều khoản *',
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
                                                controller: noidungcontrol,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: 'arial',
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Nhập nội dung điều khoản',
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
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () async {
                                    if (tieudecontrol.text.isNotEmpty && noidungcontrol.text.isNotEmpty) {
                                      Policy policy = Policy(id: widget.policy.id, createTime: widget.policy.createTime, title: tieudecontrol.text.toString(), content: noidungcontrol.text.toString());
                                      await pushData(policy);
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Text('Lưu', style: TextStyle(color: Colors.blueAccent),),
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),

                    Container(
                      height: 5,
                    ),

                    GestureDetector(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: Colors.redAccent
                          )
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Xóa điều khoản',
                          style: TextStyle(
                              fontFamily: 'muli',
                              color: Colors.redAccent,
                              fontSize: 12
                          ),
                        ),
                      ),

                      onTap: () async {
                        await deletePolicy(widget.policy.id);
                      },
                    ),

                    Container(
                      height: 10,
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
        ],
      ),
    );
  }
}
