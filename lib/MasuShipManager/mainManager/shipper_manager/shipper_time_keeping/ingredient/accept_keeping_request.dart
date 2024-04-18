import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/timeKeeping.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/utils.dart';
import 'package:masumanager/MasuShipManager/mainManager/ingredient/text_line_in_item.dart';

class accept_keeping_request extends StatefulWidget {
  final timeKeeping keeping;
  const accept_keeping_request({super.key, required this.keeping});

  @override
  State<accept_keeping_request> createState() => _accept_keeping_requestState();
}

class _accept_keeping_requestState extends State<accept_keeping_request> {
  bool loading = false;
  List<timeKeeping> keepingList1 = []; // Lịch nghỉ của shipper này được duyệt trong tháng
  List<timeKeeping> keepingList2 = []; // Lịch nghỉ được duyệt trong ngày

  void get_keeping() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("timeKeeping").once().then((DatabaseEvent event) async {
      final dynamic orders = event.snapshot.value;
      if (orders != null) {
        await orders.forEach((key, value) {
          timeKeeping keeping = timeKeeping.fromJson(value);
          if (keeping.owner.id == widget.keeping.owner.id) {
            if (keeping.status == 1) {
              if (keeping.dayOff.month == widget.keeping.dayOff.month && keeping.dayOff.year == widget.keeping.dayOff.year) {
                keepingList1.add(keeping);
              }
            }
          }

          if (keeping.dayOff.day == widget.keeping.dayOff.day && keeping.dayOff.month == widget.keeping.dayOff.month && keeping.dayOff.year == widget.keeping.dayOff.year) {
            if (keeping.status == 1) {
              keepingList2.add(keeping);
            }
          }
          setState(() {

          });
        });
      }

    });
  }

  Future<void> change_keeping_status(int status) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('timeKeeping').child(widget.keeping.id).child('status').set(status);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_keeping();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.only(top: 10, bottom: 10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      title: Text('Xác nhận cho nghỉ'),
      content: Container(
        width: MediaQuery.of(context).size.width/2,
        height: 100,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ListView(
            children: [
              Container(height: 8,),

              text_line_in_item(title: 'Số ngày nghỉ của tài xế trong tháng: ', content: keepingList1.length.toString() + " Ngày", color: Colors.redAccent),

              Container(height: 8,),

              text_line_in_item(title: 'Số shipper xin nghỉ ngày này: ', content: keepingList2.length.toString() + " Người", color: Colors.redAccent),

            ],
          ),
        ),
      ),
      actions: <Widget>[
        !loading ? TextButton(
          onPressed: () async {
            if (widget.keeping.status == 0) {
              setState(() {
                loading = true;
              });
              await change_keeping_status(1);
              setState(() {
                loading = false;
              });
              toastMessage('Đã chấp nhận');
              Navigator.of(context).pop();
            } else {
              toastMessage('Đơn đã phê duyệt rồi');
            }
          },
          child: Text('Đồng ý', style: TextStyle(color: Colors.blueAccent),),
        ) : CircularProgressIndicator(color: Colors.blueAccent,),

        !loading ? TextButton(
          onPressed: () async {
            if (widget.keeping.status == 0) {
              setState(() {
                loading = true;
              });
              await change_keeping_status(2);
              setState(() {
                loading = false;
              });
              toastMessage('Đã chấp nhận');
              Navigator.of(context).pop();
            } else {
              toastMessage('Đơn đã phê duyệt rồi');
            }
          },
          child: Text('Từ chối', style: TextStyle(color: Colors.redAccent),),
        ) : CircularProgressIndicator(color: Colors.redAccent,),
      ],
    );
  }
}
