import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import '../../../Data/adsData/restaurantAdsData.dart';
import '../../../Data/otherData/utils.dart';

class on_off_ads extends StatefulWidget {
  final restaurantAdsData data;
  const on_off_ads({super.key, required this.data});

  @override
  State<on_off_ads> createState() => _on_off_adsState();
}

class _on_off_adsState extends State<on_off_ads> {
  bool loading = false;

  Future<void> change_ads_status() async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Ads').child(widget.data.id).set(widget.data.toJson());
      toastMessage('Tắt bật ads thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.data.status == 0 ? 'Xác nhận bật quảng cáo' : 'Xác nhận tắt quảng cáo'),
      actions: <Widget>[
        loading ? CircularProgressIndicator(color: Colors.blueAccent,) : TextButton(
          onPressed: () async {
            if (widget.data.status == 0) {
              widget.data.pushTime = getCurrentTime();
              widget.data.status = 1;
              await change_ads_status();
              Navigator.of(context).pop();
            } else {
              widget.data.endTime = getCurrentTime();
              widget.data.status = 0;
              await change_ads_status();
              Navigator.of(context).pop();
            }
          },
          child: Text('Xác nhận', style: TextStyle(color:  Colors.blueAccent),),
        ),
      ],
    );
  }
}
