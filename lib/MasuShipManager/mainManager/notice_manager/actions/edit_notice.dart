import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/noticeData/noticeData.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../Data/areaData/Area.dart';
import '../../../Data/models/area_search/search_page_area.dart';
import '../../../Data/otherData/Tool.dart';
import '../../../Data/otherData/utils.dart';

class edit_notice extends StatefulWidget {
  final noticeData data;
  const edit_notice({super.key, required this.data});

  @override
  State<edit_notice> createState() => _edit_noticeState();
}

class _edit_noticeState extends State<edit_notice> {
  List<String> receiverList = ['Người dùng', 'Shipper'];
  String chosenReceiver = '';
  int type = 0;
  bool loading = false;
  Area area = Area(id: '', name: '', money: 0, status: 0);
  final tieudecontrol = TextEditingController();
  final tieudephucontrol = TextEditingController();
  final noidungcontrol = TextEditingController();

  void drop_down_receiver(String? selectedValue) {
    if (selectedValue is String) {
      chosenReceiver = selectedValue;
      if (chosenReceiver == 'Người dùng') {
        type = 0;
      }

      if (chosenReceiver == 'Shipper') {
        type = 1;
      }
    }

    setState(() {

    });
  }

  Future<void> push_notice(noticeData data) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Notification').child(data.id).set(data.toJson());
      toastMessage('Sửa thông báo thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    type = widget.data.object;
    chosenReceiver = receiverList[widget.data.object];
    tieudecontrol.text = widget.data.title;
    tieudephucontrol.text = widget.data.sub;
    noidungcontrol.text = widget.data.content;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/2;
    double height = MediaQuery.of(context).size.height * (2/3);
    return AlertDialog(
        title: Text('Sửa thông báo'),
        content: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            children: [
              Container(
                height: 10,
              ),

              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Tiêu đề thông báo *',
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
                          controller: tieudecontrol,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'muli',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Tiêu đề thông báo',
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
                height: 10,
              ),

              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Tiêu đề phụ thông báo *',
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
                          controller: tieudephucontrol,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'muli',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Tiêu đề thông báo',
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
                height: 10,
              ),

              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Nội dung thông báo *',
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
                          controller: noidungcontrol,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'muli',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nội dung thông báo',
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
                height: 10,
              ),

              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Chọn loại người nhận *',
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
                  width: 200,
                  height: 40,
                  child: DropdownButton<String>(
                    items: receiverList.map((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text('Đối tượng : ' + e),
                    )).toList(),
                    onChanged: (value) { drop_down_receiver(value); },
                    value: chosenReceiver,
                    iconEnabledColor: Colors.redAccent,
                    isExpanded: true,
                    iconDisabledColor: Colors.grey,
                  ),
                ),
              ),

              Container(
                height: 10,
              ),

              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Chọn khu vực quản lý *',
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
                  height: 150,
                  child: search_page_area(area: area),
                ),
              ),

              Container(
                height: 40,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Hủy', style: TextStyle(color: Colors.redAccent),),
            onPressed: () {
              tieudecontrol.clear();
              noidungcontrol.clear();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: loading ? CircularProgressIndicator() : Text('Thêm quảng cáo'),
            onPressed: loading ? null : () async {
              if (tieudecontrol.text.isNotEmpty && noidungcontrol.text.isNotEmpty && area.id != '') {
                setState(() {
                  loading = true;
                });
                noticeData data = noticeData(
                  id: widget.data.id,
                  area: area.id,
                  title: tieudecontrol.text.toString(),
                  sub: tieudephucontrol.text.toString(),
                  object: type,
                  create: getCurrentTime(),
                  send: getCurrentTime(),
                  status: 0,
                  content: noidungcontrol.text.toString(),
                );
                await push_notice(data);
                setState(() {
                  loading = false;
                });
                Navigator.of(context).pop();
              } else {
                toastMessage('Phải nhập đủ thông tin');
              }
            },
          ),
        ]
    );
  }
}
