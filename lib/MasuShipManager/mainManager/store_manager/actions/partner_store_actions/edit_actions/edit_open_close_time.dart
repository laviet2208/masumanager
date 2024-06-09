import 'package:flutter/material.dart';
import '../../../../../Data/accountData/shopData/shopAccount.dart';
import '../../../../../Data/otherData/Time.dart';
import '../../../../../Data/otherData/utils.dart';
import 'package:firebase_database/firebase_database.dart';


class edit_open_close_time extends StatefulWidget {
  final ShopAccount account;
  const edit_open_close_time({super.key, required this.account});

  @override
  State<edit_open_close_time> createState() => _edit_open_close_timeState();
}

class _edit_open_close_timeState extends State<edit_open_close_time> {
  bool loading = false;
  final openController = TextEditingController();
  final closeController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();

  //Hàm chọn giờ
  Future<void> _selectTime(BuildContext context, Time time, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        time.hour = selectedTime.hour;
        time.minute = selectedTime.minute;
        time.second = 0;
        controller.text = '${selectedTime.hour >= 10 ? selectedTime.hour.toString() : '0' + selectedTime.hour.toString()}:${selectedTime.minute >= 10 ? selectedTime.minute.toString() : '0' + selectedTime.minute.toString()}:00';
      });
    }
  }

  Future<void> edit_restaurant(ShopAccount account) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Store').child(account.id).set(account.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Sửa Shop thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    closeController.text = '${widget.account.closeTime.hour >= 10 ? widget.account.closeTime.hour.toString() : '0' + widget.account.closeTime.hour.toString()}:${widget.account.closeTime.minute >= 10 ? widget.account.closeTime.minute.toString() : '0' + widget.account.closeTime.minute.toString()}:00';
    openController.text = '${widget.account.openTime.hour >= 10 ? widget.account.openTime.hour.toString() : '0' + widget.account.openTime.hour.toString()}:${widget.account.openTime.minute >= 10 ? widget.account.openTime.minute.toString() : '0' + widget.account.openTime.minute.toString()}:00';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Chỉnh sửa thời gian'),
      content: Container(
        width: MediaQuery.of(context).size.width/2.5,
        height: MediaQuery.of(context).size.height/2,
        child: ListView(
          children: [
            Container(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Giờ mở cửa Shop *',
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
                        controller: openController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Click chọn giờ mở cửa',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'arial',
                          ),
                        ),
                        onTap: () {
                          _selectTime(context,widget.account.openTime,openController);
                          setState(() {

                          });
                        },
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
                'Giờ đóng cửa Shop *',
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
                        controller: closeController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Click chọn giờ đóng cửa',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'arial',
                          ),
                        ),
                        onTap: () {
                          _selectTime(context,widget.account.closeTime,closeController);
                          setState(() {

                          });
                        },
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
        loading ? CircularProgressIndicator() : TextButton(
          onPressed: loading ? null : () async {
            setState(() {
              loading = true;
            });

            await edit_restaurant(widget.account);
            setState(() {
              loading = false;
            });
            Navigator.of(context).pop();
          },
          child: Text(
            'Lưu',
            style: TextStyle(
                fontFamily: 'muli',
                color: Colors.blueAccent
            ),
          ),
        ),

        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
          child: Text(
            'Hủy',
            style: TextStyle(
                color: Colors.redAccent
            ),
          ),
        ),
      ],
    );
  }
}
