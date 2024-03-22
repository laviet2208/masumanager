import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../Data/adsData/restaurantAdsData.dart';

class delete_ads_dialog extends StatefulWidget {
  final restaurantAdsData data;
  const delete_ads_dialog({super.key, required this.data});

  @override
  State<delete_ads_dialog> createState() => _delete_ads_dialogState();
}

class _delete_ads_dialogState extends State<delete_ads_dialog> {
  bool loading = false;

  Future<void> delete_ads() async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Ads").child(widget.data.id).remove();
  }

  Future<void> deleteImage(String imagePath) async {
    final ref = FirebaseStorage.instance.ref().child(imagePath);
    try {
      await ref.delete();
      print('Xóa ảnh thành công: $imagePath');
    } catch (e) {
      print('Lỗi khi xóa ảnh: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Xóa quảng cáo'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            setState(() {
              loading = true;
            });
            await deleteImage('Ads/' + widget.data.id + '.png');
            await delete_ads();
            setState(() {
              loading = false;
            });
            Navigator.of(context).pop();
          },
          child: Text('Xác nhận xóa', style: TextStyle(color: Colors.blueAccent),),
        ),

        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
          child: Text('Hủy', style: TextStyle(color: Colors.redAccent),),
        ),
      ],
    );
  }
}
